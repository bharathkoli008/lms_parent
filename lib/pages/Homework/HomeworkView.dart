import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lms_parent/pages/Homework/Homework.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeworkView extends StatefulWidget {
  final String name;
  final String id;
  final HomeWork_strucure homework;
  HomeworkView({required this.name,required this.id,required this.homework});

  @override
  State<HomeworkView> createState() => _HomeworkViewState();
}

class _HomeworkViewState extends State<HomeworkView> {


  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String time = '';



  void getDate()  async {
    var date = DateTime.now();

    print(date.toString()); // prints something like 2019-12-10 10:02:22.287949
    print(DateFormat('EEEE').format(date)); // prints Tuesday
    print(DateFormat('EEEE, dmmyyyy').format(
        date)); // prints Tuesday, 10 Dec, 2019
    print(DateFormat('h:mm a').format(date));


    day = DateFormat('EEEE, d MMM, yyyy').format(date);
    day_2 = DateFormat('d MMM yyyy').format(date);
    time = DateFormat('h:mm a').format(date);
  }

  @override
  void initState() {
    getDate();
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
                                    padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 15),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blueAccent,
                                                  blurRadius: 0.3
                                              )
                                            ]
                                        ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 245),
                                              child: Text(
                                                'Description',
                                                style: GoogleFonts.nunito(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text(
                                                widget.homework.desc,
                                                style: GoogleFonts.nunito(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ),


                                  Padding(
                                      padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blueAccent,
                                                  blurRadius: 0.3
                                              )
                                            ]
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Deadline',
                                                style: GoogleFonts.nunito(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                              Text(
                                                widget.homework.deadline,
                                                style: GoogleFonts.nunito(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),





                                  if(widget.homework.doclink != '')
                                    GestureDetector(
                                      onTap: () async {
                                         var url =
                                         Uri.parse(widget.homework.doclink);
                                        await launchUrl(url,
                                        mode: LaunchMode.externalNonBrowserApplication,
                                        webViewConfiguration: WebViewConfiguration(

                                        )
                                        //    mode: LaunchMode.externalApplication
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blueAccent,
                                                  blurRadius: 0.3
                                              )
                                            ]
                                        ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Document Download',
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600
                                        ),),
                                  ),
                                ),
                                    )

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
