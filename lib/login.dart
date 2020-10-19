import 'dart:convert';
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

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  String google_login_url ="http://36.37.120.131/iam-mobile/api/influencer/auth/login/google";
  String facebook_login_url ="http://36.37.120.131/iam-mobile/api/influencer/auth/login/facebook";
  String name;
  String email;
  String imageUrl;
  String uid;
  bool isSignedIn=false;
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
    uid=user.uid;
    imageUrl = user.photoUrl;
    isSignedIn = await googleSignIn.isSignedIn();
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  Map userProfile;
  final facebookLogin = FacebookLogin();
  _loginWithFB() async{
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          name = profile['name'];
          email =profile['email'];
          uid=profile['id'];
          imageUrl=profile['picture'];
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => loged = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => loged = false );
        break;
    }
  }

  logout(){
    facebookLogin.logOut();
    setState(() {
      loged = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color red = Color(0xFFef5642);
    const Color light_red = Color(0xFFf23367);
    const Color light_grey = Color(0xFFf0afb0);
    return Scaffold(
      body: Center(
        child:Container(
          width: size.width,height: size.height,
          decoration: BoxDecoration(image: DecorationImage(alignment:Alignment.bottomCenter,image:AssetImage("assets/login_people.png"),fit:BoxFit.fitWidth),
            gradient:LinearGradient(colors: [light_red,red],begin: Alignment.bottomCenter,end: Alignment.topCenter,),
            color: red,),
          child: Column(
            children: [
              SizedBox(height: size.height/3.5,),
              Container(height:size.height/20,child:new Image.asset('assets/logo_iam.png',fit:BoxFit.fill,),),
              Text("Creating and Empowering Influencer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.height/80, color: Colors.white),),
              SizedBox(height: size.height/12,),
              Text("Anda Akan Registrasi Sebagai Inluencer",style: TextStyle(fontSize: size.height/45, color: light_grey),),
              SizedBox(height: size.height/3.5,),
              Row(children:[
                SizedBox(width: size.width/4),
                InkWell(onTap: (){ _loginWithFB().whenComplete(() {
                  http.post(Uri.encodeFull(facebook_login_url), body: {
                    "name":name,
                    "email": email,
                    "google_id": uid,
                    "avatar":imageUrl
                  }).then((response) {
                    var convertDataToJson = jsonDecode(response.body);
                    var data=convertDataToJson['data'];
                    if(data['username']==null){Navigator.push(context, MaterialPageRoute(builder: (context) => MyDemo(),));}else{ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));}

                  });
                }).catchError((onError) {
                  Navigator.pushReplacementNamed(context, "/auth");
                });  },child: Container(width:size.width/5,child:new Image.asset('assets/facebook.png',fit:BoxFit.cover,),)),
                SizedBox(width: size.width/8),
                InkWell(onTap: (){

                  signInWithGoogle().whenComplete(() {
                    http.post(Uri.encodeFull(google_login_url), body: {
                      "name":name,
                      "email": email,
                      "google_id": uid,
                      "avatar":imageUrl
                    }).then((response) async {
                      print(response.body.toString());
                      token=jsonDecode(response.body)['token'];
                      loged=true;
                      var convertDataToJson = jsonDecode(response.body);
                      var data=convertDataToJson['data'];
                      if(data['username']==null){Navigator.push(context, MaterialPageRoute(builder: (context) => MyDemo(),));}else{ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));}
                    });
                  }).catchError((onError) {
                  Navigator.pushReplacementNamed(context, "/auth");
                  });
                  },
                    child: Container(width:size.width/5,child:new Image.asset('assets/google.png',fit:BoxFit.cover,),))
              ]
              ),

            ],
        ),
        )
      ),
    );
  }
}