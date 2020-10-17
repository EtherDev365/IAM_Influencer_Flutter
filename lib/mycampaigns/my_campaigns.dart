import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/Active/Active.dart';
import 'package:flutter_app_kazee5/Finished/Finished.dart';
import 'package:flutter_app_kazee5/Invitations/Invitations.dart';
import 'package:flutter_app_kazee5/Waiting/Waiting.dart';
import 'package:flutter_app_kazee5/allcampaigns/all_campaigns.dart';
import 'package:flutter_app_kazee5/favorite/favorite.dart';
import 'package:flutter_app_kazee5/invitation/invitation.dart';
import 'package:flutter_app_kazee5/upcoming/upcoming.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_app_kazee5/utils/color.dart';

import '../LoginDialog.dart';
import '../login.dart';
import '../notification.dart';


class Mycampaigns extends StatefulWidget {
  @override
  _Mycampaigns createState() => _Mycampaigns();
}

class _Mycampaigns extends State<Mycampaigns>with SingleTickerProviderStateMixin {

  TabController tabController_mycampaigns;
  int index = 0;
  int bottomIndex = 0;
  //my campaigns Active part

  @override
  void initState() {
    mycampaigns_open_tab = 0;
    tabController_mycampaigns = new TabController(length: 5, vsync: this);
    tabController_mycampaigns.addListener(() {
      setState(() {

        mycampaigns_open_tab = tabController_mycampaigns.index;
      }); });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body:homeView(context)
    );
  }


  Column homeView(BuildContext context) {
    return Column(
      children: [
        PreferredSize(
           preferredSize: Size.fromHeight(40.0),
            child:  Container(
          height: 40.0,
          width: MediaQuery.of(context).size.width,
          color: kTabbarColor,
          child: TabBar(
              isScrollable: true,
              onTap: (index) {
                mycampaigns_open_tab=index;
                print(index);
              },
              controller: tabController_mycampaigns,
              unselectedLabelColor: kUnselectedLabelColor,
              labelColor: kSelectedLabelColor,
              indicatorColor: kSelectedLabelColor,
              labelStyle: TextStyle(fontSize: 12.0),
              tabs: [
                Tab(
                  text: "Active",
                ),
                Tab(
                  text: "Invitations",
                ),
                Tab(
                  text: "Waiting",
                ),
                Tab(
                  text: "Finished",
                ),
                Tab(
                  text: "Favorite",
                )
              ]),
        )),
        Expanded(
            child: TabBarView(
                controller: tabController_mycampaigns,

                children: [Active(), Invitations(), Waiting(),Finished(),favorite()]))
      ],
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    const Color red = Color(0xFFee7f9f);
    var size = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius:
      BorderRadius.all(Radius.circular(30))),
      backgroundColor: red.withOpacity(0.6),

      content:  Container(
          height: size.height/2,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30.0),),
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
                    SizedBox(width: size.width/12,),
                    new Image.asset('assets/facebook.png',fit:BoxFit.fill,),
                    SizedBox(width: size.width/12),
                    new Image.asset('assets/google.png',fit:BoxFit.fill,),
                  ]
              )
            ],

          )

      ),

    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
