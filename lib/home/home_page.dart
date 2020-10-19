import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/Active/Active.dart';
import 'package:flutter_app_kazee5/allcampaigns/all_campaigns.dart';
import 'package:flutter_app_kazee5/detailcampaign/detailcampaign.dart';
import 'package:flutter_app_kazee5/filter/filter.dart';
import 'package:flutter_app_kazee5/filter/filter_invitation.dart';
import 'package:flutter_app_kazee5/filter/filter_upcoming.dart';
import 'package:flutter_app_kazee5/invitation/invitation.dart';
import 'package:flutter_app_kazee5/mycampaigns/my_campaigns.dart';
import 'package:flutter_app_kazee5/profile/profile.dart';
import 'package:flutter_app_kazee5/search/search.dart';
import 'package:flutter_app_kazee5/upcoming/upcoming.dart';
import 'package:flutter_app_kazee5/notification.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

import '../login.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int index = 0;
  int bottomIndex = 0;
  String kota_url="http://36.37.120.131/iam-mobile/api/influencer/get-kota";
  Future<String> getJsonData_kota(String url,int id_provinsi) async {
    List<String> kkotta;
    http.post(Uri.encodeFull(url), body: {
      "id_provinsi":id_provinsi.toString(),
    }).then((response) {
      if(response.statusCode==200){  var convertDataToJson = jsonDecode(response.body);
      data_kota_edit = convertDataToJson['data'];}
      kkotta=List<String>();
      for(int i=0;i<data_kota_edit.length;i++){kkotta.add(data_kota_edit[i]['name']);}
      setState(() {
        kota_edit_profile=kkotta;
      });
    });
    return "Success";
  }



  //profile
  String profile_url="http://36.37.120.131/iam-mobile/api/influencer/data/detail";
  Future<String> getJsonData_profile(String url) async {

    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
      var convertDataToJson = jsonDecode(response.body);
      setState(() {
        profile_full_name=(convertDataToJson['data']['full_name']!=null)?convertDataToJson['data']['full_name']:"";
        profile_background=(convertDataToJson['data']['backround']!=null)?convertDataToJson['data']['backround'].toString():"";
        profile_avatar=(convertDataToJson['data']['avatar']!=null)?convertDataToJson['data']['avatar'].toString():"";
        profile_regencies_name =(convertDataToJson['data']['regencies_name']!=null)?convertDataToJson['data']['regencies_name'].toString():"";
        profile_post_count =(convertDataToJson['data']['post_count']!=null)?convertDataToJson['data']['post_count'].toString():"";
        profile_followers =(convertDataToJson['data']['followers']!=null)?convertDataToJson['data']['followers'].toString():"";
        profile_following =(convertDataToJson['data']['following']!=null)?convertDataToJson['data']['following'].toString():"";
        profile_niche =(convertDataToJson['data']['niche']!=null)?convertDataToJson['data']['niche'].toString():null;
        niche = profile_niche.split(",");
        guarantee_reach =(convertDataToJson['data']['guarantee_reach']!=null)?convertDataToJson['data']['guarantee_reach'].toString():"";
        engagement_rate =(convertDataToJson['data']['engagement_rate']!=null)?convertDataToJson['data']['engagement_rate'].toString():"";
        est_reach_post =(convertDataToJson['data']['est_reach_post']!=null)?convertDataToJson['data']['est_reach_post'].toString():"";
        est_reach_story=(convertDataToJson['data']['est_reach_story']!=null)?convertDataToJson['data']['est_reach_story'].toString():"";
        est_low_price =(convertDataToJson['data']['est_low_price']!=null)?convertDataToJson['data']['est_low_price'].toString():"";
        est_high_price =(convertDataToJson['data']['est_high_price']!=null)?convertDataToJson['data']['est_high_price'].toString():"";
      });
    return "Success";
  }
  //edit profile part
  String editprofile_url="http://36.37.120.131/iam-mobile/api/influencer/check-data-availability";
  Future<String> getJsonData_editprofile(String url) async {

    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    var convertDataToJson = jsonDecode(response.body);
    edit_fullname=(convertDataToJson['data']['full_name']!=null)?convertDataToJson['data']['full_name']:"";
    edit_gender=(convertDataToJson['data']['gender']!=null)?convertDataToJson['data']['gender'].toString():"";
    edit_email=(convertDataToJson['data']['email']!=null)?convertDataToJson['data']['email'].toString():"";
    edit_handphone =(convertDataToJson['data']['no_handphone']!=null)?convertDataToJson['data']['no_handphone'].toString():"";
    edit_workplace =(convertDataToJson['data']['work']!=null)?convertDataToJson['data']['work'].toString():"";
    edit_religious =(convertDataToJson['data']['religion']!=null)?convertDataToJson['data']['religion'].toString():"";
    birthday=convertDataToJson['data']['tanggal_lahir'];
    edit_provinsi =(convertDataToJson['data']['province_name']!=null)?convertDataToJson['data']['province_name'].toString():"";
    edit_kota =(convertDataToJson['data']['regencies_name']!=null)?convertDataToJson['data']['regencies_name'].toString():null;
    edit_location =(convertDataToJson['data']['location']!=null)?convertDataToJson['data']['location'].toString():"";
    getJsonData_kota(kota_url,int.parse(data_provinsi[provinsi.indexOf(edit_provinsi)]['id_provinsi']));
    return "Success";
  }

  //my campaigns favorite part
  String url_mycampaigns_favorite="http://36.37.120.131/iam-mobile/api/influencer/favorite-campaign";
  Future<String> getJsonData_mycampaigns_favorite(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_favorite = convertDataToJson['data'];

    });
    return "Success";
  }
  //my campaigns finished part
  String url_mycampaigns_finished="http://36.37.120.131/iam-mobile/api/influencer/my-campaign/finished";
  Future<String> getJsonData_mycampaigns_finished(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_finished = convertDataToJson['data'];
    });
    return "Success";
  }
  //my camapigns waiting part
  String url_mycampaigns_waiting="http://36.37.120.131/iam-mobile/api/influencer/my-campaign/waiting";
  Future<String> getJsonData_mycampaigns_waiting(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_waiting = convertDataToJson['data'];
    });
    return "Success";
  }
//my campaigns invitations part
  String url_mycampaigns_invitations="http://36.37.120.131/iam-mobile/api/influencer/my-campaign/invitation";
  Future<String> getJsonData_mycampaignsinvitations(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_invitation = convertDataToJson['data'];
    });
    return "Success";
  }
  //my campaigns Active part
  String url_active="http://36.37.120.131/iam-mobile/api/influencer/my-campaign/active";
  Future<String> getJsonData_active(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_active = convertDataToJson['data'];
    });
    return "Success";
  }
  //home invitation part
  var url_invitation="http://36.37.120.131/iam-mobile/api/influencer/my-campaign/invitation";
  Future<String> getJsonData_invitation(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_invitations = convertDataToJson['data'];
      print(response.body);
    });
    return "Success";
  }
  String url_notifikasi="http://36.37.120.131/iam-mobile/api/influencer/notifikasi";
  Future<String> getJsonData_notifikasi(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_notifikasi = convertDataToJson['data'];
      print(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    open_tab=0;
    tabController = new TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        open_tab = tabController.index;
      }); });
    super.initState();

    if(loged==true){

    getJsonData_profile(profile_url);
    getJsonData_editprofile(editprofile_url);
    getJsonData_invitation(url_invitation);
    getJsonData_notifikasi(url_notifikasi);
    getJsonData_active(url_active);
    getJsonData_mycampaignsinvitations(url_mycampaigns_invitations);
    getJsonData_mycampaigns_waiting(url_mycampaigns_waiting);
    getJsonData_mycampaigns_finished(url_mycampaigns_finished);
    getJsonData_mycampaigns_favorite(url_mycampaigns_favorite);

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: bottomIndex==0?Image.asset(
            "assets/logo 198@3x.png",
            height: 20.0,
          ):(bottomIndex==2?Text("My Campaigns"):Text("Profile")),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
            IconButton(
                icon: Image.asset(
                  "assets/bell 155@3x.png",
                  height: 25.0,
                ),
                onPressed: () {
                  if(loged==false){showAlertDialog(context);
                  Timer(Duration(seconds: 2),
                          ()=>Navigator.pushReplacement(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              SecondScreen()
                          )
                      ));
                  }else{
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => notification(),
                        ));
                  }

                })
          ],
        ),
        body: IndexedStack(
          index: bottomIndex,
          children: [
            homeView(context),
            Search(),
            Mycampaigns(),
            Profile(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: bottomIndex == 0
            ? InkWell(

          onTap: () {
            if(open_tab==0) {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Filter(),
                  ));
            }else if(open_tab==1){ Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Filter_upcoming(),
                ));}
            else{ Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Filter_invitation(),
                ));}
          },
          child: Container(
            height: 35.0,
            width: 105.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: kLinearGradient,
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            child: Text(
              "Filter",
              style: TextStyle(color: kBackgoundColor),
            ),
          ),
        )
            : SizedBox.shrink(),
        bottomNavigationBar:Container(
            height: 55.0,
            decoration: BoxDecoration(
                gradient: kLinearGradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.0),
                    topRight: Radius.circular(14.0))),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bottomIndex = 0;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/home137@3x.png",
                                height: 20,
                                color: (bottomIndex==0)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  color: (bottomIndex==0)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if(loged==false){
                            showAlertDialog(context);
                            Timer(Duration(seconds: 2),
                                    ()=>Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        SecondScreen()
                                    )
                                ));
                          }else{
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => Search(),
                                ));}

                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/search 208@3x.png",
                                height: 20, color: (bottomIndex==1)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  color: (bottomIndex==1)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if(loged==false){
                            showAlertDialog(context);
                            Timer(Duration(seconds: 2),
                                    ()=>Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        SecondScreen()
                                    )
                                ));
                          }else{
                            bottomIndex=2;
                          }
                          if(data_active!=null){ if((5>=data_active.length)){active_items.clear();active_items.addAll(data_active);active_present=data_active.length;}else{active_items.clear();active_items.addAll(data_active.getRange(0, 5));active_present=5;}}
                          if(data_mycampaigns_invitation!=null){print(data_mycampaigns_invitation); if((5>=data_mycampaigns_invitation.length)){mycampaigns_invitation_items.clear();mycampaigns_invitation_items.addAll(data_mycampaigns_invitation);mycampaigns_invitation_present=data_mycampaigns_invitation.length;}else{mycampaigns_invitation_items.clear();mycampaigns_invitation_items.addAll(data_mycampaigns_invitation.getRange(0, 5));mycampaigns_invitation_present=5;}}
                          if(data_mycampaigns_waiting!=null){ if((5>=data_mycampaigns_waiting.length)){mycampaigns_waiting_items.clear();mycampaigns_waiting_items.addAll(data_mycampaigns_waiting);mycampaigns_waiting_present=data_mycampaigns_waiting.length;}else{mycampaigns_waiting_items.clear();mycampaigns_waiting_items.addAll(data_mycampaigns_waiting.getRange(0, 5));mycampaigns_waiting_present=5;}}
                          if(data_mycampaigns_finished!=null){ if((5>=data_mycampaigns_finished.length)){mycampaigns_finished_items.clear();mycampaigns_finished_items.addAll(data_mycampaigns_finished);mycampaigns_finished_present=data_mycampaigns_finished.length;}else{mycampaigns_finished_items.clear();mycampaigns_finished_items.addAll(data_mycampaigns_finished.getRange(0, 5));mycampaigns_finished_present=5;}}
                          if(data_mycampaigns_favorite!=null){ if((5>=data_mycampaigns_favorite.length)){mycampaigns_favorite_items.clear();mycampaigns_favorite_items.addAll(data_mycampaigns_favorite);mycampaigns_favorite_present=data_mycampaigns_favorite.length;}else{mycampaigns_favorite_items.clear();mycampaigns_favorite_items.addAll(data_mycampaigns_favorite.getRange(0, 5));mycampaigns_favorite_present=5;}}
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/speaker 137@3x.png",
                                height: 20, color: (bottomIndex==2)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "My Campaigns",
                              style: TextStyle(
                                  color: (bottomIndex==2)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {

                          if(loged==false){
                            showAlertDialog(context);
                            Timer(Duration(seconds: 2),
                                    ()=>Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        SecondScreen()
                                    )
                                ));
                          }else{
                            setState(() {
                              bottomIndex=3;
                            });

                          }

                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/account 136@3x.png",
                                height: 20, color: (bottomIndex==3)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                  color: (bottomIndex==3)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            )));
  }

  Column homeView(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.0,
          width: MediaQuery.of(context).size.width,
          color: kTabbarColor,
          child: TabBar(
              onTap: (index) {
                open_tab=index;
                print(index);
              },
              controller: tabController,
              unselectedLabelColor: kUnselectedLabelColor,
              labelColor: kSelectedLabelColor,
              indicatorColor: kSelectedLabelColor,
              labelStyle: TextStyle(fontSize: 12.0),
              tabs: [
                Tab(
                  text: "All Campaigns",
                ),
                Tab(
                  text: "Upcoming",
                ),
                InkWell(
                    onTap: (){
                      if(loged==false){
                        showAlertDialog(context);
                        Timer(Duration(seconds: 2),
                                ()=>Navigator.pushReplacement(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    SecondScreen()
                                )
                            ));
                      }else{
                        tabController.animateTo(2);}
                    },
                    child:Tab(
                      text: "Invitation",
                    ))
              ]),
        ),
        Expanded(
            child: TabBarView(
                controller: tabController,

                children: [AllCampaigns(), UpComing(), Invitation()]))
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
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
