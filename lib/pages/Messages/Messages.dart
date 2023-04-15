import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Homework/Homework.dart';


class Message_strucure {
  String msg;
  String from;
  String date;
  String time;

  Message_strucure({
   required this.msg,required this.from,
    required this.date, required this.time
});

}



class Messages extends StatefulWidget {
  final String name;
  final String id;
  final String Classid;
  final int RollNo;
  Messages({required this.name,required this.id,required this.Classid, required this.RollNo});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String time = '';
  List <Message_strucure> messages = [];

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


      await FirebaseFirestore.instance.collection('messages').doc(widget.Classid).collection(widget.RollNo.toString()).get()
          .then((snapshots) {
        snapshots.docs.forEach((element) {
          messages.add(
              Message_strucure(
                  msg: element.data()['message'],
                  from: element.data()['from'],
                  date: element.data()['date'],
                  time: element.data()['time'],

              )
          );
        });
      });


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
                          "Personal Messages",
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



                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(

                                              children: [
                                                Text("Date",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 20,
                                                      color: Colors.blueAccent,
                                                      fontWeight: FontWeight.w800
                                                  ),),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 200),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 15,
                                                        child: Image
                                                            .asset(
                                                            'lib/assets/unread.png'),
                                                      ),

                                                      Text('Unread',
                                                          style: GoogleFonts.nunito(
                                                              fontSize: 13,
                                                              color: Colors.grey.shade800,
                                                              fontWeight: FontWeight.bold
                                                          ))
                                                    ],
                                                  ),
                                                ),


                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("$day",
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 15,
                                                      color: Colors.grey.shade700,
                                                      fontWeight: FontWeight.w800
                                                  ),),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 80),
                                                  child: Row(
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
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),





                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Divider(
                                      thickness: 2,
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

                                        Text("Msg",
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
                                                itemCount: messages.length,
                                                itemBuilder: (context,index){
                                                  return Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: GestureDetector(
                                                      onTap: () async {


                                                      },
                                                      child: Card(
                                                          elevation: 5,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 20,bottom: 20),
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [


                                                                      // Container(
                                                                      //   height: 15,
                                                                      //   child: Image
                                                                      //       .asset(
                                                                      //       messages[index].status ?
                                                                      //       'lib/assets/read.png' :
                                                                      //       'lib/assets/unread.png'),
                                                                      // ),



                                                                      Text(messages[index].date,
                                                                        style: GoogleFonts.nunito(
                                                                            fontSize: 12,
                                                                            color: Colors.grey.shade800,
                                                                            fontWeight: FontWeight.w600
                                                                        ),),

                                                                      Text(messages[index].time,
                                                                        style: GoogleFonts.nunito(
                                                                            fontSize: 12,
                                                                            color: Colors.grey.shade800,
                                                                            fontWeight: FontWeight.w600
                                                                        ),),

                                                                      Text(messages[index].from,
                                                                        style: GoogleFonts.nunito(
                                                                            fontSize: 15,
                                                                            color: Colors.grey.shade800,
                                                                            fontWeight: FontWeight.w600
                                                                        ),),





                                                                    ],
                                                                  ),

                                                                  Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(right: 250,top: 20),
                                                                        child: Text('Message',
                                                                          style: GoogleFonts.nunito(
                                                                              fontSize: 11,
                                                                              color: Colors.grey.shade800,
                                                                              fontWeight: FontWeight.w700
                                                                          ),),
                                                                      ),
                                                                      Text(messages[index].msg,
                                                                          style: GoogleFonts.nunito(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.shade800,
                                                                              fontWeight: FontWeight.w700
                                                                          )
                                                                      )
                                                                    ],
                                                                  ),
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

