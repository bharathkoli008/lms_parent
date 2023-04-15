import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lms_parent/pages/Homework/HomeworkView.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeWork_strucure {
  String date;
  String name;
  String deadline;
  bool status;
  String desc;
  String doclink;
  String refid;

  HomeWork_strucure({required this.name,required this.doclink,
    required this.date,required this.deadline,
    required this.status,required this.desc,required this.refid});
}


class HomeWork extends StatefulWidget {
  final String name;
  final String id;
  final String Classid;
  final int RollNo;
  final List<String> Subids;
  HomeWork({required this.name,required this.id,required this.Classid, required this.RollNo,required this.Subids});

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {

  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String time = '';
  List <HomeWork_strucure> homeworks = [];

  late final Future myFuture;
  late SharedPreferences sharedPreferences;
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

    for(int i = 0; i < 7 ; i++){
      var temp = date.subtract(Duration(days: i));
      dates.add(DateFormat('d MMM yyyy').format(temp));
    }

    getData();

  }



  Future getData() async{
    
    for(int i = 0; i < dates.length; i++){
      print('hello');
      await FirebaseFirestore.instance.collection('homework').doc(widget.Classid).collection(dates[i]).get()
          .then((snapshots) {

            snapshots.docs.forEach((element) {
              homeworks.add(
                HomeWork_strucure(
                    name: element.data()['name'],
                    status: element.data()['read'][widget.RollNo],
                    date: element.data()['day'],
                    doclink: element.data()['doclink'],
                    desc: element.data()['description'],
                    deadline: element.data()['deadline'],
                  refid: element.reference.id
                )
              );
            });
      });
    }

    setState(() {
      isLoading = false;
    });
    
  }

  void read(HomeWork_strucure homework) async {
    List<dynamic> temp = [];
   await FirebaseFirestore.instance.collection('homework').doc(widget.Classid).collection(homework.date).doc(
      homework.refid).get().
    then((snapshot){
       temp =  snapshot.data()!['read'];
       temp[widget.RollNo] = true;
   }).then((_) async {
     await FirebaseFirestore.instance.collection('homework').doc(widget.Classid).collection(homework.date).doc(
       homework.refid
     ).update({
       'read':temp
     });
   });

  }


  @override
  void initState() {
    myFuture = getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [

                Colors.lightBlueAccent,
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
                    Text(
                        "Homework",
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



                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 70,left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Date",
                                              style: GoogleFonts.nunito(
                                                  fontSize: 20,
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold
                                              ),),

                                            Row(
                                              children: [
                                                Text("$day",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold
                                                  ),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5),
                                                  child: Container(
                                                    height: 15,
                                                    child: Image
                                                        .asset(
                                                        'lib/assets/unread.png'),
                                                  ),
                                                ),

                                                Text('Unread',
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 13,
                                                        color: Colors.grey.shade800,
                                                        fontWeight: FontWeight.bold
                                                    ))
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5),
                                                  child: Container(
                                                    height: 15,
                                                    child: Image
                                                        .asset(
                                                        'lib/assets/read.png'),
                                                  ),
                                                ),

                                                Text('Read',
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 13,
                                                        color: Colors.grey.shade800,
                                                        fontWeight: FontWeight.bold
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),





                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Divider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 4,
                                    ),
                                  ),




                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Stat",
                                          style: GoogleFonts.nunito(
                                              color: Colors.transparent,
                                              fontSize: 5,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        Text("Date",
                                          style: GoogleFonts.nunito(
                                              color: Colors.blueAccent,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        Text("Subject",
                                          style: GoogleFonts.nunito(
                                              color: Colors.blueAccent,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        Text("Deadline",
                                          style: GoogleFonts.nunito(
                                              color: Colors.blueAccent,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),

                                      ],
                                    ),
                                  ),


                                  !isLoading ?  SizedBox(
                                    //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      child: FutureBuilder(
                                          future: myFuture,
                                          builder: (context,snapshot){
                                            return ListView.builder(
                                                itemCount: homeworks.length,
                                                itemBuilder: (context,index){
                                                  return Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: GestureDetector(
                                                      onTap: () async {

                                                        read(homeworks[index]);


                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type: PageTransitionType.fade,
                                                              alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
                                                              child: HomeworkView(
                                                                  name: widget.name,
                                                                  id: widget.id,
                                                                  homework: homeworks[index])
                                                          ),);
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 20,bottom: 20),
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [


                                                                Container(
                                                                  height: 15,
                                                                  child: Image
                                                                  .asset(
                                                                     homeworks[index].status ?
                                                                      'lib/assets/read.png' :
                                                                     'lib/assets/unread.png'),
                                                                ),

                                                                Text(homeworks[index].date,
                                                                style: GoogleFonts.nunito(
                                                                  fontSize: 15,
                                                                  color: Colors.grey.shade800,
                                                                  fontWeight: FontWeight.w600
                                                                ),),

                                                                Text(homeworks[index].name,
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize: 15,
                                                                      color: Colors.grey.shade800,
                                                                      fontWeight: FontWeight.w600
                                                                  ),),

                                                                Text(homeworks[index].deadline,
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize: 15,
                                                                      color: Colors.grey.shade800,
                                                                      fontWeight: FontWeight.w600
                                                                  ),),



                                                              ],
                                                            ),
                                                          ),
                                                        )
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
                  margin: EdgeInsets.only(top: 60, left: 65),
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 2.0)
                      ]),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Text(
                          widget.name,
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text("ID ${widget.id} | Student",
                            style: GoogleFonts.nunito(
                                fontSize: 13,
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

