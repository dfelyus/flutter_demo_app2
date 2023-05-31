import 'package:flutter_demo_app2/auth.dart';
import 'package:flutter_demo_app2/pages/register_page.dart';
import 'package:flutter_demo_app2/pages/login_page.dart';
import 'package:flutter_demo_app2/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState()=> _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return LoginPage();
        }
      },
    );
  }
}