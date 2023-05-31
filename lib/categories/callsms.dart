import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app2/screens/callsms_details.dart';
class CallSms extends StatefulWidget{
  //final Category category;
  //final int index;
  const CallSms({
    Key?key,
  }):super(key:key);

  @override
  State<CallSms> createState() => _CallSms();
}

class _CallSms extends State<CallSms> {
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => {

        //set up the current category corresponding with the index
        setState(() {
          //MyApp.pageIndex = widget.index;
        }),
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallsmsDetails(),
          ),

        ),
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.tealAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .06,
            ), //BoxShadow
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/icons/sms-call2.jpeg",
                height: 55,
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Text("sms/call",style: TextStyle(fontSize: 14),),
            Text("delivery contact",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

