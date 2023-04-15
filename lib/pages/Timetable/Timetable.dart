import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../Homework/Homework.dart';



class Timetable_structure{
  String start_time;
  String end_time;
  String subject;

  Timetable_structure({required this.start_time,required this.end_time,required this.subject});


}


class TimeTable extends StatefulWidget {
  final String name;
  final String id;
  final String classID;
  const TimeTable({Key? key, required this.name, required this.id, required this.classID}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {

  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String weekday = '';
  String time = '';
  List <Timetable_structure> periods = [];
  late final Future myFuture;


  String name = 'Loading..';
  String id = 'Loading..';
  List <String> subjects = [];
  late int RollNo;
  late String classId;
  List <String> dates = [];








  Future getDate()  async {
    var date = DateTime.now();

    print(date.toString()); // prints something like 2019-12-10 10:02:22.287949
    print(DateFormat('EEEE').format(date)); // prints Tuesday
    print(DateFormat('EEEE, dmmyyyy').format(date)); // prints Tuesday, 10 Dec, 2019
    print(DateFormat('h:mm a').format(date));



    day = DateFormat('EEEE, d MMM, yyyy').format(date);
    day_2 = DateFormat('d MMM yyyy').format(date);
    time = DateFormat('h:mm a').format(date);
    weekday = DateFormat('EEEE').format(date);



  }

  Future getData() async{


    FirebaseFirestore.instance.collection('timetable').doc(widget.classID).collection(weekday).
    get().then((snapshots){
      snapshots.docs.forEach((element) {
        periods.add(
          Timetable_structure(
              start_time: element.data()['start'],
              end_time: element.data()['end'],
              subject: element.data()['subject']
          )
        );
      });
    }).then((_){
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  void initState() {
    getDate();
    myFuture = getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [Colors.lightBlueAccent,
                Colors.blueAccent,
                Colors.blueAccent,
                Colors.white
              ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,

          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25)
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.blueAccent ,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.blueAccent,
                                  blurRadius: 2.0
                              )
                            ]
                        ),
                        child: Center(
                          child: Text("",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black
                            ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(children: [
                Column(
                  children: [
                    Text(
                        "TimeTable",
                        style: GoogleFonts.nunito(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [



                                  Padding(
                                    padding: const EdgeInsets.only(right: 150,left: 40),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Date",
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w800
                                          ),),

                                        Row(
                                          children: [
                                            Text("$day",
                                              style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.w800
                                              ),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),



                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Divider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 4,
                                    ),
                                  ),






                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 90,right: 70),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(),
                                          child: Text("Time",
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15,
                                                color: Colors.blueAccent

                                            ),),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Subject",
                                                style: GoogleFonts.nunito(
                                                    color: Colors.blueAccent,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800
                                                ),),


                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),


                                  !isLoading ?  SizedBox(
                                    //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      width: MediaQuery.of(context).size.width * 0.92,
                                      child: FutureBuilder(
                                          future: myFuture,
                                          builder: (context,snapshot){
                                            return ListView.builder(
                                                itemCount: periods.length,
                                                itemBuilder: (context,index){
                                                  return Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  blurRadius: 2.8,
                                                                  spreadRadius: 0.5
                                                              )
                                                            ]
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [




                                                              Text(periods[index].start_time +
                                                                '-' + periods[index].end_time,
                                                                style: GoogleFonts.nunito(
                                                                    fontSize: 15,
                                                                    color: Colors.grey.shade800,
                                                                    fontWeight: FontWeight.w800
                                                                ),),


                                                              Text(periods[index].subject,
                                                                style: GoogleFonts.nunito(
                                                                    fontSize: 15,
                                                                    color: Colors.grey.shade800,
                                                                    fontWeight: FontWeight.w800
                                                                ),),



                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });}
                                      ) ) : Center(
                                      child: CircularProgressIndicator(

                                      )),







                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50,horizontal: 40),
                  height: 56,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 0.02),

                      ]),
                  child: Center(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Text(
                          '${widget.name}',
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text("ID: ${widget.id} | Student",
                            style: GoogleFonts.nunito(
                                fontSize: 11.5,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w600
                            ))
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
      ),
    );
  }
}
