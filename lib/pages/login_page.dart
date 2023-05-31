import 'package:flutter/material.dart';
import 'package:flutter_demo_app2/components/my_button_login.dart';
import 'package:flutter_demo_app2/components/my_textfield.dart';
import 'package:flutter_demo_app2/components/square_tile.dart';
import 'package:flutter_demo_app2/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo_app2/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  bool isLogin = true;

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  void toast(BuildContext context,String text){
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(
          content: Text(text,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.tealAccent,
        ));
  }



  @override
  Widget build(BuildContext context) {

    Future<void> signInWithEmailAndPassword() async {
      try{
        await Auth().signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch(e){
        toast(context,e.message.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // logo
              Image.asset("assets/icons/cm.png",
                height: 55,
              ),
              const SizedBox(height: 5),
              const Icon(
                Icons.lock,
                size: 40,
              ),
              const SizedBox(height: 5),

              // welcome back, you've been missed!
              Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,

              ),

              const SizedBox(height: 5),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 5),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // sign in button
              MyButtonLogin(
                onTap: ()=>{
                  isLogin ? signInWithEmailAndPassword() :
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),

                  ),/*
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => HomePage(),
                  ),

                  ),*/
                }
              ),

              const SizedBox(height: 10),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 30),

                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 20),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    onPressed: ()=>{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),

                      ),
                    },
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
