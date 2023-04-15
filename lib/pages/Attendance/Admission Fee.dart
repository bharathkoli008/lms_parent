import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../FeePayment/UPI.dart';

class Admission_Fee extends StatefulWidget {
  final String name;
  final String FathersName;
  final String MothersName;
  final String DOB;
  final String PlaceOfBirth;
  final String PhoneNumber;
  final String Standard;
  final String AadharNo;
  final String Sex;
   Admission_Fee({Key? key, required this.name, required this.FathersName, required this.MothersName, required this.DOB,  required this.PhoneNumber, required this.Standard, required this.AadharNo, required this.Sex, required this.PlaceOfBirth}) : super(key: key);

  @override
  State<Admission_Fee> createState() => _Admission_FeeState();
}

class _Admission_FeeState extends State<Admission_Fee> {

  bool isLoading = false;


  void SendForVerification() {

    FirebaseFirestore.instance.collection('verify').add({
      'name':widget.name,
      'fathersName':widget.FathersName,
      'mothersName':widget.MothersName,
      'DOB':widget.DOB,
      'placeOfBirth':widget.PlaceOfBirth,
      'phoneNumber':widget.PhoneNumber,
      'Standard':widget.Standard,
      'Aadhar':widget.Standard,
      'Sex':widget.Sex
    });
}


  void openPaymentgateway() {
    SendForVerification();
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
          child: UPIPage(
            id: '',
          )
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: Text("Step 2/2",
                style: GoogleFonts.nunito(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w800
                ),),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            Center(
              child: Text("Pay Admission Fee",
                style: GoogleFonts.nunito(
                    color: Colors.blueAccent,
                    fontSize: 19,
                    fontWeight: FontWeight.w800
                ),),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 35,left: 15,right: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.18,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.8,
                        spreadRadius: 0.5
                    )
                  ]
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'Admission \n Fee',
                        style: GoogleFonts.nunito(
                          color: Colors.blueAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Text('Rs 500',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                      ),),
                    )
                  ],
                ),
              ),
            ),

            !isLoading ? SizedBox(
              //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: GestureDetector(
                      onTap: openPaymentgateway,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(

                              gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade200,
                                    Colors.blue,
                                    Colors.blueAccent
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2.0
                                )
                              ]
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Pay Using UPI',
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700

                                ),),
                            ),
                          )),
                    ),
                  ),
                )
            ) : Center(
                child: CircularProgressIndicator(

                )),



            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 250),
                    child: Text("Instructions",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600

                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,top: 10),
                    child: Text("1.Payment for schoolership students and exceptional students should be done offline\n2.Total there are 2 installments if you choose installments",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600

                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Column(
                      children: [
                        Text("3.Payment gateway supports all type of methods like",
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600

                          ),
                        ),

                        Image.asset(
                          'lib/assets/gateway_apps.png',
                          width: 400,
                          height: 25,)
                      ],
                    ),
                  ),

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
