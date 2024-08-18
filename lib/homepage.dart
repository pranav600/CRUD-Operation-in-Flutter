import 'package:cruddb/database.dart';
import 'package:cruddb/insertStudent.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Data"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: db.copyPasteAssetFileToRoot(),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            return FutureBuilder(
              future: db.getDataFromStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return InsertStudent(map: snapshot.data![index],);
                            },)).then((value) {
                              setState(() {

                              });
                            });
                          },
                          tileColor: Colors.blue,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index]["name"].toString(),
                                  style: TextStyle(fontSize: 25)),
                              // Text(snapshot.data![index]["clg"].toString()),
                              Text(snapshot.data![index]["cpi"].toString())
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min, // Ensure tight packing of icons
                            children: [
                              IconButton(
                                onPressed: () => {}, // Implement edit functionality here
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text('Are you sure ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false), // Cancel
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true); // Yes
                                          db
                                              .deleteStudent(int.parse(snapshot.data![index]['studentID'].toString()))
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                                ),
                                icon: Icon(Icons.delete, color: Colors.black),
                              ),
                            ],
                          ),

                          // trailing: IconButton(
                          //   onPressed: () => showDialog<bool>(
                          //     context: context,
                          //     builder: (BuildContext context) => AlertDialog(
                          //       title: Text('Confirm Delete'),
                          //       content: Text('Are you sure you want to delete this student?'),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           onPressed: () => Navigator.pop(context, false), // Cancel
                          //           child: Text('Cancel'),
                          //         ),
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.pop(context, true); // Yes
                          //             db
                          //                 .deleteStudent(int.parse(snapshot.data![index]['studentID'].toString()))
                          //                 .then((value) {
                          //               setState(() {});
                          //             });
                          //           },
                          //           child: Text('Yes'),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   icon: Icon(Icons.delete, color: Colors.redAccent),
                          // ),

                        ),
                      );
                    },
                  );
                } else {
                  return Text("No Data Found");
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return InsertStudent();
            },
          )).then((value) {
            setState(() {

            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
