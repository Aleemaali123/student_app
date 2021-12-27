// import 'dart:io';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';

import 'package:student_details_app/widgets/dropdown_button.dart';

class EditStudent extends StatefulWidget {
  Function? searchResultEdit;
  StudentModel studentModel;
  Function editIt;
  int id;
  String name;
  String marks;
  String rollNumber;
  String status;
  String studentClass;
  String image;
  EditStudent(
      {this.searchResultEdit,
      required this.studentModel,
      required this.editIt,
      required this.id,
      required this.name,
      required this.status,
      required this.rollNumber,
      required this.marks,
      required this.studentClass,
      required this.image});
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  Widget studentImageGet(base64String) {
    if (base64String != null && base64String!="") {
      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
      );
    }
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child:Image(image: AssetImage("assets/user.png"),
      fit: BoxFit.fitHeight,)
    );
  }

  changeIt(selectedValue) {
    setState(() {
      widget.status = selectedValue;
    });
    print(widget.status);
  }

  // final ImagePicker _picker = new ImagePicker();

  StudentModel? newStudent;

//function

  void addNewStudent() {
    //creating a new student object to add to the data base after editing
    newStudent = StudentModel(
        id: widget
            .id, //id is needed else id will become null. It will not auto generate while editing
        rollNumber: widget.rollNumber,
        name: widget.name,
        standard: widget.studentClass,
        status: widget.status,
        marks: widget.marks,
        image: widget.image);
    widget.editIt(newStudent, widget.id);

    if (widget.searchResultEdit != null) {
      //checking this condition to know whether it is edited from search screen if it is set state of search screen
      widget.searchResultEdit!();
    }
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Card(
                elevation: 10,
                shadowColor: Color(MyApp.royalBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: path == null
                              ? studentImageGet(widget.image)
                              : imageLoad(),
                        ),
                        onTap: () {
                          takePhoto(ImageSource.gallery);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.rollNumber,
                          // controller: nameController,
                          keyboardType: TextInputType.number,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.studentClass,
                          keyboardType: TextInputType.number,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.marks,
                          keyboardType: TextInputType.number,
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
                        onPressed: () async {
                          
                          addNewStudent();
                          Navigator.pop(context);
                        },
                        child: Text("Save Edited"),
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

  var path;
  final ImagePicker _picker = new ImagePicker();
  XFile? images;
  var imageBytes;

  takePhoto(source) async {
    images = (await _picker.pickImage(
      source: source,
    ));
    if (images != null) {
      Uint8List imageBytes = await images!.readAsBytes();
      widget.image = base64Encode(imageBytes);
    }

    setState(() {
      if (images != null) {
        path = images!.path;
      }
    });
  }

  Widget imageLoad() {
    if (path != null) {
      return Image.file(File(path), fit: BoxFit.cover);
    } else
      return CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          "Add Photo",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
  }
}
