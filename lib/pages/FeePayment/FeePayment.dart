import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lms_parent/pages/FeePayment/UPI.dart';
import 'package:page_transition/page_transition.dart';


class FeePayPage extends StatefulWidget {
  final String name;
  final String id;
  final String Classid;
  final int RollNo;
  FeePayPage({required this.name,required this.id,required this.Classid, required this.RollNo});


  @override
  State<FeePayPage> createState() => _FeePayPageState();
}

class _FeePayPageState extends State<FeePayPage> {


  bool isLoading = true;
  String day = '';
  String day_2 = '';
  String time = '';
  int fees = 0;
  int balance = 0;
  int paid = 0;

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

  void openPaymentgateway() {
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerLeft, 0.5),
          child: UPIPage(
            id: widget.id,
          )
      ),);
  }


  void getData() async{

    await FirebaseFirestore.instance.collection('class').where('ClassId',isEqualTo: widget.Classid).get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          fees = int.parse(element.data()['fees'].toString());
        });
      });
    }).then((_) async {
      await FirebaseFirestore.instance.collection('students').where('id',isEqualTo: widget.id).get()
          .then((snapshot){
         snapshot.docs.forEach((element) { 
           setState(() {
             paid = int.parse(element.data()['fees_paid'].toString());
             balance = fees - paid;
             isLoading = false;
           });
         });   
      });
      
    });


  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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

          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25)
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.blueAccent ,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.blueAccent,
                                  blurRadius: 2.0
                              )
                            ]
                        ),
                        child: Center(
                          child: Text("",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black
                            ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(children: [
                Column(
                  children: [
                    Text(
                        "Fee Payment",
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
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Total Fees",
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        Row(
                                          children: [
                                            !isLoading ? Text("$fees",
                                              style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold
                                              ),) : Text('Loading')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Balance",
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold
                                          ),),



                                        Row(
                                          children: [
                                            !isLoading ? Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Text("$balance",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                            ) : Text('Loading')
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

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.08,
                                  ),

                                  !isLoading ? SizedBox(
                                    //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
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
                          widget.name,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Text("ID ${widget.id}| Student")
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
