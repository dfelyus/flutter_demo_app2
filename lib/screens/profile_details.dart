import 'package:flutter/material.dart';
import 'package:flutter_demo_app2/components/my_button_back.dart';
import 'package:flutter_demo_app2/pages/home_page.dart';
import 'package:flutter_demo_app2/pages/login_page.dart';
import 'package:flutter_demo_app2/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileDetails extends StatelessWidget {
  ProfileDetails({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  TableRow buildRow(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Padding(
          padding: const EdgeInsets.all(12),
          child: Text(cell)
      )).toList()
  );

  TableRow buildRowHead(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Container(
        color: Colors.deepOrangeAccent,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(cell,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)),
      )).toList()
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 10,),
              Text(
                'Farmer Tracking',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10,),
              // welcome back, you've been missed!
              Text(
                'profile informations',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 80,
                child: CircleAvatar(
                  backgroundImage:AssetImage("assets/icons/prof1.jpeg") ,
                  radius: 50,

                ),
              ),

              const SizedBox(height: 10),
              // google + apple sign in buttons
            Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  children: [
                    //buildRowHead(["Delivery","Contacts"]),
                  ],
                ),
                Container(
                  height:200,
                  child: ListView(
                    children: [
                      Table(
                        children: [
                          buildRow(["Username :","John Doe"]),
                          buildRow(["Email :",user?.email??"",]),
                          buildRow(["Contact :","+226 47 01 36"]),
                          buildRow(["Earning :","25.000\$"]),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

              const SizedBox(height: 20),
              // sign in button
              MyButtonBack(
                  onTap: ()=>{
                    signOut(),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),

                    ),
                  }
              ),
              const SizedBox(height: 20),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stay connected',
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
                      "Logout",
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
