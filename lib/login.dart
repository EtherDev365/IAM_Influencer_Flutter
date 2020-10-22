import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/home/home_page.dart';
import 'package:flutter_app_kazee5/login_page.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_session/flutter_session.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
//load profile page data
  String profile_url =
      "https://web.iam.id/iam-mobile/api/influencer/data/detail";
  Future<String> getJsonData_profile(String url) async {
    var response = await http.get(
      Uri.encodeFull(profile_url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    ).then((response) {
      if (response.statusCode == 200) {
        var convertDataToJson = jsonDecode(response.body);
        if (convertDataToJson['status'] == 1) {
          setState(() {
            profile_full_name = (convertDataToJson['data']['full_name'] != null)
                ? convertDataToJson['data']['full_name']
                : "";
            profile_background =
                (convertDataToJson['data']['backround'] != null)
                    ? convertDataToJson['data']['backround'].toString()
                    : "";
            profile_avatar = (convertDataToJson['data']['avatar'] != null)
                ? convertDataToJson['data']['avatar'].toString()
                : "";
            profile_regencies_name =
                (convertDataToJson['data']['regencies_name'] != null)
                    ? convertDataToJson['data']['regencies_name'].toString()
                    : "";
            profile_post_count =
                (convertDataToJson['data']['post_count'] != null)
                    ? convertDataToJson['data']['post_count'].toString()
                    : "";
            profile_followers = (convertDataToJson['data']['followers'] != null)
                ? convertDataToJson['data']['followers'].toString()
                : "";
            profile_following = (convertDataToJson['data']['following'] != null)
                ? convertDataToJson['data']['following'].toString()
                : "";
            profile_niche = (convertDataToJson['data']['niche'] != null)
                ? convertDataToJson['data']['niche'].toString()
                : null;
            niche = profile_niche.split(",");
            guarantee_reach =
                (convertDataToJson['data']['guarantee_reach'] != null)
                    ? convertDataToJson['data']['guarantee_reach'].toString()
                    : "";
            engagement_rate =
                (convertDataToJson['data']['engagement_rate'] != null)
                    ? convertDataToJson['data']['engagement_rate'].toString()
                    : "";
            est_reach_post =
                (convertDataToJson['data']['est_reach_post'] != null)
                    ? convertDataToJson['data']['est_reach_post'].toString()
                    : "";
            est_reach_story =
                (convertDataToJson['data']['est_reach_story'] != null)
                    ? convertDataToJson['data']['est_reach_story'].toString()
                    : "";
            est_low_price = (convertDataToJson['data']['est_low_price'] != null)
                ? convertDataToJson['data']['est_low_price'].toString()
                : "";
            est_high_price =
                (convertDataToJson['data']['est_high_price'] != null)
                    ? convertDataToJson['data']['est_high_price'].toString()
                    : "";
          });
        } else {
          profile_full_name = "";
          profile_background = "";
          profile_avatar = "";
          profile_regencies_name = "";
          profile_post_count = "";
          profile_followers = "";
          profile_following = "";
          profile_niche = "";
          niche = List<String>();
          guarantee_reach = "";
          engagement_rate = "";
          est_reach_post = "";
          est_reach_story = "";
          est_low_price = "";
          est_high_price = "";
        }
      }
    });
    getJsonData_timeline(timeline);
    return "Success";
  }

  String timeline =
      "https://web.iam.id/iam-mobile/api/influencer/timeline-activity";
  Future<String> getJsonData_timeline(String url) async {
    var response = await http.get(
      Uri.encodeFull(timeline),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    ).then((response) {
      if (response.statusCode == 200) {
        var convertTojson = jsonDecode(response.body);
        if (convertTojson['status'] == 1) {
          setState(() {
            data_timeline = convertTojson['data'];
          });
        } else {
          data_timeline = null;
        }
      }
    });
    getJsonData_activity(activity);
    return "success";
  }

  String activity =
      "https://web.iam.id/iam-mobile/api/influencer/history-campaign";
  Future<String> getJsonData_activity(String url) async {
    var response = await http.get(
      Uri.encodeFull(activity),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    ).then((response) {
      if (response.statusCode == 200) {
        var convertDataToJson = jsonDecode(response.body);
        if (convertDataToJson['status'] == 1) {
          setState(() {
            data_activity = convertDataToJson['data'];
          });
        } else {}
      }
    });
    // goto login_splash
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
    return "Success";
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  String google_login_url =
      "https://web.iam.id/iam-mobile/api/influencer/auth/login/google";
  String facebook_login_url =
      "https://web.iam.id/iam-mobile/api/influencer/auth/login/facebook";
  String name;
  String email;
  String imageUrl;
  String uid;
  bool isSignedIn = false;
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    name = user.displayName;
    email = user.email;
    uid = user.uid;
    imageUrl = user.photoUrl;
    isSignedIn = await googleSignIn.isSignedIn();
    return 'signInWithGoogle succeeded: $user';
  }

  Map userProfile;
  final facebookLogin = FacebookLogin();
  _loginWithFB() async {
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        final token = facebookLoginResult.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          name = profile['name'];
          email = profile['email'];
          uid = profile['id'];
          imageUrl = profile['picture'];
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => loged = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => loged = false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color red = Color(0xFFef5642);
    const Color light_red = Color(0xFFf23367);
    const Color light_grey = Color(0xFFf0afb0);
    return Scaffold(
      body: Center(
          child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.bottomCenter,
              image: AssetImage("assets/login_people.png"),
              fit: BoxFit.fitWidth),
          gradient: LinearGradient(
            colors: [light_red, red],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          color: red,
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 3.5,
            ),
            Container(
              height: size.height / 20,
              child: new Image.asset(
                'assets/logo_iam.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              "Creating and Empowering Influencer",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.height / 80,
                  color: Colors.white),
            ),
            SizedBox(
              height: size.height / 12,
            ),
            Text(
              "Anda Akan Registrasi Sebagai Inluencer",
              style: TextStyle(fontSize: size.height / 45, color: light_grey),
            ),
            SizedBox(
              height: size.height / 3.5,
            ),
            Row(children: [
              SizedBox(width: size.width / 4),
              InkWell(
                  onTap: () {
                    _loginWithFB().whenComplete(() {
                      print("NOOOONONONOoooooooooooooooooooo");
                      http.post(Uri.encodeFull(facebook_login_url), body: {
                        "name": name,
                        "email": email,
                        "google_id": uid,
                        "avatar": imageUrl
                      }).then((response) {
                        print(
                            "haooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
                        var convertDataToJson = jsonDecode(response.body);
                        var data = convertDataToJson['data'];
                        if (data['username'] == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyDemo(),
                              ));
                        } else {
                          getJsonData_profile(profile_url);
                        }
                      });
                    }).catchError((onError) {
                      Navigator.pushReplacementNamed(context, "/auth");
                    });
                  },
                  child: Container(
                    width: size.width / 5,
                    child: new Image.asset(
                      'assets/facebook.png',
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(width: size.width / 8),
              InkWell(
                  onTap: () {
                    // http.post(Uri.encodeFull(google_login_url), body: {
                    //   "name":"Mr Park",
                    //   "email": "bymrpark@gmail.com",
                    //   "google_id": "v641RhNch6gZngXwGsmh36ERNaO2",
                    //
                    // }).then((response) async {
                    //   print(response.body.toString());
                    //   token=jsonDecode(response.body)['token'];
                    //   loged=true;
                    //   var convertDataToJson = jsonDecode(response.body);
                    //   var data=convertDataToJson['data'];
                    //   if(data['username']==null){Navigator.push(context, MaterialPageRoute(builder: (context) => MyDemo(),));}else{
                    //     getJsonData_profile(profile_url);}
                    // });

                    signInWithGoogle().whenComplete(() {
                      http.post(Uri.encodeFull(google_login_url), body: {
                        "name": name,
                        "email": email,
                        "google_id": uid,
                        "avatar": imageUrl
                      }).then((response) async {
                        print(response.body.toString());
                        token = jsonDecode(response.body)['token'];
                        loged = true;
                        var convertDataToJson = jsonDecode(response.body);
                        var data = convertDataToJson['data'];
                        if (data['username'] == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyDemo(),
                              ));
                        } else {
                          getJsonData_profile(profile_url);
                        }
                      });
                    }).catchError((onError) {
                      Navigator.pushReplacementNamed(context, "/auth");
                    });
                  },
                  child: Container(
                    width: size.width / 5,
                    child: new Image.asset(
                      'assets/google.png',
                      fit: BoxFit.cover,
                    ),
                  ))
            ]),
          ],
        ),
      )),
    );
  }
}
