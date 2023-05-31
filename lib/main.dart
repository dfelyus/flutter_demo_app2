import 'package:flutter_demo_app2/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app2/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  static int pageIndex = 0;
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: "farmer and logistic",
      theme: ThemeData(
        primarySwatch:Colors.blue,
        fontFamily:'Poppins',
        textTheme: const TextTheme(
          titleLarge:TextStyle(
            fontSize: 20,
            color:Colors.deepPurple,
            fontWeight:FontWeight.w500,
          ),
        ),

      ),

      //home: const BaseScreen2(),
      home:WidgetTree(),
    );
  }
}






//**************  db functions ********************************

/*
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app2/add_product.dart';
import 'package:flutter_demo_app2/get_filter_infos.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Flutter Firebase',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase'),
      ),
      //body: GetAllUsersInformation(),
      //body: const GetDocumentInfos("us1"),
      //body: const GetFilterInfos(),
      body: AddInfosDb("florine", 22, ["gv", "ff"]),
    );
  }
}
*/
/*
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconnect/get_collection_users_infos.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Flutter Firebase',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase'),
      ),
      body: const SingleChildScrollView(
        //child: GetUserName("us1"),
        //child: AddUser("DJAME FRANCK", 45),
        child: GetAllUsersInformation(),
      ),
    );
  }
}

 */
