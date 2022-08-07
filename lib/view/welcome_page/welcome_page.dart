import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth/auth_provider.dart';
import '../login/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference products =
      FirebaseFirestore.instance.collection('abc');

  // Future<void> _create(DocumentSnapshot? documentSnapshot) async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               left: 20,
  //               right: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: _nameController,
  //                 decoration: const InputDecoration(labelText: 'firstname'),
  //               ),
  //               TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 controller: _priceController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'phone',
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Create'),
  //                 onPressed: () async {
  //                   final String name = _nameController.text;
  //                   final int? price = int.tryParse(_priceController.text);
  //                   if (price != null) {
  //                     await _products.add({"firstname": name, "phone": price});

  //                     _nameController.text = '';
  //                     _priceController.text = '';
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['firstname'];
      _priceController.text = documentSnapshot['phone'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'firstname'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'phone',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final int? price = int.tryParse(_priceController.text);
                    if (price != null) {
                      await products
                          .doc(documentSnapshot!.id)
                          .update({"firstname": name, "phone": price});
                      _nameController.text = '';
                      _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return const LoginScreen();

          return Scaffold(
            body: StreamBuilder(
              stream: products.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return Column(children: [
                    Container(
                      height: hight * 0.9,
                      width: width,
                      child: ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(documentSnapshot['firstname']),
                              subtitle: Text(documentSnapshot['phone']),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () =>
                                            _update(documentSnapshot)),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _delete(documentSnapshot.id)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      height: hight * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                              image: AssetImage("img/logintab2.png"),
                              fit: BoxFit.cover)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            context.read<AuthProvider>().signOut();
                            // Navigator.of(context).pushNamed("Signout");
                          },
                          child: const Text(
                            "Sign out",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]);
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => _create(),
            //   child: const Icon(Icons.add),
            // ),
          );

// Add new product
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () => _create(),
          //   child: const Icon(Icons.add),
        }));
    // );
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloa);
  }
}
