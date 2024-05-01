import 'package:flutter/material.dart';
import 'package:login/database.dart';
import 'package:login/home.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

class sh extends StatefulWidget {
  static SharedPreferences? sp;
  static Database? db;

  @override
  State<sh> createState() => _shState();
}

class _shState extends State<sh> {
  bool Islogin = false;
  int uid = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myclass().databd().then((value) {
      setState(() {
        sh.db =value;
      });

      print("=S==${sh.db}");
    });
    GettingShareperence();
  }

  GettingShareperence() async {
    sh.sp = await SharedPreferences.getInstance();
    setState(() {
      Islogin = sh.sp!.getBool("key") ?? false;
      uid= sh.sp!.getInt("id") ?? 0;
    });

    Future.delayed(Duration(seconds: 4)).then((value) {
      if (Islogin) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        heightFactor: 100,
        widthFactor: 100,
        child: Lottie.asset("raw/load.json"),
        alignment: Alignment.center,
      ),
    );
  }
}
