import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lms_parent/checkstudent.dart';
import 'package:lms_parent/frame.dart';
import 'package:lms_parent/pages/prepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/Loginpage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyArgcDzZS5_w-vF6U_ljaQAuFT5G1-tScE",
        appId: '1:786247972605:android:5c77c8fdf8710063857094',
        messagingSenderId: '786247972605',
        projectId: 'lmsapp-5ab03')
  );
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Authcheck()
    );
  }
}





class Authcheck extends StatefulWidget {
  const Authcheck({Key? key}) : super(key: key);

  @override
  State<Authcheck> createState() => _AuthcheckState();
}

class _AuthcheckState extends State<Authcheck> {
  bool userAvailabe = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    _getuser();
    super.initState();
  }

  void _getuser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try{
      if(sharedPreferences.getString('id') != null){
        setState(() {
          userAvailabe = true;
        });
      }
    } catch(e){
      setState(() {
        userAvailabe = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {  
    return userAvailabe ? Frame() : CheckStudent();
  }
}

