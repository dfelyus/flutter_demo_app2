import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class CallsmsDetails extends StatefulWidget {
  const CallsmsDetails({Key? key}) : super(key: key);

  @override
  _CallsmsDetails createState() => _CallsmsDetails();
}

class _CallsmsDetails extends State<CallsmsDetails> {
//---------------ADD DATA -----------------------------



  Future<String?> passCall()=>showDialog<String>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/icons/phone-call2.gif",
                height: 80,
              ),
              SizedBox(height: 6,),
              Text("Max well",style: TextStyle(color: Colors.deepPurple,fontSize: 15),),
              SizedBox(height: 4,),
              Text("Calling...",style: TextStyle(color: Colors.deepPurple,fontSize: 12),),
              SizedBox(height: 2,),
              Text("00:00:00",style: TextStyle(fontSize: 10),)
            ],
          )
        ),
        actions: [
          TextButton(onPressed: cancel,
              child: Text("CANCEL")),
        ],
      );
    },
  );

  void cancel(){
    Navigator.of(context).pop();
  }

  void toast(BuildContext context,String text){
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(
          content: Text(text,style: TextStyle(color: Colors.deepPurple),),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.tealAccent,
        ));
  }

  @override
  void initState(){
    super.initState();

  }

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('products').snapshots();

  //---------------RETRIEVE DATA -----------------------------


  TableRow buildRow(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Padding(
          padding: const EdgeInsets.all(12),
          child: MaterialButton(
            onPressed: ()async{
              final popup = await passCall();
            },
            child: MaterialButton(
              onPressed: (){},
              color: Colors.deepPurple,
              child: Text(cell,style: TextStyle(color: Colors.white,fontSize: 12),),
            ),
          )
      )).toList()
  );

  TableRow buildRowHead(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Container(
        color: Colors.deepOrangeAccent,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(cell,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
      )).toList()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.tealAccent,
        title: Text('Contacts delivery',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
        shape: Border.symmetric(horizontal: BorderSide.none),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(30.0)),
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Column(
                  children: [
                    Table(
                      border: TableBorder.all(),
                      children: [
                        buildRowHead(["Contacts with Delivery"]),
                      ],
                    ),
                    Container(
                      height:350,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("John Doe   :   +226 55 59 78",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 20,),
                                    MaterialButton(
                                      onPressed: ()async{
                                        final popup = await passCall();
                                      },
                                      color: Colors.white,
                                      child: Text("Call",style: TextStyle(color: Colors.deepPurple),),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("Arnaul Belt   :+226 14 95 19",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 20,),
                                    MaterialButton(
                                      onPressed: ()async{
                                        final popup = await passCall();
                                      },
                                      color: Colors.white,
                                      child: Text("Call",style: TextStyle(color: Colors.deepPurple),),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("Goerges W :+226 85 87 82",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 20,),
                                    MaterialButton(
                                      onPressed: ()async{
                                        final popup = await passCall();
                                      },
                                      color: Colors.white,
                                      child: Text("Call",style: TextStyle(color: Colors.deepPurple),),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("Alex Bileck : +226 47 01 36",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 20,),
                                    MaterialButton(
                                      onPressed: ()async{
                                        final popup = await passCall();
                                      },
                                      color: Colors.white,
                                      child: Text("Call",style: TextStyle(color: Colors.deepPurple),),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text("Max Well   : +226 28 48 96",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 20,),
                                    MaterialButton(
                                      onPressed: ()async{
                                        final popup = await passCall();
                                      },
                                      color: Colors.white,
                                      child: Text("Call",style: TextStyle(color: Colors.deepPurple),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: Row(
              children: [
                Text("call time :  "),
                Text("00:03:56",style: TextStyle(color: Colors.deepPurple,fontSize: 16),),
              ],
            ),
          )
        ],
      ),
    );


  }
}




