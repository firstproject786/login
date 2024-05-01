import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/database.dart';
import 'package:login/home.dart';
import 'package:login/spashscreen.dart';
import 'package:sqflite/sqflite.dart';

import 'dlogin.dart';

void main() {
  runApp(MaterialApp(
    home: sh(),
  ));
}

class Login extends StatefulWidget {
  static Database? db;

  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> formKey = GlobalKey();

  final FocusNode focusNodePassword = FocusNode();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();

  String passworderror = '';
  bool passerror = false;

  RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RegExp patttern = RegExp  (r'^[0-9]{10,12}$');

  RegExp passwordRegExp =RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  String emailerror = '';
  bool eerror = false;

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: eerror ? emailerror : null,
                  labelText: "Email or Phone no",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
                TextFormField(
                  controller: pass,
                  focusNode: focusNodePassword,
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    errorText: passerror ? passworderror : null,
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          eerror = false;
                          if (email.text.isEmpty) {
                            eerror = true;
                            emailerror = 'please enter email';
                          }
                           if(!emailRegExp.hasMatch(email.text) && !patttern.hasMatch(email.text))
                           {
                             print('=====s==${email.text}');
                            eerror = true;
                            emailerror = 'please enter valid email';
                          }
                          else
                          {
                            myclass()
                                .login(email.text, pass.text, Login.db!)
                                .then((value) {
                                  print("===r=$value");
                              if (value.length==1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Login success')));
                                setState(() {
                                  sh.sp!.setBool('key', true);
                                  sh.sp!.setString('email', value[0]['email']);
                                  sh.sp!.setInt('id', value[0]['id']);
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return Homepage();
                                },));

                              }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Login fail')));
                                }
                            });
                          }
                        },
                      );
                    },
                    child: const Text("Login"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          formKey.currentState?.reset();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Registerrpage();
                              },
                            ),
                          );
                        },
                        child: const Text("Signup",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    // shared();
  }

  Future<void> getdata() async {
    myclass().databd().then((value) {
      setState(() {
        Login.db = value;
      });
    });
  }
}
