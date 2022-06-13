import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/Authentication/Sign_up/my_sign_up.dart';
import 'package:untitled19/constraint/style.dart';
import 'package:untitled19/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Getting Student all Records
  final Stream<QuerySnapshot> employeeRecords = FirebaseFirestore.instance.collection('users').snapshots();
  // For Deleting Users
  CollectionReference delUser = FirebaseFirestore.instance.collection('users');
  Future<void> _delete(id) {
    return delUser
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((_) => print('Something Error In Deleted User'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: employeeRecords,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something Wrong in HomePage');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Storing Data
          final List firebaseData = [];
          snapshot.data?.docs.map((DocumentSnapshot documentSnapshot) {
            Map store = documentSnapshot.data() as Map<String, dynamic>;
            firebaseData.add(store);
            store['id'] = documentSnapshot.id;
          }).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Crud Operation'.toUpperCase()),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySignUp(),
                        ),
                      );
                    },
                    child: const Text('Add'),
                  ),
                )
              ],
            ),
            body: Container(
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    1: FixedColumnWidth(150),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Name',
                                style: txt,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Email',
                                style: txt,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Action',
                                style: txt,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < firebaseData.length; i++) ...[
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  firebaseData[i]['userName'],
                                  style: txt2,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  firebaseData[i]['email'],
                                  style: txt2,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          docID: firebaseData[i]['uid'],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _delete(firebaseData[i]['uid']);
                                    //print(firebaseData);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ], //this is loop
                  ],
                ),
              ),
            ),
          );
        });
  }
}
