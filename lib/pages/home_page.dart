import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app2/categories/callsms.dart';
import 'package:flutter_demo_app2/categories/profile.dart';
import 'package:flutter_demo_app2/categories/sell.dart';
import 'package:flutter_demo_app2/categories/track.dart';
import 'package:flutter_demo_app2/widgets/circle_button.dart';
import 'package:flutter_demo_app2/screens/Help.dart';
import 'package:flutter_demo_app2/screens/works.dart';
import 'package:flutter_demo_app2/screens/history.dart';
import 'package:flutter_demo_app2/screens/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo_app2/auth.dart';

class HomePage extends StatefulWidget{
  HomePage({Key ? key}) : super(key:key);



  Widget _title(){
    return const Text('Firebase Auth');
  }



  @override
  _HomePage createState(){
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SwicthScreeen(),
    Help(),
    Works(),
    History(),
    Account(),
  ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child:_widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          selectedItemColor:Colors.deepPurple,
          backgroundColor:Colors.black12,

          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset('assets/icons/house2.png',
                  height:25
              ),
              icon:Image.asset('assets/icons/house1.png',
                height:25,
              ),
              label:"Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset('assets/icons/help1.png',
                  height:30
              ),
              icon:Image.asset('assets/icons/help2.png',
                height:30,
              ),
              label:"Help",
            ),
            BottomNavigationBarItem(
              activeIcon:Image.asset('assets/icons/buy2.png',
                height:25,
              ),
              icon:Image.asset('assets/icons/buy1.png',
                  height:25
              ),
              label:"Works",
            ),
            BottomNavigationBarItem(
              activeIcon:Image.asset('assets/icons/hist2.png',
                height:25,
              ),
              icon:Image.asset('assets/icons/hist1.png',
                height:25,
              ),
              label:'History',
            ),
            BottomNavigationBarItem(
              activeIcon:Image.asset('assets/icons/account1.png',
                height:25,
              ),
              icon:Image.asset('assets/icons/account2.png',
                height:25,
              ),
              label:'Account',
            ),

          ],
          currentIndex: _selectedIndex,
          onTap:(int index){
            setState((){
              _selectedIndex = index;
            });
          }
      ),
    );
  }
}


class SwicthScreeen extends StatefulWidget {
  const SwicthScreeen({Key? key}) : super(key: key);

  @override
  State<SwicthScreeen> createState() => _SwicthScreeenState();
}

class _SwicthScreeenState extends State<SwicthScreeen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(),
          Body(),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {

  final User? user = Auth().currentUser;

  AppBar({
    Key? key,
  }):super(key: key);
  /*
  Widget _userUid(){
    return Text(user?.email ?? 'User email');
  }
  */

  @override
  Widget build(BuildContext context){
    return Container(
      padding:const EdgeInsets.only(top:30,left:20,right: 20),
      height: 175,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius:BorderRadius.only(
          bottomLeft:Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient:LinearGradient(
          //diagonal gradient
          begin:Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            //Color(0xff886ff2),
            //Color(0xff6849ef),
            Colors.greenAccent,
            Colors.black38,
            Colors.deepOrangeAccent,
          ],
        ),
      ),
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to, \n Farmer & Logistic",
                style: Theme.of(context).textTheme.titleLarge,textScaleFactor: 0.9,
              ),
              Column(
                children: [
                  CircleButton(icon: Icons.account_circle_rounded,
                      onPressed: (){}),
                  SizedBox(height: 4,),
                  Text("username",textScaleFactor: 0.7,),
                  Text(user?.email??"",style: TextStyle(fontSize: 8,color: Colors.deepPurple),)
                ],

              )
            ],
          ),
          const SizedBox(height: 12,),
          const Logo(),
        ],
      ),
    );
  }

}

class Logo extends StatelessWidget{
  const Logo({Key ? key,}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Container(
        height: 60,
        width: 230,

        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/icons/farmer1.png",
                height: 40,
              ),
            ),
            Center(child:
            Text("Farmer & Logistic",
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepPurple),
            ),
            ),
          ],
        )
    );
  }
}

class Body extends StatelessWidget{
  const Body({Key? key}):super(key:key);

  @override
  Widget build (BuildContext context){
    return Container(
      color: Colors.white12,
      /*
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icons/farmer1.png")
        ),
      ),
      */
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10,left:20,right:10),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Truck & Farmer Logistic",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: (){},
                  child: Text("See All",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color:Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),

          GridView(
            children: [
              Sell(),
              Track(),
              CallSms(),
              Profile(),
            ],
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 24,
            ),
          )
        ],
      ),
    );
  }
}