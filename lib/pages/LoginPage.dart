import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_textfield/gradient_textfield.dart';
import 'package:lms_parent/frame.dart';
import 'package:lms_parent/pages/prepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


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
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35,bottom: 20),
                  child: Container(
                    child: Row(

                      children: [
                        Image.asset("lib/assets/teacher.png",
                          height: 50,
                          width: 50,),
                        Text(" For Parents",
                          style: GoogleFonts.nunito(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),)],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text("Login",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Text("Please sign in to continue",
                    style: GoogleFonts.nunito(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10,top: 50,right: 15,left: 15),
                    child: Gradienttextfield(
                      controller: idController,
                      text: "👤 UserID",
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.9,
                      colors: [
                        Colors.white,
                        Colors.blue.shade300
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10,top: 5,right: 15,left: 15),
                    child:  Gradienttextfield(
                      controller: passwordController,
                      text: "🔓 Password",
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.9,
                      colors: [
                        Colors.white,
                        Colors.blue.shade300
                      ],
                    )
                ),
                GestureDetector(
                    onTap: () async {

                      String id = idController.text.trim();
                      String password = passwordController.text.trim();
                      if (id.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("UserID is empty")));
                      } else if (password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Password is empty")));
                      } else {
                        QuerySnapshot snapshot = await FirebaseFirestore.instance
                            .collection('students')
                            .where('id', isEqualTo: id)
                            .get();

                        try {
                          if (password == snapshot.docs[0]['password']) {
                            print("Success");

                            sharedPreferences  = await SharedPreferences.getInstance();



                            sharedPreferences.setString('id', id).then((_) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => Frame()));
                            });



                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Wrong Password")));
                          }
                        } catch (e) {
                          String error = "";
                          if(e.toString() == "RangeError (index): Invalid value: Valid value range is empty: 0"){
                            setState(() {
                              error = "Invalid UserID";
                            });
                          }else{
                            setState(() {
                              error = "Error Occurred!";
                            });
                          }


                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                        }
                      }
                    },

                    child: Padding(
                      padding: const EdgeInsets.only(left: 180,top: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.blue.shade100,
                                  Colors.blue.shade200,
                                  Colors.blue.shade500
                                ]
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LOGIN ➔",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 100),
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
