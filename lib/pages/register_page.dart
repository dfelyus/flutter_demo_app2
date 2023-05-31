import 'package:flutter/material.dart';
import 'package:flutter_demo_app2/components/my_button_register.dart';
import 'package:flutter_demo_app2/components/my_textfield.dart';
import 'package:flutter_demo_app2/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo_app2/auth.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final cpasswordController = TextEditingController();
  final addressController = TextEditingController();

  bool isRegistered = true;

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

    Future<void> createUserWithEmailAndPassword() async {
      try{
        await Auth().createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        toast(context,"Account created successfully ! You can login now...");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),

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
            children: [
              const SizedBox(height: 5),
              // logo
              Image.asset("assets/icons/cm.png",
                height: 55,
              ),
              const SizedBox(height: 5),
              const Icon(
                Icons.account_circle,
                size: 40,
              ),
              const SizedBox(height: 5),

              // welcome back, you've been missed!
              Text(
                'REGISTER',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,

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
              // cpassword textfield
              MyTextField(
                controller: cpasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              MyTextField(
                controller: addressController,
                hintText: 'Address',
                obscureText: false,
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: (){},
                      color: Colors.deepPurple,
                      child: Text("I am Farmer",style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(width: 10,),
                    MaterialButton(
                      onPressed: (){},
                      color: Colors.deepPurple,
                      child: Text("I am delivery",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),

              // sign in button
              MyButtonRegister(
                onTap: ()=>{
                  createUserWithEmailAndPassword(),
                }
              ),

              const SizedBox(height: 10),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I already have an Account.',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    onPressed: ()=>{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),

                      ),
                    },
                    child: Text(
                      "Login",
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
