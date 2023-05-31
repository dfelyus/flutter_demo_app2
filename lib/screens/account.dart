import 'package:flutter/material.dart';
import 'package:flutter_demo_app2/pages/login_page.dart';
import 'package:flutter_demo_app2/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {

  const Account({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  _Account createState() => _Account();
}

class _Account extends State<Account> {

  final User? user = Auth().currentUser;

  TableRow buildRow(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Padding(
          padding: const EdgeInsets.all(12),
          child: Text(cell,style: TextStyle(fontSize: 9,color: Colors.deepPurple),)
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

  Future<void> signOut() async {
    await Auth().signOut();
  }

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
              SizedBox(height: 7,),
              // welcome back, you've been missed!
              Text(
                'Account informations',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                child: CircleAvatar(
                  backgroundImage:AssetImage("assets/icons/prof1.jpeg") ,
                  radius: 50,

                ),
              ),

              const SizedBox(height: 5 ),
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
                    color: Colors.black12,
                    height:280,
                    child: ListView(
                      children: [
                        Table(
                          children: [
                            buildRow(["Username :","John Doe"]),
                            buildRow(["Email :",user?.email??"",]),
                            buildRow(["Contact :","+226 47 01 36"]),
                            buildRow(["Earning :","25.000 \$"]),
                            buildRow(["Balance account :","48.000 \$"]),
                            buildRow(["Truck pieces :","1, 8, 3, 12,..."]),
                            buildRow(["Work Done :","1, 2, 8, ...11"]),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 8),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stay connected.',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    onPressed: ()=>{
                      signOut(),
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
