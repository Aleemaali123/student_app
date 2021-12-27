// import 'package:flutter/material.dart';

// class InputText extends StatelessWidget {
//   String? name;
//   String? studentClass;
//   String? status;
//   String? marks;
  
//   final icon;
//   final text;
//    InputText(this.icon,this.text,{this.name, this.status,this.studentClass,this.marks});
//   static const royalBlue = 0xff246EE9;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
      
//                       padding: const EdgeInsets.only(
//                           left: 20, right: 20, top: 5, bottom: 5),
//                       child: TextField(
//                         keyboardType: TextInputType.name,
//                         decoration: InputDecoration(
//                           prefixIcon: icon,
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color(
//                                 royalBlue,
//                               ),
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           label: Text(text),
//                         ),
//                       ),
//                     );
//   }
// }