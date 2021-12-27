import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/widgets/dropdown_button.dart';


class AddStudent extends StatefulWidget {
  // final studentModel;
  Function letState;
  AddStudent(this.letState);
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  String? currentItemSelected;

  changeIt(selectedValue) {
    setState(() {
      this.currentItemSelected = selectedValue;
    });
  }

  String? rollNumber;
  String? name;
  String? studentClass;
  String? status;
  String? marks;

  StudentModel? newStudent;

  void addNewStudent(String newId, String newName, String newClass,
      String newStatus, String newMarks, String base64Image) {
    // print("add checking $base64Image");
    newStudent = StudentModel(
      rollNumber: newId,
      name: newName,
      standard: newClass,
      status: newStatus,
      marks: newMarks,
      image: base64Image,
    );
    widget.letState(newStudent,
        context); //calling a function in mainscreen for to set its state as well as tha function inserts student
    //  print("checking $base64Image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.grey,
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Card(
                  // elevation: 50,
                  // shadowColor: Color(MyApp.royalBlue),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          // clipBehavior: Clip.hardEdge,
                          height: 100,
                          width: 100,
                          child: Center(
                            child: InkWell(
                              child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,

                                  ),
                                  child: imageLoad()),
                              onTap: () {
                                takePhoto(ImageSource.gallery);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              rollNumber = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              name = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              label: Text('Class'),
                            ),
                            onChanged: (value) {
                              studentClass = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              label: Text('Mark'),
                            ),
                            onChanged: (value) {
                              marks = value;
                            },
                          ),
                        ),
                        DropDown(currentItemSelected,
                            changeIt), //dropdown button coded in another page and currentItemSelected is used to set the value of the button on refreshing
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              addNewStudent(
                                  rollNumber!,
                                  name!,
                                  studentClass!,
                                  currentItemSelected!,
                                  marks!,
                                  base64Image!); // calls a function to create student object with given data
                            }
                          },
                          child: Text("Add Student"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }


/*Functions for converting Xfile into base64String*/

  var path;
  final ImagePicker _picker = new ImagePicker();
  XFile? images;
  var imageBytes;
  String? base64Image= "";

  takePhoto(source) async {//function that picks the photo from storage and converts to base64
    images = await _picker.pickImage(
      source: source,
    );

    if (images != null ) {
      Uint8List imageBytes = await images!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    setState(() {
      if (images != null) {//it is used to load an image from path temperorly for user experience
        path = images!.path;
      }
    });
  }

  Widget imageLoad() {//loading image from path
    if (path != null) {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
      );
    } else
       return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child:Image(image: AssetImage("assets/user.png"),
      fit: BoxFit.fitHeight,)
    );
  }
}
