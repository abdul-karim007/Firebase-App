import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  CollectionReference Users = FirebaseFirestore.instance.collection('Users');

  Future<void> deleteUser(docId) {
    return Users.doc(docId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  Future<void> updateUser(docID) {
  return Users
    .doc(docID)
    .update({'company': 'Stokes and Sons'})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: Users.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> abc =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(abc['full_name']),
                subtitle: Text(abc['age']),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          deleteUser(document.id);
                        });
                      },
                      icon: Icon(Icons.update),
                    ),
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: Icon(Icons.delete),
                    ), // icon-2
                  ],
                ),
              );
            }).toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
