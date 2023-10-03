import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Geek/homePage.dart';
import 'package:Geek/signup.dart';
import 'flutterFlow/flutter_flow_theme.dart';
import 'package:http/http.dart' as http;

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool passVisible = false;
  String _errorMessage = '';


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passController.text;


    final url = Uri.parse("https://b379-2401-4900-1c0e-8fff-00-d3-b0e2.ngrok-free.app/signUp/logIn");
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      // Successful login

      final responseData = jsonDecode(response.body);
      final storedEmail = responseData["email"];
      final storedName = responseData["name"];

      // Store email and password in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", storedEmail);
      await prefs.setString("name", storedName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );
      print('Login successful');
    } else if (response.statusCode == 404) {
      // Unauthorized - Invalid email or password
      final responseData = jsonDecode(response.body);
      final error = responseData["message"];
      setState(() {
        _errorMessage = error;
      });

    } else if(response.statusCode==401){
      print("unauthorized");
      final responseData = jsonDecode(response.body);
      final error = responseData["message"];
      setState(() {
        _errorMessage = "Password Did not match";
      });
    }
    else {
      // Handle other errors here
      setState(() {
        _errorMessage = "An error occurred while logging in Try again after Some time";
      });
      Fluttertoast.showToast(
        msg: "An error occurred while logging in",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryText,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/launchScreen@3x.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/logoGeekMessaging.png',
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: MediaQuery.sizeOf(context).height * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A1F24),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
                                child: TextFormField(
                                  controller: _emailController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF95A1AC),
                                    ),
                                    hintText: 'Email Address',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    // if (value!.isEmpty) {
                                    //   return 'Email is required';
                                    // }
                                    // final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                                    // if (!emailRegex.hasMatch(value!)) {
                                    //   return 'Invalid email format';
                                    // }
                                    // Add more email validation logic if needed
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 20),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A1F24),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
                                child: TextFormField(
                                  controller: _passController,
                                  obscureText: !passVisible, // Use !passVisible to toggle visibility
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF95A1AC),
                                    ),
                                    hintText: 'Password',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passVisible = !passVisible;
                                        });
                                      },
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: FlutterFlowTheme.of(context).primary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is required';
                                    }
                                    // Add more password validation logic if needed
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _errorMessage, // Create a variable to store the error message
                            style: TextStyle(
                              color: Colors.red, // Set the text color to red
                              fontSize: 16.0, // Set the font size as needed
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Validation logic here
                              _login();
                              if (_emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Email is required.'),
                                  ),
                                );
                                return;
                              }
                              final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                              if (!emailRegex.hasMatch(_emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Invalid email format.'),
                                  ),
                                );
                                return;
                              }
                              if (_passController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Password is required.'),
                                  ),
                                );
                                return;
                              }
                              print('Button pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                              primary: FlutterFlowTheme.of(context).primary,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 4,
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              width: 300,
                              height: 55,
                              alignment: Alignment.center,
                              child: Text(
                                'Log In',
                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                  child: Text(
                                    'Don\'t have an account?',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF95A1AC),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SignUpWidget()),
                                    );

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0x004B39EF).withOpacity(1.0), // Set the button's color
                                    foregroundColor: Colors.white, // Set the text color
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0, // Set the elevation to 0 for no shadow
                                    side: const BorderSide(
                                      color: Colors.transparent, // Set the border color to transparent
                                      width: 0,
                                    ),
                                  ),
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Create Account',
                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
