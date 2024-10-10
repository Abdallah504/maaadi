import 'package:flutter/material.dart';
import 'package:maaaaaadi/control/logic/main-app-provider.dart';
import 'package:provider/provider.dart';

class AuthScreeen extends StatefulWidget {
  const AuthScreeen({super.key});

  @override
  State<AuthScreeen> createState() => _AuthScreeenState();
}

class _AuthScreeenState extends State<AuthScreeen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppProvider>(
        builder: (context , provider , _){
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'Email'
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          controller: passController,
                          decoration: InputDecoration(
                              hintText: 'Password'
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(

                            onPressed: (){
                              if(emailController.text.isNotEmpty && passController.text.isNotEmpty){
                                provider.signUpWithEmail(email: emailController.text, pass: passController.text , context: context);
                              }else{
                                var snack = SnackBar(content:Text('please enter required fields') );
                                ScaffoldMessenger.of(context).showSnackBar(snack);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black
                            ),
                            child: Text('Sign up', style: TextStyle(color: Colors.white),)),
                        SizedBox(height: 10,),
                        ElevatedButton(

                            onPressed: (){
                              if(emailController.text.isNotEmpty && passController.text.isNotEmpty){
                                provider.signIn(email: emailController.text, pass: passController.text,context: context);
                              }else{
                                var snack = SnackBar(content:Text('please enter required fields') );
                                ScaffoldMessenger.of(context).showSnackBar(snack);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black
                            ),
                            child: Text('Login', style: TextStyle(color: Colors.white),))

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
