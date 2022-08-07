// // ignore_for_file: avoid_types_as_parameter_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../view_model/auth/auth_provider.dart';
// import '../login/login_screen.dart';

// class WelcomePage extends StatefulWidget {
//   WelcomePage({Key? key}) : super(key: key);

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   final TextEditingController firstname = TextEditingController();

//   final TextEditingController phone = TextEditingController();
//   final CollectionReference person =
//       FirebaseFirestore.instance.collection('add_person');

//   Future<void> update([DocumentSnapshot? documentSnapshot]) async {
//     if (documentSnapshot != null) {
//       firstname.text = documentSnapshot['name'];
//       phone.text = documentSnapshot['price'].toString();
//     }

//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: firstname,
//                   decoration: const InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   controller: phone,
//                   decoration: const InputDecoration(
//                     labelText: 'Price',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   child: const Text('Update'),
//                   onPressed: () async {
//                     final String name = firstname.text;
//                     final double? price = double.tryParse(phone.text);
//                     if (price != null) {
//                       await person
//                           .doc(documentSnapshot!.id)
//                           .update({"name": name, "price": price});
//                       firstname.text = '';
//                       phone.text = '';
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double hight = MediaQuery.of(context).size.height;

//     return StreamBuilder<User?>(
//       stream: context.watch<AuthProvider>().stream(),
//       builder: ((context, snapshot) {
//         if (!snapshot.hasData) return const LoginScreen();

//         return Scaffold(
//           body:
//               // Column(
//               //   children: [
//               // Container(
//               //   width: width,
//               //   height: hight * 0.3,
//               //   decoration: const BoxDecoration(
//               //       image: DecorationImage(
//               //           image: AssetImage("img/creta_page2.png"),
//               //           fit: BoxFit.cover)),
//               //   child: Column(
//               //     children: [
//               //       SizedBox(
//               //         height: hight * 0.20,
//               //       ),
//               //       CircleAvatar(
//               //         backgroundColor: Colors.grey[500],
//               //         radius: 40,
//               //         backgroundImage: const AssetImage("img/profile.png"),
//               //       )
//               //     ],
//               //   ),
//               // ),
//               // const SizedBox(
//               //   height: 30,
//               // ),
//               // Container(
//               //   margin: const EdgeInsets.only(left: 20, right: 20),
//               //   width: width,
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: const [
//               //       SizedBox(
//               //         height: 20,
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // const SizedBox(
//               //   height: 50,
//               // ),
//               // const Text(
//               //   "Welcome",
//               //   style: TextStyle(
//               //       fontSize: 36,
//               //       fontWeight: FontWeight.bold,
//               //       color: Colors.black),
//               // ),
//               StreamBuilder(
//                   stream: person.snapshots(),
//                   builder:
//                       (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//                     if (streamSnapshot.hasData) {
//                       return ListView.builder(
//                           itemCount: streamSnapshot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             final DocumentSnapshot documentsnapshot =
//                                 streamSnapshot.data!.docs[index];

//                             return Card(
//                                 child: ListTile(
//                               title: Text(documentsnapshot['firstname']),
//                               subtitle:
//                                   Text(documentsnapshot['phone'].toString()),
//                               trailing: SizedBox(
//                                 width: 100,
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           update(documentsnapshot);
//                                         },
//                                         icon: Icon(Icons.edit))
//                                   ],
//                                 ),
//                               ),
//                             ));
//                           });
//                     }

//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }),
//           // Text(
//           //   "hars@gmail.com",
//           //   style: TextStyle(fontSize: 15, color: Colors.grey[500]),
//           // ),
//           // const SizedBox(
//           //   height: 200,
//           // ),

// SizedBox(height: width * 0.15),
// SizedBox(
//   height: width * 0.08,
// ),
//   ],
// ),
//         );
//       }),
//     );
//   }
// }
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
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
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
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final int? price = int.tryParse(_priceController.text);
                    if (price != null) {
                      await _products.add({"firstname": name, "phone": price});

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
                      await _products
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
    await _products.doc(productId).delete();

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
              stream: _products.snapshots(),
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
                              subtitle:
                                  Text(documentSnapshot['phone'].toString()),
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
            floatingActionButton: FloatingActionButton(
              onPressed: () => _create(),
              child: const Icon(Icons.add),
            ),
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
