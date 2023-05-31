import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  _Buy createState() => _Buy();
}

class _Buy extends State<Buy> {
//---------------ADD DATA -----------------------------


  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('products').snapshots();


  //---------------RETRIEVE DATA -----------------------------


  TableRow buildRow(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: Text(cell,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: Colors.deepPurple),))
      )).toList()
  );

  TableRow buildRowHead(List<String> cells)=>TableRow(
      children: cells.map((cell)=>Container(
        color: Colors.deepOrangeAccent,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(child: Text(cell,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),))),
      )).toList()
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.tealAccent,
        title: Text('Buy',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
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
                        buildRowHead(["Offers","Weight","Price"]),
                      ],
                    ),
                    Container(
                      color: Colors.black12,
                      height:280,
                      child: ListView(
                        children: [
                          Table(
                            children: [
                              buildRow(["Tomatoes","27","15 \$"]),
                              buildRow(["Oranges","47","36 \$"]),
                              buildRow(["Apples","58","98 \$"]),
                              buildRow(["Bananas","29","17 \$"]),
                              buildRow(["Mangoes","35","85 \$"]),
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




