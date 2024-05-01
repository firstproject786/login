import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/database.dart';
import 'package:login/main.dart';
import 'package:login/spashscreen.dart';
import 'package:login/ucontact.dart';
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? useremail;
  int? userid;

  List<Map> userconatctt = [];
  List<Map> sconatctt = [];
  bool issearch = false;

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      useremail = sh.sp!.getString("email") ?? "dd";
      userid = sh.sp!.getInt("id") ?? 0;
    });

    viewconatctData();
  }

  //  id  userid , Number , Name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: issearch
          ? AppBar(
              title: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        sconatctt = [];
                        for (int i = 0; i < userconatctt.length; i++) {
                          String s = "${userconatctt[i]['name']}";
                          if (s.toUpperCase().contains(value.toUpperCase())) {
                            sconatctt.add(userconatctt[i]);
                          }
                        }
                      } else {
                        sconatctt = userconatctt;
                      }
                    });
                  },
                  decoration: InputDecoration(
                      suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        issearch = false;
                      });
                    },
                    icon: Icon(Icons.close),
                  ))),
            )
          : AppBar(
              title: Center(child: Text('Data')),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        issearch = true;
                        sconatctt = userconatctt;
                      });
                    },
                    icon: Icon(CupertinoIcons.search)),
                IconButton(
                    onPressed: () {
                      myclass().deleteall(Login.db!).then((value) {
                        viewconatctData();
                      });
                    },
                    icon: Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sh.sp!.setBool('key', false).then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ));
                        });
                      });
                    },
                    icon: Icon(Icons.logout_rounded))
              ],
              backgroundColor: Colors.red),
      body: ListView.builder(
        itemCount: issearch ? sconatctt.length : userconatctt.length,
        itemBuilder: (context, index) {
          Map map = issearch ? sconatctt[index] : userconatctt[index];
          return ListTile(
            title: Text("${map['name']}"),

            subtitle: Text("${map['number']}"),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return ucontact(map);
                    },
                  ));
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 1, child: Text('Update')),
                PopupMenuItem(
                    onTap: () {
                      int a = map['id'];
                      myclass().deletecontact(sh.db!, a).then((value) {
                        viewconatctData();
                      });
                    },
                    child: Text('Delete')),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () {
          name.text='';
          number.text='';
          showDialog(
            context: context,
            builder: (context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 150),
                child: Material(borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: EdgeInsets.all(10),
                  child: TextField(controller: name,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  ),
                  Container(margin: EdgeInsets.all(10),
                  child: TextField(controller: number,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  ),
                  ElevatedButton(onPressed: () {
                    myclass().insertConatct(name.text, number.text, userid!, sh.db!).then((value) {
                      Navigator.pop(context);
                      viewconatctData();
                    }
                    );
                  }, child: Text('Save'))
                ],
                ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void viewconatctData() {
    myclass().viewConatct(userid!, sh.db!).then((value) {
      setState(() {
        userconatctt = value;
      });
    });
  }
}
