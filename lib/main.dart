import 'package:flutter/widgets.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/screens/add_student.dart';
import 'package:student_details_app/screens/home_screen.dart';
import 'package:student_details_app/screens/search_student.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  static const mintGreen = 0xff3EB489;
  static const scarletRed = 0xffFF2400;
  static const royalBlue = 0xff246EE9;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataBaseHelper db = DataBaseHelper();
  List<StudentModel>? studentModel2;
  List<StudentModel> studentModel3 = <StudentModel>[];





  void getStudentData() async {
    await db.createDatabase();
    studentModel2 = await db.getStudent();

    setState(() {});
  }




  void letState(StudentModel newStudent, context) async {
    final data = DataBaseHelper();
    await data
        .insertStudent(newStudent);
    studentModel2 = await db.getStudent();
    setState(() {});
    Navigator.pop(context);
  }


  void deleteIt(id) async {
    final db = DataBaseHelper();
    db.deleteStudent(
        id);
    studentModel2 = await db.getStudent();
    setState(() {});
  }


  void editIt(StudentModel student, int id) async {
    final db = DataBaseHelper();
    db.editStudent(
        student, id);
    studentModel2 = await db.getStudent();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    if (studentModel2 == null) {
      studentModel2 = <StudentModel>[];

      getStudentData();
    }

    return Builder(builder: (context) {
      return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Student Details'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(MyApp.royalBlue), Colors.white10],
                  ),
                ),
              ),
              centerTitle: true,
              elevation: 20,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),

                  Tab(
                    icon: Icon(Icons.search),
                    text: "Search",
                  )
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: TabBarView(children: [
              ListView(
                children: [
                  ...studentModel2!.map((e) {

                    return HomeScreen(
                      standard: e.standard,
                      rollNumber: e.rollNumber!,
                      marks: e.marks,
                      editIt: editIt,
                      student: e,
                      id: e.id!,
                      name: e.name,
                      status: e.status,
                      deleteIt: deleteIt,
                      image: e.image,
                    );
                  }).toList(),
                ],
              ),

              SearchStudent(deleteIt, editIt),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudent(letState),
                  ),
                );
              },
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Color(MyApp.royalBlue),
            ),
          ),
        ),
      );
    });
  }
}
