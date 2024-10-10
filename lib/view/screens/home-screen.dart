import 'package:flutter/material.dart';
import 'package:maaaaaadi/control/logic/main-app-provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Consumer<MainAppProvider>(
       builder: (context , provider , _){
         return Scaffold(
           body: Center(
             child:provider.emailUser!=null?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: titleController,
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: descController,
                ),
                SizedBox(height: 15,),
                provider.isLoading==false?ElevatedButton(onPressed: (){
                  if(titleController.text.isNotEmpty && descController.text.isNotEmpty){
                    provider.uploadData(title: titleController.text, desc: descController.text,context: context);
                  }
                }, child: Text('upload')):
                    CircularProgressIndicator(
                      color: Colors.red,
                    )
              ],
            ):CircularProgressIndicator(
               color: Colors.red,
             ),
           ),
         );
       });
  }
}
