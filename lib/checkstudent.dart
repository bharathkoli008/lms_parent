import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_parent/Pages/Loginpage.dart';
import 'package:lms_parent/main.dart';
import 'package:lms_parent/pages/Admission/AdmissionForm.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CheckStudent extends StatefulWidget {
  const CheckStudent({Key? key}) : super(key: key);

  @override
  State<CheckStudent> createState() => _CheckStudentState();
}

class _CheckStudentState extends State<CheckStudent> {

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void openLoginPage(){

    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
          child: LoginPage()
      ),);
  }

  void openAdmissionPage(){
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
          child: AdmissionForm()
      ),);
  }


  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),


                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text("Select Student Type",
                    style: GoogleFonts.nunito(
                        color: Colors.grey.shade800,
                        fontSize: 19,
                        fontWeight: FontWeight.w800
                    ),),
                ),


                GestureDetector(
                  onTap: openAdmissionPage,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width:  MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade200,
                                  Colors.blue,
                                  Colors.blueAccent
                                ]
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'New Student',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ),
                GestureDetector(
                  onTap: openLoginPage,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width:  MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade700,
                              blurRadius: 0.3
                            )
                          ]
                        ),
                        child: Center(
                          child: Text(
                            'Existing Student',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      )
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 220),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("For any queries.",
                        style: GoogleFonts.nunito(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                      Text(" Contact Admin",
                        style: GoogleFonts.nunito(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                )
              ],
            ),

            Positioned(
              top: 110,
              left: 245,
              child: Container(
                //margin: const EdgeInsets.only(top: 85, left: 290),
                height: MediaQuery.of(context).size.height * 0.17,
                child: Image.asset("lib/assets/Polygon2.png",
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 300,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.17,

                  child: Image.asset("lib/assets/Polygon.png")
              ),
            )

          ],
        ),
      ),
    );
  }
}
