import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

class contactus extends StatefulWidget {
  contactus({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _contactus createState() => _contactus();
}
class _contactus extends State<contactus>with AutomaticKeepAliveClientMixin<contactus> {
  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text("Contact Us",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
          ],
        ),
        body:Container(margin:EdgeInsets.only(left: 40,right: 40),child: Column(
            children:[
              Container(margin: EdgeInsets.only(top:50,left: 0),
                child:Row(children: [Text("ABOUT US", style: TextStyle(fontSize: 20,color: Colors.black45),)],) ,),
              Container(
                  margin: EdgeInsets.only(top:30,left: 0),
                  child:Row(
                    children: [
                      Container(width: 30,child: Image.asset('assets/fax.png')),
                      SizedBox(width:20,),
                      Text("+62 853-2056-5493", style: TextStyle(fontSize: 17,color: Colors.black87),),],
                  )
              ),
              Container(
                  margin: EdgeInsets.only(top:30,left: 0),
                  child:Row(
                    children: [
                      Container(width: 30,child: Image.asset('assets/mail.png')),
                      SizedBox(width:20,),
                      Text("info@iam.id", style: TextStyle(fontSize: 17,color: Colors.black87),),],
                  )
              ),
            ]

        ),)
    );
  }

}
