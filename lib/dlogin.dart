import 'package:flutter/material.dart';
import 'package:login/database.dart';
import 'package:login/main.dart';


class Registerrpage extends StatefulWidget {
  const Registerrpage({Key? key}) : super(key: key);

  @override
  State<Registerrpage> createState() => _RegisterrpageState();
}



class _RegisterrpageState extends State<Registerrpage> {

  RegExp nameRegExp = RegExp('[a-zA-Z]');
  RegExp emailRegExp = RegExp (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp patttern = RegExp  (r'^[0-9]{10,12}$');
  RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  String nameerror='';
  bool namrror=false;

  String emailerror='';
  bool eerror=false;

  String numbererror='';
  bool nnerror=false;

  String passworderror='';
  bool passerror=false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password= TextEditingController();

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
              child: TextFormField(
                validator: (String? value) {
                  eerror=false;
                if(value!.isNotEmpty)
                  {
                    for(int i=0;i<vr.length;i++)
                      {
                        if (vr[i]['email'].toUpperCase().contains(
                            email.text.toUpperCase())) {
                          eerror=true;
                         emailerror=  "password already exit";
                        }
                      }
                  }
                return null;
              },
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
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    errorText: passerror?passworderror:null,
                    labelText: 'Enter Password',
                    hintText: 'Enter Your Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {

                  });
                  namrror = false;
                  eerror = false;
                  nnerror = false;
                  passerror = false;
                  if (name.text.isEmpty) {
                    namrror = true;
                    nameerror = 'please fill blank';
                  }
                  else if (!nameRegExp.hasMatch(name.text)) {
                    namrror = true;
                    nameerror = 'please enter valid name';
                  }
                  if (email.text.isEmpty) {
                    eerror = true;
                    emailerror = 'please fill blank';
                  }
                  else if (!emailRegExp.hasMatch(email.text)) {
                    eerror = true;
                    emailerror = 'please enter valid email';
                  }
                  if (number.text.isEmpty) {
                    nnerror = true;
                    numbererror = 'please fill blank';
                  }
                  else if (!patttern.hasMatch(number.text)) {
                    nnerror = true;
                    numbererror = 'please enter valid NUMBER';
                  }
                  if (password.text.isEmpty) {
                    passerror = true;
                    passworderror = 'please fill blank';
                  }
                  else if (!passwordRegExp.hasMatch(password.text)) {
                    passerror = true;
                    passworderror = 'please enter valid password';
                  }
                  else
                  {
                    myclass().insertdb(name.text, email.text, number.text, password.text, Login.db!).then((value) {
                      if(value)
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Login();

                          },));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inserted successed')));
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inserted not found')));
                        }
                      });
                    }
                },
                child: Text(
                  "Register",
                )),
          ],
        ),
      ),
    );
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    showdb();
  }
  List<Map> vr=[];
  void showdb() async {
    myclass().showdb(Login.db!).then((value) {
      print('===vds=$value');
      setState(() {
        vr = value;
      });
    });
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////




// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//
//   final FocusNode _focusNodePassword = FocusNode();
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();
//
//   bool _obscurePassword = true;
//   final Box _boxLogin = Hive.box("login");
//   final Box _boxAccounts = Hive.box("accounts");
//
//   @override
//   Widget build(BuildContext context) {
//     if (_boxLogin.get("loginStatus") ?? false) {
//       return Home();
//     }
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 150),
//               Text(
//                 "Welcome back",
//                 style: Theme.of(context).textTheme.headlineLarge,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 "Login to your account",
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 60),
//               TextFormField(
//                 controller: _controllerUsername,
//                 keyboardType: TextInputType.name,
//                 decoration: InputDecoration(
//                   labelText: "Username",
//                   prefixIcon: const Icon(Icons.person_outline),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onEditingComplete: () => _focusNodePassword.requestFocus(),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter username.";
//                   } else if (!_boxAccounts.containsKey(value)) {
//                     return "Username is not registered.";
//                   }
//
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: _controllerPassword,
//                 focusNode: _focusNodePassword,
//                 obscureText: _obscurePassword,
//                 keyboardType: TextInputType.visiblePassword,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   prefixIcon: const Icon(Icons.password_outlined),
//                   suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                       icon: _obscurePassword
//                           ? const Icon(Icons.visibility_outlined)
//                           : const Icon(Icons.visibility_off_outlined)),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter password.";
//                   } else if (value !=
//                       _boxAccounts.get(_controllerUsername.text)) {
//                     return "Wrong password.";
//                   }
//
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 60),
//               Column(
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size.fromHeight(50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         _boxLogin.put("loginStatus", true);
//                         _boxLogin.put("userName", _controllerUsername.text);
//
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return Home();
//                             },
//                           ),
//                         );
//                       }
//                     },
//                     child: const Text("Login"),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account?"),
//                       TextButton(
//                         onPressed: () {
//                           _formKey.currentState?.reset();
//
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return const Signup();
//                               },
//                             ),
//                           );
//                         },
//                         child: const Text("Signup"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _focusNodePassword.dispose();
//     _controllerUsername.dispose();
//     _controllerPassword.dispose();
//     super.dispose();
//   }
// }
