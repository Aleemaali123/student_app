import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/screens/edit_student.dart';

import 'package:student_details_app/widgets/dropdown_button.dart';

class ViewStudent extends StatefulWidget {
  StudentModel studentModel;
  Function editIt;
  int id;
  String name;
  String marks;
  String rollNumber;
  String status;
  String studentClass;
  String image;
  ViewStudent({
    required this.studentModel,
    required this.editIt,
    required this.id,
    required this.name,
    required this.status,
    required this.rollNumber,
    required this.marks,
    required this.studentClass,
    required this.image,
  });
  @override
  State<ViewStudent> createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  changeIt(selectedValue) {
    setState(() {
      widget.status = selectedValue;
    });
    print(widget.status);
  }



  StudentModel? newStudent;

  void addNewStudent(String newId, String newName, String newClass,
       String newMarks) {
    newStudent = StudentModel(
      id: widget.id,
      rollNumber: widget.rollNumber,
      name: widget.name,
      standard: widget.studentClass,
      status: widget.status,
      marks: widget.marks,
    );
    widget.editIt(newStudent, widget.id);
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // nameController.value = TextEditingValue(text: widget.name);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Card(
                elevation: 10,
                // color: Colors.lightBlue,
                shadowColor: Color(MyApp.royalBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: studentImageGet(widget.image),
                        ),
                        onTap: () {
                          // takePhoto(ImageSource.camera);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.rollNumber,
                          // controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Student ID'),
                          ),
                          onChanged: (value) {
                            widget.rollNumber = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Name of Student'),
                          ),
                          onChanged: (value) {
                            widget.name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.studentClass,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Class of Student'),
                          ),
                          onChanged: (value) {
                            widget.studentClass = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.marks,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Mark of Student'),
                          ),
                          onChanged: (value) {
                            widget.marks = value;
                          },
                        ),
                      ),
                      DropDown(widget.status, changeIt),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditStudent(//Navigating to edit student upon request
                                        editIt: widget.editIt,
                                        studentModel: widget.studentModel,
                                        id: widget.id,
                                        name: widget.name,
                                        marks: widget.marks,
                                        rollNumber: widget.rollNumber,
                                        status: widget.status,
                                        studentClass: widget.studentClass,
                                        image: widget.image,
                                      )));
                        },
                        child: Text("Edit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

 Widget studentImageGet(base64String) {//function for converting the base64 string back into uint8List and image.memory displays it.
    if (base64String != null && base64String!=""){
      return Image.memory(base64Decode(base64String),
      fit: BoxFit.cover,);
    }
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child:Image(image: AssetImage("assets/user.png"),
      fit: BoxFit.fitHeight,)
    );
  }
}
