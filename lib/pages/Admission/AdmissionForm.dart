import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lms_parent/pages/Attendance/Admission%20Fee.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';


class AdmissionForm extends StatefulWidget {
  const AdmissionForm({Key? key}) : super(key: key);

  @override
  State<AdmissionForm> createState() => _AdmissionFormState();
}

class _AdmissionFormState extends State<AdmissionForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController placeofBirthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController StdController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  String DOBCONtroller = 'DOB';

  final List<String> Sex = [
    'Male',
    'Female',
    'Others'
  ];
  String? selectedSex;


  final List<String> Classes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  String? selectedClass;

  void openLoginPage(){
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
          child: Authcheck()
      ),);
  }

  void openAdmissionFee(){

    if(nameController.text.toString().isNotEmpty &&
    fathersNameController.text.toString().isNotEmpty &&
        mothersNameController.text.toString().isNotEmpty &&
        DOBCONtroller.toString().isNotEmpty &&
        selectedClass.toString().isNotEmpty &&
        aadharController.text.toString().isNotEmpty &&
        selectedSex.toString().isNotEmpty ){
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
            child: Admission_Fee(name: nameController.text.trim(),
            FathersName: fathersNameController.text.trim(),
            MothersName: mothersNameController.text.trim(),
            DOB: DOBCONtroller,
            PlaceOfBirth: placeofBirthController.text.trim(),
            PhoneNumber: phoneController.text.trim(),
            Standard: selectedClass!,
            AadharNo: aadharController.text.trim(),
            Sex: selectedSex!,
            )
        ),);
    } else{
      Fluttertoast.showToast(
          msg: "Please Fill all the Fields and try again",
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white
      );
    }

  }


  late SharedPreferences sharedPreferences;


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
              child: Text("Step 1/2",
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
              child: Text("Fill the Admission Form",
                style: GoogleFonts.nunito(
                    color: Colors.blueAccent,
                    fontSize: 19,
                    fontWeight: FontWeight.w800
                ),),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 30,top: 30),
              child: Text("Student's name",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                ),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700,
                            blurRadius: 0.3
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  )),
            ),



            Padding(
              padding: const EdgeInsets.only(left: 30,top: 10),
              child: Text("Fathers's name",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                ),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700,
                            blurRadius: 0.3
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: fathersNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  )),
            ),



            Padding(
              padding: const EdgeInsets.only(left: 30,top: 10),
              child: Text("Mother's name",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                ),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade700,
                            blurRadius: 0.3
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: mothersNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  )),
            ),

            SizedBox(

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('DOB',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w800
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: (){
                              showDatePicker(
                                context: context,

                                initialDate: DateTime(2000),
                                firstDate: DateTime(1970, 1),
                                lastDate: DateTime(2023, 12),
                              ).then((pickedDate) {
                                setState(() {
                                  DOBCONtroller = DateFormat('d MMM yyyy').format(pickedDate!);
                                });
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.062,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15)
                              ),

                              child: Center(
                                child: Text(DOBCONtroller,
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700
                                  ),),
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Place of Birth',
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.w800
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.062,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: TextField(
                              controller: placeofBirthController,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700
                                ),
                                border: InputBorder.none,
                                hintText: 'Location',

                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('PhoneNumber',
                            style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w800
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.height * 0.062,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)
                            ),

                            child: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintStyle: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Ph No.',

                                ),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Standard',
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w800
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.062,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                dropdownDecoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.8,
                                          spreadRadius: 0.5
                                      )
                                    ],
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)
                                    )
                                ),
                                hint: Text(
                                    'Select',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                items: Classes
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Text(
                                        item,
                                        style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600
                                        )
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedClass,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedClass = newValue!;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: 140,
                                itemHeight: 40,
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Aadhar Number',
                            style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w800
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.height * 0.062,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)
                            ),

                            child: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: TextField(
                                controller: aadharController,
                                decoration: InputDecoration(
                                  hintStyle: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Aadhar No.',

                                ),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Sex',
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w800
                          ),),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.8,
                                    spreadRadius: 0.5
                                )
                              ]
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.8,
                                            spreadRadius: 0.5
                                        )
                                      ],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)
                                      )
                                  ),
                                  hint: Text(
                                      'Select',
                                      style: GoogleFonts.nunito(
                                          fontSize: 15,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),
                                  items: Sex
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Text(
                                          item,
                                          style: GoogleFonts.nunito(
                                              fontSize: 15,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: selectedSex,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedSex = newValue!;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 140,
                                  itemHeight: 40,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [


                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueAccent,
                                  blurRadius: 2.0
                              )
                            ]
                        ),
                        child: Center(
                          child: Text("Reset",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black
                            ),),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: openAdmissionFee,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueAccent.shade700,
                                blurRadius: 2.0
                            )
                          ]
                      ),
                      child: Center(
                        child: Text("Submit",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20),
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
      ),
    );
  }
}
