import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _History createState() => _History();
}

class _History extends State<History> {
  //---------------ADD DATA -----------------------------



  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('products').snapshots();

  //---------------RETRIEVE DATA -----------------------------


  TableRow buildRow(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: Text(cell,style: TextStyle(fontSize: 7,fontWeight: FontWeight.bold,color: Colors.deepPurple),))
      )).toList()
  );

  TableRow buildRowHead(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Container(
        color: Colors.deepOrangeAccent,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(child: Text(cell,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: Colors.white),))),
      )).toList()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.tealAccent,
        title: Text('History',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
        shape: Border.symmetric(horizontal: BorderSide.none),
      ),
      body: Column(
        children: [
          Container(
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
                        buildRowHead(["Date","Product","Weight","Price","Status"]),
                      ],
                    ),
                    Container(
                      color: Colors.black12,
                      height:280,
                      child: ListView(
                        children: [
                          Table(
                            children: [
                              buildRow(["11.05.2022","Tomatoes","27","15 \$","Done"]),
                              buildRow(["01.02.2019","Oranges","47","36 \$","Done"]),
                              buildRow(["18.09.2020","Apples","58","98 \$","Pending.."]),
                              buildRow(["20.10.2018","Bananas","29","17 \$","Done"]),
                              buildRow(["08.12.2021","Mangoes","35","85 \$","Pending.."]),
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

        ],
      ),
    );


  }
}




