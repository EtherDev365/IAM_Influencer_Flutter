import 'dart:async';
import 'package:flutter_app_kazee5/home/home_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/contactus.dart';
import 'package:flutter_app_kazee5/privacy.dart';
import 'package:flutter_app_kazee5/setting_term.dart';
import 'package:flutter_app_kazee5/privacy.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  Setting({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Setting createState() => _Setting();
}

class _Setting extends State<Setting>
    with AutomaticKeepAliveClientMixin<Setting> {
  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
  }

  String logout = "https://web.iam.id/iam-mobile/api/influencer/auth/logout";

  final facebookLogin = FacebookLogin();
  facebook_logout() {
    facebookLogin.logOut();
    setState(() {
      loged = false;
    });
  }

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  google_signOut() async {
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Settings",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.width / 22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [],
        ),
        body: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 0),
              child: Row(
                children: [
                  Text(
                    "ABOUT US",
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30, left: 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => contactus(),
                        ));
                  },
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 30,
                          child: Image.asset('assets/contactus.png')),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Contact Us",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                    ],
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Term(),
                    ));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 30, left: 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Term and Conditions",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => privacy(),
                    ));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 30, left: 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 25),
            Divider(
              color: Colors.black,
            ),
            InkWell(
              onTap: () {
                var response = http.get(
                    //Encode the url
                    Uri.encodeFull(logout)).then((response) {
                  if (response.statusCode == 200) {
                    google_signOut();
                    facebook_logout();
                  }
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 30, left: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 30, child: Image.asset('assets/logout.png')),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                    ],
                  )),
            )
          ]),
        ));
  }
}
