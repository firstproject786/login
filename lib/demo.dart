import 'package:flutter/material.dart';
import 'package:login/database.dart';
import 'package:login/main.dart';
import 'package:login/showdata.dart';

class update extends StatefulWidget {
  Map uid;
  update(this.uid);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  RegExp nameRegExp = RegExp('[a-zA-Z]');
  RegExp emailRegExp = RegExp (r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp patttern = RegExp  (r'^[0-9]{10,12}$');

  String nameerror='';
  bool namrror=false;

  String emailerror='';
  bool eerror=false;

  String numbererror='';
  bool nnerror=false;



  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text=widget.uid['name'];
    email.text=widget.uid['email'];
    number.text=widget.uid['number'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    errorText: namrror?nameerror:null,
                    labelText: 'Enter Name',
                    hintText: 'Enter Your Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    errorText: eerror?emailerror:null,
                    labelText: 'Enter Email',
                    hintText: 'Enter Your Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: number,
                decoration: InputDecoration(
                    errorText: nnerror?numbererror:null,
                    labelText: 'Enter Number',
                    hintText: 'Enter Your Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  setState(() {

                  });
                  namrror=false;
                  eerror=false;
                  nnerror=false;

                  if(name.text.isEmpty)
                  {
                    namrror=true;
                    nameerror='please fill blank';
                  }
                  else if(!nameRegExp.hasMatch(name.text)){
                    namrror=true;
                    nameerror='please enter valid name';
                  }
                  else if(email.text.isEmpty){
                    eerror=true;
                    emailerror='please fill blank';
                  }
                  else if(!emailRegExp.hasMatch(email.text))
                  {
                    eerror=true;
                    emailerror='please enter valid email';
                  }
                  else if(number.text.isEmpty)
                  {
                    nnerror=true;
                    numbererror='please fill blank';
                  }
                  else if(!patttern.hasMatch(number.text))
                  {
                    nnerror=true;
                    numbererror='please enter valid NUMBER';
                  }

                  else
                  {
                    myclass().updatedata(name.text,email.text,number.text,Login.db!,widget.uid['id']).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return sd();
                      },));
                    });
                  }
                },
                child: Text(
                  "Update",
                )),
          ],
        ),
      ),
    );
  }
}
