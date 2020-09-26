import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/login.dart';

import 'home/home_page.dart';

class login_splash extends StatefulWidget {
  @override
  _login_splash createState() => _login_splash();
}
class _login_splash extends State<login_splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    HomePage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black1 = Color(0xFF525252);
    const Color black2 = Color(0xFFbcbcbc);

    return Scaffold(
      body: Center(
          child:Container(
            width: size.width,height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,),
            child:Center(
              child: ListView(
                scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: size.height/8),
                Container( height:size.width/1.5, decoration: BoxDecoration(image: DecorationImage(alignment:Alignment.bottomCenter,image:AssetImage("assets/login_splash.png"),fit:BoxFit.fitHeight),),),
                Container(margin:EdgeInsets.only(top:size.height/80),alignment:Alignment.center,child:Text("Hooray!!",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/40, color: black1),),),
                Container(margin:EdgeInsets.only(top: size.height/45, left: size.width/10, right:size.width/10,),alignment: Alignment.center, child:Text("You are now successfully registered as IAM.ID Member. Now you can start applying on a campaign that really suit you. Good Luck!",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: black2),),),
              ],
            ),)

          )
      ),
    );
  }
}
