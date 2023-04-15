import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalAttendance extends StatefulWidget {
  final String StudentID;

   TotalAttendance({super.key, required this.StudentID});
  @override
  State<TotalAttendance> createState() => _TotalAttendanceState();
}

class _TotalAttendanceState extends State<TotalAttendance> {

  bool isLoading = true;

  var data;

  getInfo() async{

    FirebaseFirestore.instance.collection('students').where('id',isEqualTo: widget.StudentID).get()
        .then((snapshot){
       snapshot.docs.forEach((element) {
         setState(() {
           data = element.data();
           isLoading = false;
         });
       });
    });

  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !isLoading ? Column(
        children: [
          Text(data['Attendance_percent'].toString().substring(0,4) ?? 'Loading'),
          Text(data['Attended'].toString() ?? 'Loading'),
          Text(data['TotalClasses'].toString() ?? 'Loading')
        ],
      ) : CircularProgressIndicator(),
    );
  }
}
