import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Works extends StatefulWidget {
  const Works({Key? key}) : super(key: key);

  @override
  _Works createState() => _Works();
}

class _Works extends State<Works> {


  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('products').snapshots();


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
        title: Text('Works',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
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
                        buildRowHead(["Product","Weight","Price","Delivery"]),
                      ],
                    ),
                    Container(
                      color: Colors.black12,
                      height:280,
                      child: ListView(
                        children: [
                          Table(
                            children: [
                              buildRow(["Tomatoes","27","15 \$","Emile B"]),
                              buildRow(["Oranges","47","36 \$","John K"]),
                              buildRow(["Apples","58","98 \$","Edward G"]),
                              buildRow(["Bananas","29","17 \$","Smith M"]),
                              buildRow(["Mangoes","35","85 \$","Thom B"]),
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




