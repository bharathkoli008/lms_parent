import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_parent/pages/Marks/Marks.dart';
import 'package:page_transition/page_transition.dart';


class PreMarks extends StatefulWidget {
  final String name;
  final String id;
  final List<String> subjects;
  final String Classid;
  final int RollNo;

  PreMarks({required this.name,required this.id,required this.subjects, required this.Classid, required this.RollNo});


  @override
  State<PreMarks> createState() => _PreMarksState();
}

class _PreMarksState extends State<PreMarks> {
  bool isLoading = true;
  List <String> docIDS = [];
  List <String> subIDs = [];
  List <String> subnames = [];
  List <String> examlist = [];
  late final Future myFuture;


  Future getData() async{
    
   for(int i = 0;i < widget.subjects.length ; i++){
     await FirebaseFirestore.instance.collection('subjects').where('Subject_Id',isEqualTo: widget.subjects[i]).get()
         .then((snapshot) {
        snapshot.docs.forEach((element) { 
          subnames.add(element.data()['Subject_Name']);
        });
     });
     setState(() {
       isLoading = false;
     });
   }
  }



  @override
  void initState() {
    myFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
                          "Exam Performance",
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
                                    padding: const EdgeInsets.only(left: 110,top: 20,bottom: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Select a Subject",
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 19,
                                              color: Colors.blue
                                          ),),
                                        SizedBox(width: 70,),
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
                                  !isLoading ? SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child:
                                    GridView.builder(
                                        itemCount: subnames.length,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 0.0,
                                        crossAxisSpacing: 0.0,
                                        childAspectRatio: 1.35
                                    ),
                                        itemBuilder: (BuildContext context, int index) {
                                          return
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 12),
                                              child: GestureDetector(
                                                onTap: () async {

                                                  await FirebaseFirestore.instance.collection('exams').doc(widget.Classid).collection(
                                                   widget.subjects[index]
                                                  ).get().
                                                      then((snapshot) {
                                                     snapshot.docs.forEach((element) { 
                                                       examlist.add(element.data()['name']);
                                                     });
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType.fade,
                                                        alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
                                                        child: Marks(
                                                          name: widget.name,
                                                          ref: examlist,
                                                          id: widget.id,
                                                          SubjectName: subnames[index],
                                                          SubjectId: widget.subjects[index],
                                                          Classid: widget.Classid,
                                                          RollNo: widget.RollNo,
                                                        )
                                                    ),);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Colors.white,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 0.02),

                                                      ]),
                                                child: GridTile(
                                                  child:  Center(
                                                    child: Text(
                                                      subnames[index],
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 17.5,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w800
                                                      ),
                                                    ),
                                                  ), //just for testing, will fill with image later
                                                ),
                                          ),
                                              ),
                                            );
                                        }
                                  ) ): Center(
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
