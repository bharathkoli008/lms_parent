import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Notice{
  String date;
  String time;
  String subject;
  String doclink;
  String desc;

  Notice({required this.date,required this.time,required this.desc,required this.subject,required this.doclink});
}


class Notices extends StatefulWidget {
  const Notices({Key? key}) : super(key: key);

  @override
  State<Notices> createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {


  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String time = '';
  List <Notice> notices = [];

  late final Future myFuture;
  late SharedPreferences sharedPreferences;
  String name = 'Loading..';
  String id = 'Loading..';
  List <String> subjects = [];
  late int RollNo;
  late String classId;




  getName() async{
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('id') as String;

    FirebaseFirestore.instance.collection('students').where('id',isEqualTo: id).get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {

        setState(() {
          name =  element.data()['Name'] ;
          id = sharedPreferences.getString('id') as String;
        });
      });
    });
  }



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

    await FirebaseFirestore.instance.collection('notices').get()
        .then((snapshots){
          snapshots.docs.forEach((element) {
            notices.add(
              Notice(
                  date: element.data()['date'],
                  time: element.data()['time'],
                  desc: element.data()['description'],
                  subject: element.data()['subject'],
                  doclink: element.data()['doclink']
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
    myFuture = getData();
    getDate();
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(
          backgroundColor: Colors.transparent,



          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(children: [
                Column(
                  children: [
                    Text(
                        "Notices",
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
                                    padding: const EdgeInsets.only(right: 150,left: 20),
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
                                        Text("Date & Time",
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
                                                itemCount: notices.length,
                                                itemBuilder: (context,index){
                                                  return Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Card(
                                                      child: ListTile(

                                                        title: Padding(
                                                          padding: const EdgeInsets.only(left: 30),
                                                          child: Text(
                                                            notices[index].date,
                                                              style: GoogleFonts.nunito(
                                                                  fontSize:15,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold
                                                              )
                                                          ),
                                                        ),
                                                        subtitle: Padding(
                                                          padding: const EdgeInsets.only(left: 45),
                                                          child: Text(
                                                            notices[index].time,
                                                              style: GoogleFonts.nunito(
                                                                  fontSize:12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold
                                                              )
                                                          ),
                                                        ),

                                                        trailing: Text(
                                                          notices[index].subject,
                                                            maxLines: 1,
                                                            style: GoogleFonts.nunito(
                                                                fontSize:15,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold
                                                            )
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
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Text("ID ${id}| Student")
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
