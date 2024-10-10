


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maaaaaadi/control/core/cache-helper.dart';
import 'package:maaaaaadi/view/screens/home-screen.dart';

class MainAppProvider extends ChangeNotifier{
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;
final ImagePicker _picker = ImagePicker();
String? userToken;
String? emailUser;
var cache = CacheHelper();

bool _isLoading = false;
bool get isLoading => _isLoading;

String? _downloadUrl;
String? get downloadUrl => _downloadUrl;


gettingData(){
  userToken = cache.getData(key: 'token');
  print(userToken);
  gettingUserData();
  notifyListeners();
}
Future<void>gettingUserData()async{
  try{
    await _auth.currentUser!.email;
    emailUser= _auth.currentUser!.email;
    print('user email ========> ${_auth.currentUser!.email}');
  }catch(e){
    print('Error occurred =============> ${e}');
  }
  notifyListeners();
}

Future<void> signUpWithEmail({required String email , required String pass , context}) async{
  try{
    await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    await cache.setData(key: 'token', value: _auth.currentUser!.uid).then((value) {
      userToken = cache.getData(key: 'token');
      print(userToken);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });


  }catch(e){
    print('Error occurred =============> ${e}');
  }
  notifyListeners();
}

Future<void>signIn({required String email , required String pass , context})async{
  try{
    await _auth.signInWithEmailAndPassword(email: email, password: pass).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    });
  }catch(e){
    print('Error occurred =============> ${e}');
    var snack = SnackBar(content:Text('Invalid Data') );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
  notifyListeners();
}

Future<void> uploadData({required String title , required String desc,context})async{
  try{
    _isLoading = true;
    notifyListeners();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image !=null){
      final imageFile = File(image.path);
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();

      Reference storageRef = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      _downloadUrl = await snapshot.ref.getDownloadURL();

      Map<String , dynamic> data={
        'imageUrl':_downloadUrl,
        'title': title,
        'description': desc
      };

      await _firestore.collection('Data').doc('$userToken').set(data).then((value) {
        _isLoading = false;
        notifyListeners();
      });


    }else{
      _isLoading = false;
      notifyListeners();
      var snack =  SnackBar(content: Text('kindly choose an image'));
      ScaffoldMessenger.of(context).showSnackBar(snack);
      notifyListeners();
    }

  }catch(e){
    print('Error occurred =============> ${e}');

  }
  notifyListeners();
}


}