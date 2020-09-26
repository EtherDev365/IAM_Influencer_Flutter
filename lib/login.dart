import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/login_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final facebookLogin = FacebookLogin();
  _loginWithFB() async{
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => isLoggedIn = false );
        break;
    }

  }

  facebook_logout(){
    facebookLogin.logOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  google_logout(){
    _googleSignIn.signOut();
    setState(() {
      isLoggedIn = false;
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
              FlatButton(
                color:Colors.transparent,
                child:Text("Anda Akan Registrasi Sebagai Inluencer",style: TextStyle(fontSize: size.height/45, color: light_grey),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyDemo(),));
                },
              ),
              SizedBox(height: size.height/3.5,),
              Row(children:[
                SizedBox(width: size.width/4),
                InkWell(child:Container(width:size.width/5,child:new Image.asset('assets/facebook.png',fit:BoxFit.cover,),), onTap: () {  _login()();
                },),
                SizedBox(width: size.width/8),
                InkWell(child:Container(width:size.width/5,child:new Image.asset('assets/google.png',fit:BoxFit.cover,),), onTap: () { _login();
                },)
              ]
              ),

            ],
        ),
        )
      ),
    );
  }
}