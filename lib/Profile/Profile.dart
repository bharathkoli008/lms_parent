import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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

  @override
  void initState() {
    getName();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topLeft,
      //         end: Alignment.centerRight,
      //         colors: [
      //
      //           Colors.lightBlueAccent,
      //           Colors.blueAccent,
      //           Colors.blueAccent,
      //           Colors.white
      //         ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,


          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stack(children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        )

                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.093,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    child: Text(
                                      "Account",
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
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

                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.black45)
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Generate Report',
                                            style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16
                                            ),
                                          ),

                                          Image.asset('lib/assets/generate_report.png',
                                          fit: BoxFit.fitHeight,)
                                        ],
                                      ),
                                    ),
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

                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.black45)
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Dark Mode',
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16
                                            ),
                                          ),

                                          Image.asset('lib/assets/timetable_mask.png',
                                            fit: BoxFit.fitHeight,)
                                        ],
                                      ),
                                    ),
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


                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.black45)
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Contact Admin',
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16
                                            ),
                                          ),

                                          Image.asset('lib/assets/contact_admin.png',
                                            fit: BoxFit.fitHeight,)
                                        ],
                                      ),
                                    ),
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


                                GestureDetector(
                                  onTap: () async {
                                    sharedPreferences = await SharedPreferences.getInstance();
                                    sharedPreferences.remove('id').then((_) => Navigator.push(
                                        context, MaterialPageRoute(builder: (context) {
                                      return const Authcheck();
                                    })));
                                  },
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.black45)
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Logout',
                                              style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                              ),
                                            ),

                                            Image.asset('lib/assets/logout.png',
                                              fit: BoxFit.fitHeight,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                    ),







                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 65,horizontal: 65),
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2.0)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              '$name',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text("ID $id | Student",
                                style: GoogleFonts.nunito(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600
                                ))
                          ],
                        ),
                      ),
                      
                      Image.asset('lib/assets/avatar.png',
                      width: 100,
                      height: 70,)
                    ],
                  ),
                )
              ]),
            ),
          )
      ),
    );
  }
}
