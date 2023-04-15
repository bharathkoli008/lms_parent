import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class SubjectAttendance{
  String name;
  double percent;
  int present;
  int total;

  SubjectAttendance({ required this.name,required this.percent,required this.present,required this.total});
}

class Todays_attendance{
  String name;
  String status;

  Todays_attendance({required this.name, required this.status });

}

class Attendance_page extends StatefulWidget {
  final String name;
  final String id;
  final List<String> subjects;
  final String Classid;
  final int RollNo;
  Attendance_page({required this.name,required this.id,required this.subjects, required this.Classid, required this.RollNo});

  @override
  State<Attendance_page> createState() => _Attendance_pageState();
}

class _Attendance_pageState extends State<Attendance_page> {

  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String time = '';
  List <String> absentdays = [];
  late final Future myFuture;
  List <Todays_attendance> today = [];

  late List<SubjectAttendance> subs = List.generate(widget.subjects.length, (i) => SubjectAttendance(
      name: '',
      percent: 0.0,
      present: 0,
      total: 0));



  void getDate()  {
    var date = DateTime.now();

    print(date.toString()); // prints something like 2019-12-10 10:02:22.287949
    print(DateFormat('EEEE').format(date)); // prints Tuesday
    print(DateFormat('EEEE, dmmyyyy').format(date)); // prints Tuesday, 10 Dec, 2019
    print(DateFormat('h:mm a').format(date)); //
    day = DateFormat('EEEE, d MMM, yyyy').format(date);
    day_2 = DateFormat('d MMM yyyy').format(date);
    time = DateFormat('h:mm a').format(date);

  }

  Future getData() async{


  for(int i = 0; i< widget.subjects.length ; i++){

    await FirebaseFirestore.instance.collection('subjects').where('Subject_Id',isEqualTo: widget.subjects[i]).get()
    .then((snapshot) {
      snapshot.docs.forEach((element) {
        subs[i].name = element.data()['Subject_Name'] as String;
      });
    });

    await FirebaseFirestore.instance.collection('attendance').doc(widget.Classid).collection(widget.subjects[i]).get()
        .then((snapshots) => {
          snapshots.docs.forEach((element) {
            bool temp = false;
            subs[i].total++;
            subs[i].present++;
          print(element.data()['Absentees'].length);
          for(int j = 0; j < element.data()['Absentees'].length ; j++){

            if( widget.RollNo.toString() == element.data()['Absentees'][j].toString()){
              subs[i].present--;
              temp = true;
            }
          }

          if(element.data()['date'].toString() == day_2){
            today.add(Todays_attendance(
                name: subs[i].name,
                status: temp ? 'Absent ' : 'Present'
            ));
          }

          })
    });

    subs[i].percent = subs[i].present/subs[i].total * 100;
  }




  setState(() {
    isLoading = false;
  });


  }



  @override
  void initState() {
    myFuture = getData();
    getDate();
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



          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.transparent,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                spreadRadius:0.009),

                          ]),
                      child: Text(
                          "Attendance",
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          )
                      ),
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

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 58),
                                        child: Text("Subject",
                                          style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: Colors.blueAccent

                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 40
                                        ),
                                        child: Text("Present%",
                                          style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                              color: Colors.blueAccent

                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Present",
                                              style: GoogleFonts.nunito(
                                                  color: Colors.blueAccent,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                            Text("Classes",
                                              style: GoogleFonts.nunito(
                                                  color: Colors.blueAccent,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w800
                                              ),),

                                          ],
                                        ),
                                      ),

                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                  style: GoogleFonts.nunito(
                                      color: Colors.blueAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800
                                  ),),
                                Text("Classes",
                                  style: GoogleFonts.nunito(
                                      color: Colors.blueAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800
                                  ),),

                              ],
                            ),
                          ),
                                    ],
                                  ),
                                  !isLoading ? Container(
                                    //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
                                    height: MediaQuery.of(context).size.height * 0.4,
                                    width: MediaQuery.of(context).size.width * 0.96,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 0,
                                              spreadRadius: 0.5
                                          )
                                        ]
                                    ),
                                    child: FutureBuilder(
                                      future: myFuture,
                                            builder: (context,snapshot){
                                       return ListView.builder(
                                          itemCount: widget.subjects.length,
                                          itemBuilder: (context,index){
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 5,top: 10,left: 25,right: 25),
                                              child: Container(
                                                height: MediaQuery.of(context).size.height * 0.051,

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
                                                  padding: const EdgeInsets.only(),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                     Text(subs[index].name,
                                                     style: GoogleFonts.nunito(
                                                       fontSize:13.5,
                                                       color: Colors.black,
                                                       fontWeight: FontWeight.w800
                                                     ),),
                                                     Text(subs[index].percent.toString().substring(0,4),
                                                       style: GoogleFonts.nunito(
                                                           fontSize:13.5,
                                                           color: Colors.black,
                                                           fontWeight: FontWeight.w800
                                                       ),),
                                                     Text(subs[index].present.toString(),
                                                       style: GoogleFonts.nunito(
                                                           fontSize:13.5,
                                                           color: Colors.black,
                                                           fontWeight: FontWeight.w800
                                                       ),),
                                                     Text(subs[index].total.toString(),
                                                       style: GoogleFonts.nunito(
                                                           fontSize:13.5,
                                                           color: Colors.black,
                                                           fontWeight: FontWeight.w800
                                                       ),)
                                                   ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });}
                                    ),
                                  ) : Center(
                                      child: CircularProgressIndicator(

                                      )),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 130,top: 35,bottom: 10),
                                    child: Text("Today's Attendance",
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color: Colors.black
                                    ),),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Divider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 4,
                                    ),
                                  ),



                                  Padding(
                                    padding: const EdgeInsets.only(top: 15,bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 80),
                                          child: Text("Subject",
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.blueAccent

                                            ),),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 100),
                                          child: Text("Status",
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.blueAccent

                                            ),),
                                        ),

                                      ],
                                    ),
                                  ),


                                  !isLoading ?  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
                                        height: MediaQuery.of(context).size.height * 0.4,
                                        width: MediaQuery.of(context).size.width * 0.96,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 0,
                                                  spreadRadius: 0.5
                                              )
                                            ]
                                        ),
                                        child: FutureBuilder(
                                            future: myFuture,
                                            builder: (context,snapshot){
                                              return ListView.builder(
                                                  itemCount: today.length,
                                                  itemBuilder: (context,index){
                                                    return Padding(
                                                      padding: const EdgeInsets.only(bottom: 5,top: 10,left: 25,right: 25),
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height * 0.051,

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
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Text(today[index].name,
                                                              style: GoogleFonts.nunito(
                                                                  fontSize:13.5,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w800
                                                              ),),

                                                            Text(today[index].status,
                                                              style: GoogleFonts.nunito(
                                                                  fontSize:13.5,
                                                                  color: today[index].status == 'Present' ? Colors.green
                                                                  : Colors.red,
                                                                  fontWeight: FontWeight.w800
                                                              ),)
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });}
                                        ) ),
                                  ) : Center(
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
                )
              ]),
            ),
          )
      ),
    );
  }
}
