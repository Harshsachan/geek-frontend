import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutterFlow/flutter_flow_theme.dart';
import 'imageTab.dart';
import 'logIn.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    SecondTab(), // Add your second tab here
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Home Page'),
        // ),
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color(0xFF4B39EF), // Color for selected item
          unselectedItemColor: Color(0xFF98939393),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Profile', // Change this label as needed
            ),
          ],
        ),
      ),
    );
  }
}


class SecondTab extends StatefulWidget {
  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  String userNameFromPrefs = "User name";
  String userEmailFromPrefs = "No Email Associated with Account";

  Future<void> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString("name");
    final userEmail = prefs.getString("email");

    // Update the UI with the retrieved values
    setState(() {
      userNameFromPrefs = userName ?? "User name"; // Provide a default value if not found
      userEmailFromPrefs = userEmail ?? "No Email Associated with Account"; // Provide a default value if not found
    });
  }
  @override
  void initState() {
    super.initState();
    //Get User Details
    _getUserInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 350,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Image.asset(
                                  'assets/images/hero@2x.png',
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 160, 0, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/user_4@2x.png',
                                        width: MediaQuery.sizeOf(context).width * 0.4,
                                        height: MediaQuery.sizeOf(context).height * 0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                            userNameFromPrefs,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        userEmailFromPrefs,

                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lexend Deca',
                          color: FlutterFlowTheme.of(context).secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(24, 16, 0, 16),
                      child: Text(
                        'Account Settings',
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Lexend Deca',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          Container(
            color:Colors.black ,
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.085,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: AutoSizeText(
                    'Edit Profile',
                    style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                      color: Colors.white, // Change to your desired color
                    ),
                  )
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.90, 0.00),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF95A1AC),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginWidget()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
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
                  'Log out',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}