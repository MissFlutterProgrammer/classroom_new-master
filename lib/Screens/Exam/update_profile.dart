// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Update extends StatelessWidget {
  Update({super.key});

  var reg_no;
  var email;
  var name;
  var mobile;
  var department;

  getData() async {
    final pref = await SharedPreferences.getInstance();
    nameController.text = pref.getString('name')!;
    departmentController.text = pref.getString('department')!;
    emailController.text = pref.getString('email')!;
    mobileController.text = pref.getString('mobile')!;
    reg_no = pref.getString('reg_no');
  }

  sendData() async {
    http.Response result =
        await http.post(Uri.parse("${Constants.x}update_student.php"), body: {
      'reg_no': reg_no,
      'name': nameController.text,
      'department': departmentController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
    });
    var body = result.body;

    print(body);
    jsonDecode(body);
  }

  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 108, 147, 237),
        centerTitle: true,
      ),
      body: Center(
        /** Card Widget **/
        child: FutureBuilder(
            future: getData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Color.fromARGB(255, 220, 231, 252),
                  child: SizedBox(
                    width: 300,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text('Register No :'),
                              trailing: Text(reg_no),
                            ),
                          ),
                          Divider(),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              label: Text('Name'),
                            ),
                          ),
                          Divider(),
                          TextField(
                            controller: mobileController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              label: Text('Mobile'),
                            ),
                          ),
                          Divider(),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              label: Text('Email'),
                            ),
                          ),
                          Divider(),
                          FloatingActionButton(
                            onPressed: () {
                              sendData();
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.save),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
