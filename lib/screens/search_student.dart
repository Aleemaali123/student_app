// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/screens/home_screen.dart';

class SearchStudent extends StatefulWidget {
  // Function deleteIt;
  Function editIt;
  Function deleteIt;

  SearchStudent(
    this.deleteIt,
    this.editIt,
  );

  @override
  State<SearchStudent> createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  String? searchText; //variable to store search data
  List<StudentModel>? studentModelList =
      []; //initialized an empty array for search results
  DataBaseHelper db =
      DataBaseHelper(); // got the instance of database helper class
  static const royalBlue = 0xff246EE9;
  //*************** Functions****************** */

//function for changing the state of this screen when user searches
  void changeState() async {
    await db.createDatabase();
    studentModelList = await db.getStudentSearch(searchText);
    if(searchText==""){
      studentModelList=[];
    }
    setState(() {
      
    });
  }


//function that gets passed to edit screen and delete screen for changing the state of this page when user deletes or edits
  void searchResultEdit() async {
    await db.createDatabase();
    studentModelList = await db.getStudentSearch(searchText);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                        royalBlue,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  label: Text('Search student by name'),
                ),
                onChanged:  (value) {
                  
                    searchText = value;
                  changeState();
                  
                  
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: ElevatedButton(
                  onPressed: () {
                    changeState();
                  
                  },
                  child: Text("Search")),
            ),
                
            ...studentModelList!.map((e) {
              return HomeScreen(
                id: e.id!,
                name: e.name,
                marks: e.marks,
                status: e.status,
                standard: e.standard,
                rollNumber: e.rollNumber!,
                student: e,
                deleteIt: widget.deleteIt,
                editIt: widget.editIt,
                searchResultEdit: searchResultEdit,
                image: e.image,
              );
            })
          ],
        ),
      ),
    );
  }
}
