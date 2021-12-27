import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/widgets/dropdown_button.dart';

class AddStudentTab extends StatefulWidget {
 final Function letState;
  AddStudentTab(this.letState);
  @override
  State<AddStudentTab> createState() => _AddStudentTabState();
}

class _AddStudentTabState extends State<AddStudentTab> {
  final _formKey = GlobalKey<FormState>();
  String? currentItemSelected;
  changeIt(selectedValue) {
    setState(() {
      this.currentItemSelected = selectedValue;
    });
    print(currentItemSelected);
  }

  final ImagePicker _picker = new ImagePicker();
  
  String? rollNumber;
  String? name;
  String? studentClass;
  String? status;
  String? marks;


  StudentModel? newStudent;

  void addNewStudent(String newId, String newName, String newClass,
      String newStatus, String newMarks,String base64Image) {
    newStudent = StudentModel(
      rollNumber: newId,
      name: newName,
      standard: newClass,
      status: newStatus,
      marks: newMarks,
      image: base64Image,
    );
    widget.letState(newStudent, context);

 
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Form(
          key: _formKey,
          
          child: ListView(children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height*0.8,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  children: [Card(
                    elevation: 10,
                    // color: Colors.lightBlue,
                    shadowColor: Color(MyApp.royalBlue),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle
                          ),
                          clipBehavior: Clip.hardEdge,
                          height: 100,
                          width:100,
                          child: Center(
                            child: InkWell(
                              child: 
                               imageLoad(),
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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required field";
                                }
                                return null;
                              },
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
                                rollNumber = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required field";
                                }
                                return null;
                              },
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
                                studentClass = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required field";
                                }
                                return null;
                              },
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
                                marks = value;
                              },
                            ),
                          ),
                          // DropDown(currentItemSelected, changeIt),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                addNewStudent(rollNumber!, name!, studentClass!,
                                    currentItemSelected!, marks!,base64Image!);
                              }
                            },
                            child: Text("Add Student"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

    XFile? images;
  var imageBytes;
  String? base64Image;
  var path;

  takePhoto(source) async {
     images = (await _picker.pickImage(
      source: source,
      
    ));
    if(images!=null){
    Uint8List imageBytes = await images!.readAsBytes();
     base64Image= base64Encode(imageBytes);
     print(base64Image);
    }
    

    setState(() {
      path = images!.path;
    });
  }
  Widget imageLoad(){
    if (path!=null){
     return Image.file(File(path),
     fit: BoxFit.cover,);
    }
    else return CircleAvatar(
      backgroundColor: Colors.blue,
      radius: 60,
    );
  }
}

