import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maaaaaadi/control/core/cache-helper.dart';
import 'package:maaaaaadi/control/logic/main-app-provider.dart';
import 'package:maaaaaadi/view/screens/auth-screen.dart';
import 'package:maaaaaadi/view/screens/home-screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.cacheIntialization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> MainAppProvider()..gettingData())
    ],
    child: Consumer<MainAppProvider>(builder: (context , mainn ,_){
      print(' user token ===============> ${mainn.userToken}');
     return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:mainn.userToken==null? AuthScreeen():HomeScreen(),
      );
    },)
    );
  }
}

