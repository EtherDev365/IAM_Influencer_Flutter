import 'package:flutter/material.dart';
class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Dialog(
      backgroundColor: Colors.white.withOpacity(0.8),
      insetPadding:EdgeInsets.symmetric(horizontal:0.0, vertical: 0.0),
      child: dialogContent(context),
    );
  }
  Widget dialogContent(BuildContext context) {
    const Color red = Color(0xFFee3d5e);
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.only(top:size.height/20,bottom: size.height/5,left: size.width/10,right: size.width/10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.0,),
            decoration: BoxDecoration(
              color: red.withOpacity(0.5),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.0),),
            child:new Container(
                width:size.width/1.3,
                height: size.height/2,
              child:Column(
                children: [
                  SizedBox(height: size.height/20,),
                  Image.asset("assets/smile.png"),
                  SizedBox(height: size.height/30,),
                  Container(
                    alignment: Alignment.center,
                    child:Text("You need to register \nor\n Log In first to access this page",textAlign:TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/40, color: Colors.white),),),
                   SizedBox(height: size.height/30,),

                  Row(
                   children:[
                         SizedBox(width: size.width/6,),
                          new Image.asset('assets/facebook.png',fit:BoxFit.fill,),
                          SizedBox(width: size.width/12),
                          new Image.asset('assets/google.png',fit:BoxFit.fill,),
                        ]
                  )
                ],
                
              )
                
            ),
          )
        ],
      ),
    );
  }
}