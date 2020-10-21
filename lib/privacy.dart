import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

class privacy extends StatefulWidget {
  privacy({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _privacy createState() => _privacy();
}
class _privacy extends State<privacy>with AutomaticKeepAliveClientMixin<privacy> {
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
          title:Text("Privacy Policy",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
          ],
        ),
        body:SingleChildScrollView(
            child: Padding( padding: const EdgeInsets.all(20),child: Text("")

            ))
    );
  }

}
