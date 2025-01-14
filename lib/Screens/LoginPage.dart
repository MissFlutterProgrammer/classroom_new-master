// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/Screens/forget_passeord.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_management/Screens/home.dart';
import 'package:school_management/Screens/Exam/constant.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'RequestLogin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _delayedAnimation;
  late Animation<double> _muchDelayedAnimation;
  late Animation<double> _leftCurveAnimation;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  late String _username, _password;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _delayedAnimation = Tween<double>(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _muchDelayedAnimation = Tween<double>(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _leftCurveAnimation = Tween<double>(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: ListView(
            children: [
              _buildHeader(width),
              _buildLoginForm(width),
              _buildForgotPasswordButton(width),
              _buildLoginButton(width),
              _buildRequestLoginButton(width),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Transform(
        transform: Matrix4.translationValues(_animation.value * width, 0, 0),
        child: Center(
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 80, 0, 0),
                child: Text(
                  'Classroom',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Transform(
        transform:
            Matrix4.translationValues(_leftCurveAnimation.value * width, 0, 0),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildUsernameField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username cannot be empty!';
        }
        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
          return 'Enter a valid username';
        }
        return null;
      },
      onSaved: (value) => _username = value!,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'EMAIL',
        contentPadding: EdgeInsets.all(5),
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      obscuringCharacter: '*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty!';
        }
        return null;
      },
      onSaved: (value) => _password = value!,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.lock_open : Icons.lock),
          onPressed: () {
            setState(() => _isPasswordVisible = !_isPasswordVisible);
          },
        ),
        labelText: 'PASSWORD',
        contentPadding: const EdgeInsets.all(5),
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton(double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Transform(
        transform:
            Matrix4.translationValues(_delayedAnimation.value * width, 0, 0),
        child: Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: Bouncing(
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetPassword(),
                  ),
                );
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Transform(
        transform: Matrix4.translationValues(
            _muchDelayedAnimation.value * width, 0, 0),
        child: Bouncing(
          onPress: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              bool loginSuccess = await _login();
              if (loginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              } else {
                Fluttertoast.showToast(msg: 'Login failed');
              }
            }
          },
          child: MaterialButton(
            elevation: 0.5,
            minWidth: double.infinity,
            color: Colors.teal[900],
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                bool loginSuccess = await _login();
                if (loginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg: 'Login failed');
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRequestLoginButton(double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Transform(
        transform: Matrix4.translationValues(
            _muchDelayedAnimation.value * width, 0, 0),
        child: Bouncing(
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RequestLogin(),
              ),
            );
          },
          child: MaterialButton(
            elevation: 0.5,
            minWidth: double.infinity,
            color: Colors.grey[300],
            child: const Text('Request Login ID'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestLogin(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _login() async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.x}login.php"),
        body: {
          "username": _username,
          "password": _password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == "successful") {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('loginId', data["login_id"]);
          prefs.setString('reg_no', data["reg_no"]);
          prefs.setString('name', data["name"]);
          prefs.setString('department', data["department"]);
          prefs.setString('sem', data["sem"]);
          prefs.setString('email', data["email"]);
          prefs.setString('mobile', data["mobile"]);
          return true;
        } else {
          Fluttertoast.showToast(msg: 'Invalid credentials');
          return false;
        }
      } else {
        Fluttertoast.showToast(msg: 'Server error');
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Network error: $e');
      return false;
    }
  }
}
