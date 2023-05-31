import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAllUsersInformation extends StatefulWidget {
  const GetAllUsersInformation({Key? key}) : super(key: key);

  @override
  _GetAllUsersInformationState createState() => _GetAllUsersInformationState();
}

class _GetAllUsersInformationState extends State<GetAllUsersInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
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
