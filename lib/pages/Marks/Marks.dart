import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';


class SubjectMarks{
  String name;
  int marks;
  int total;

  SubjectMarks({ required this.name,required this.marks,required this.total});
}



class Marks extends StatefulWidget {
  final String name;
  final String id;
  final String Classid;
  final int RollNo;
  final String SubjectName;
  final String SubjectId;
  final List<String> ref;
  Marks({required this.name,required this.id,
    required this.Classid, required this.RollNo,
    required this.ref,
    required this.SubjectName, required this.SubjectId});

  @override
  State<Marks> createState() => _MarksState();
}

class _MarksState extends State<Marks> {

  late final Future myFuture;
  bool isLoading = true;
  int total = 0;
  int marks = 0;
  late final dataMap = <String, double>{};



  ///Pie Chart
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;

  late List<SubjectMarks> subs = List.generate(widget.ref.length, (i) => SubjectMarks(
      name: '',
      marks: 0,
      total: 0));

  Future getData() async{

    for(int i = 0 ; i < widget.ref.length; i++){
      await FirebaseFirestore.instance.collection('exams').doc(widget.Classid).collection(widget.SubjectId).where(
        'name',isEqualTo: widget.ref[i]
      ).get()
          .then((snapshots) {
        snapshots.docs.forEach((element) {

          subs[i].name = element.data()['name'].toString();
          subs[i].total = int.parse(element.data()['marks'].toString());
          subs[i].marks = int.parse(element.data()['marks_array'][widget.RollNo].toString());
          total += subs[i].total;
          marks += subs[i].marks;
          dataMap[subs[i].name] = subs[i].marks.toDouble() ;
        });
      });
    }

    setState(() {
      isLoading= false;
    });
  }

  @override
  void initState() {
    myFuture = getData();
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
                                    padding: const EdgeInsets.only(top: 15,bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(widget.SubjectName,
                                          style: GoogleFonts.nunito(
                                              fontSize: 19.5,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w800
                                          ),),
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


                                  !isLoading ? Padding(
                                    padding: const EdgeInsets.only(top: 40,bottom: 40),
                                    child: PieChart(
                                      dataMap: dataMap,
                                      chartType: ChartType.ring,
                                      initialAngleInDegree: 290,
                                      legendOptions: LegendOptions(
                                        legendPosition: LegendPosition.bottom,
                                        showLegendsInRow: true
                                      ),
                                      chartValuesOptions: ChartValuesOptions(
                                        showChartValuesOutside: true
                                      ),
                                      ringStrokeWidth: 72,
                                      chartRadius: 180,
                                      centerText:  "Marks Obtained \n $marks/$total",

                                      centerTextStyle: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black
                                      ),

                                      baseChartColor: Colors.grey,
                                    ),
                                  ) : CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: Colors.blueAccent,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Exam Name",
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14,
                                              color: Colors.blueAccent

                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(

                                        ),
                                        child: Text("Marks Obtained",
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14,
                                              color: Colors.blueAccent

                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Text("Total Marks",
                                          style: GoogleFonts.nunito(
                                              color: Colors.blueAccent,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800
                                          ),),
                                      ),

                                    ],
                                  ),
                                  !isLoading ? Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 15),
                                    child: Container(
                                      //height: MediaQuery.of(context).size.height * widget.subjects.length * 0.01,
                                      height: MediaQuery.of(context).size.height * 0.4 ,


                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2.8,
                                                spreadRadius: 0.5
                                            )
                                          ]
                                      ),
                                      child: FutureBuilder(
                                          future: myFuture,
                                          builder: (context,snapshot){
                                            return ListView.builder(
                                                itemCount: widget.ref.length,
                                                itemBuilder: (context,index){
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height * 0.053,

                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.grey.shade400,
                                                                blurRadius: 2.8,
                                                                spreadRadius: 0.5
                                                            )
                                                          ]
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(12.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 35),
                                                              child: Text(subs[index].name,
                                                                style: GoogleFonts.nunito(
                                                                    fontSize:14,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w800
                                                                ),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 20),
                                                              child: Text('${subs[index].marks}',
                                                                style: GoogleFonts.nunito(
                                                                    fontSize:14,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w800
                                                                ),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 30),
                                                              child: Text('${subs[index].total}',
                                                                style: GoogleFonts.nunito(
                                                                    fontSize:14,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w800
                                                                ),),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });}
                                      ),
                                    ),
                                  ) : Center(
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
