import 'package:cruddb/database.dart';
import 'package:flutter/material.dart';

class InsertStudent extends StatefulWidget {
  InsertStudent({super.key, this.map});

  Map? map;

  @override
  State<InsertStudent> createState() => _InsertStudentState();
}

class _InsertStudentState extends State<InsertStudent> {
  TextEditingController nameController = TextEditingController();
  // TextEditingController clgController = TextEditingController();
  TextEditingController cpiController = TextEditingController();

  MyDatabase db = MyDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text =widget.map?['name'] == null ? "" : widget.map!['name'];
    // clgController.text = widget.map?['clg'] == null ? "" : widget.map!['clg'].toString();
    cpiController.text = widget.map?['cpi'] == null ? "" : widget.map!['cpi'].toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.map==null ? "Insert" : "Update"} Student Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter your Name"),

          ),
          // TextFormField(
          //   controller: clgController,
          //   decoration: InputDecoration(hintText: "Enter your Collage"),
          // ),
          TextFormField(
            controller: cpiController,
            decoration: InputDecoration(hintText: "Enter marks"),

          ),
          ElevatedButton(
              onPressed: () {
                if (widget.map == null) {
                  db
                      .insertStudent(
                          name: nameController.text,
                          cpi: cpiController.text,)
                          // clg: clgController.text,
                      .then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  db
                      .updateStudent(
                          name: nameController.text,
                          // clg: clgController.text,
                          cpi: cpiController.text,
                          id: widget.map!['studentID'])
                      .then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
