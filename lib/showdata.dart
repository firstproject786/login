import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/demo.dart';
import 'package:login/main.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class sd extends StatefulWidget {
  @override
  State<sd> createState() => _sdState();
}

class _sdState extends State<sd> {
  List<Map> vr=[];
  List<Map> rr=[];
  bool issearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: issearch
            ? AppBar(
                title: TextField(onChanged: (value) {
                  setState(() {

                    if(value.isNotEmpty)
                    {
                      rr=[];
                      for(int i=0;i<vr.length;i++)
                      {
                        String s="${vr[i]['name']}";
                        if(s.toUpperCase().contains(value.toUpperCase()))
                        {
                                 rr.add(vr[i]);
                        }
                      }
                    }
                    else{
                      rr=vr;
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
                          rr=vr;
                        });
                      },
                      icon: Icon(CupertinoIcons.search)),


                  IconButton(onPressed: () {
                    myclass().deleteall(Login.db!).then((value) {
                      showdb();
                    });
                  }, icon: Icon(Icons.delete))
                ],
                backgroundColor: Colors.red),
        body: ListView.builder(
          itemCount: issearch?rr.length:vr.length,
          itemBuilder: (context, index) {
            Map map=issearch?rr[index]:vr[index];
            return ListTile(
              title: Text("${map['name']}"),
              leading: Text("${map['id']}"),
              subtitle: Text("${map['email']}"),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return update(map);
                      },
                    ));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 1, child: Text('Update')),
                  PopupMenuItem(
                      onTap: () {
                        int a = map['id'];
                        myclass().deletedata(Login.db!, a).then((value) {
                          showdb();
                        });
                      },
                      child: Text('Delete')),
                ],
              ),
            );
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showdb();
  }

  void showdb() async {
    myclass().showdb(Login.db!).then((value) {
      print('===vds=$value');
      setState(() {
        vr = value;
        rr=value;
      });
    });
  }


}
