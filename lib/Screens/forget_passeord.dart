// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:school_management/Widgets/BouncingButton.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    delayedAnimation = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    muchDelayedAnimation = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    LeftCurve = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Transform(
                  transform:
                      Matrix4.translationValues(animation.value * width, 0, 0),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Text(
                          'Forget',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 35, 0, 0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(190, 0, 0, 30),
                          child: Text(
                            '.',
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Transform(
                  transform:
                      Matrix4.translationValues(LeftCurve.value * width, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "You Must Enter Roll Number";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) {},
                              decoration: InputDecoration(
                                labelText: 'Roll Number',
                                contentPadding: EdgeInsets.all(5),
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (value) {
                                if ((Fzregex.hasMatch(
                                        value!, FzPattern.email) ==
                                    false)) {
                                  return "Enter Vaild Email address";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                contentPadding: EdgeInsets.all(5),
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Transform(
                  transform: Matrix4.translationValues(
                      muchDelayedAnimation.value * width, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Bouncing(
                        onPress: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            try {} catch (e) {}
                          } else {}
                        },
                        child: MaterialButton(
                          onPressed: () {},
                          elevation: 0,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Colors.green,
                          child: Text(
                            "Request",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
