import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFilterInfos extends StatefulWidget {
  const GetFilterInfos({Key? key}) : super(key: key);

  @override
  _GetFilterInfosState createState() => _GetFilterInfosState();
}

class _GetFilterInfosState extends State<GetFilterInfos> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('users')
      //.where('age', isGreaterThan: 30)
      //.where('language', arrayContainsAny: ["uk", "ru"])
      //.limit(2)
      ////.orderBy("nom")
      ////.limit(3)
      //*.orderBy("nom")
      //*.limitToLast(3)
      .orderBy("nom", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['nom']),
              subtitle: Text(data['age'].toString()),
            );
          }).toList(),
        );
      },
    );
  }
}
