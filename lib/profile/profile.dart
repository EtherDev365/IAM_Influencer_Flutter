import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_kazee5/Active/Active.dart';
import 'package:flutter_app_kazee5/Finished/Finished.dart';
import 'package:flutter_app_kazee5/Invitations/Invitations.dart';
import 'package:flutter_app_kazee5/Waiting/Waiting.dart';
import 'package:flutter_app_kazee5/edit_profile.dart';
import 'package:flutter_app_kazee5/profile_tab/Activity.dart';
import 'package:flutter_app_kazee5/profile_tab/Analytics.dart';
import 'package:flutter_app_kazee5/profile_tab/timeline.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';

import '../Setting.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> with SingleTickerProviderStateMixin {
  TabController tabController_profile;
  int index = 0;
  int des = 1;
  int k = 0;
  void initState() {
    profile_opentab = 0;
    tabController_profile = new TabController(length: 3, vsync: this);
    tabController_profile.addListener(() {
      setState(() {
        profile_opentab = tabController_profile.index;
      });
    });
  }

  String kota_url = "https://web.iam.id/iam-mobile/api/influencer/get-kota";
  Future<String> getJsonData_kota(String url, int id_provinsi) async {
    List<String> kkotta;
    http.post(Uri.encodeFull(url), body: {
      "id_provinsi": id_provinsi.toString(),
    }).then((response) {
      if (response.statusCode == 200) {
        var convertDataToJson = jsonDecode(response.body);
        data_kota_edit = convertDataToJson['data'];
      }
      kkotta = List<String>();
      for (int i = 0; i < data_kota_edit.length; i++) {
        kkotta.add(data_kota_edit[i]['name']);
      }
      setState(() {
        kota_edit_profile = kkotta;
      });
    });
    return "Success";
  }
// //edit profile part
//   String editprofile_url="https://web.iam.id/iam-mobile/api/influencer/check-data-availability";
//   Future<String> getJsonData_editprofile(String url) async {
//     var response = await http.get(
//       //Encode the url
//       Uri.encodeFull(url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},).then((response) {
//    if(response.statusCode==200){
//      var convertDataToJson = jsonDecode(response.body);
//      edit_fullname = (convertDataToJson['data']['full_name'] != null)
//          ? convertDataToJson['data']['full_name']
//          : "";
//      edit_gender = (convertDataToJson['data']['gender'] != null)
//          ? convertDataToJson['data']['gender'].toString()
//          : "";
//      edit_email = (convertDataToJson['data']['email'] != null)
//          ? convertDataToJson['data']['email'].toString()
//          : "";
//      edit_handphone = (convertDataToJson['data']['no_handphone'] != null)
//          ? convertDataToJson['data']['no_handphone'].toString()
//          : "";
//      edit_workplace = (convertDataToJson['data']['work'] != null)
//          ? convertDataToJson['data']['work'].toString()
//          : "";
//      edit_religious = (convertDataToJson['data']['religion'] != null)
//          ? convertDataToJson['data']['religion'].toString()
//          : "";
//      birthday = convertDataToJson['data']['tanggal_lahir'];
//      edit_provinsi = (convertDataToJson['data']['province_name'] != null)
//          ? convertDataToJson['data']['province_name'].toString()
//          : "";
//      edit_kota = (convertDataToJson['data']['regencies_name'] != null)
//          ? convertDataToJson['data']['regencies_name'].toString()
//          : null;
//      edit_location = (convertDataToJson['data']['location'] != null)
//          ? convertDataToJson['data']['location'].toString()
//          : "";
//      if(convertDataToJson['data']['province_name'] != null){  getJsonData_kota(kota_url, int.parse(
//          data_provinsi[provinsi.indexOf(edit_provinsi)]['id_provinsi']));}
//
//      Navigator.push(
//          context,
//          CupertinoPageRoute(
//            builder: (context) => edit_profile(),
//          ));
//    }
//     });
//     return "Success";
//   }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loged == false
        ? Container()
        : Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                    child: Stack(
                                  children: [
                                    Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image:
                                              NetworkImage(profile_background),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: size.width / 1.2,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 20),
                                            width: 50.0,
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          Setting(),
                                                    ));
                                              },
                                              child: Image.asset(
                                                "assets/ic_setting.png",
                                                fit: BoxFit.fitHeight,
                                                color: Colors.white,
                                                height: 25.0,
                                                width: 25.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                              Positioned(
                                top: 200,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    margin:
                                        EdgeInsets.only(left: 20, bottom: 20),
                                    padding: EdgeInsets.only(
                                        bottom: 20, right: 5, left: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 5.0,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                        ),
                                        Text(profile_full_name),
                                        SizedBox(height: 10),
                                        Text(
                                          profile_regencies_name,
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        SizedBox(height: 15),
                                        InkWell(
                                          onTap: () {
                                            // getJsonData_editprofile(editprofile_url);
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      edit_profile(),
                                                ));
                                          },
                                          child: Container(
                                            height: 30.0,
                                            width: 105.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: pink_red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100.0))),
                                            child: Text(
                                              "Edit Profile",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Text(
                                              profile_post_count,
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              " Post",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                            SizedBox(
                                              width: size.width / 15,
                                            ),
                                            Text(
                                              profile_followers,
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              " followers",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                            SizedBox(
                                              width: size.width / 15,
                                            ),
                                            Text(
                                              profile_following,
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              " following",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text("Interested in:",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black38))
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: size.width / 1.5,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Container(
                                                  child: Row(
                                                    children: niche
                                                        .map((String char) {
                                                      return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 3,
                                                                  bottom: 3,
                                                                  left: 15,
                                                                  right: 15),
                                                          decoration: BoxDecoration(
                                                              color: blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          child: Text(
                                                            char,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54),
                                                          ));
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: size.width / 20),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (k == 0) {
                                                      k = 1;
                                                    }
                                                  });
                                                },
                                                child: k == 0
                                                    ? Container(
                                                        width: 20,
                                                        child: Image.asset(
                                                            'assets/down.png'))
                                                    : Container())
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        k == 1
                                            ? Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width / 2.4,
                                                          child: Text(
                                                            "Guarantee Reach",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                size.width / 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  des = 1;
                                                                });
                                                                _showDialog();
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                height: 24,
                                                                child: Image.asset(
                                                                    'assets/quote.png'),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                            width:
                                                                size.width / 4,
                                                            child: Text(
                                                              guarantee_reach,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width / 2.4,
                                                          child: Text(
                                                            "Engagement",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                size.width / 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  des = 2;
                                                                });

                                                                _showDialog();
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                height: 24,
                                                                child: Image.asset(
                                                                    'assets/quote.png'),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                            width:
                                                                size.width / 4,
                                                            child: Text(
                                                              "$engagement_rate%",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width / 2.4,
                                                          child: Text(
                                                            "Estimation Reach/Post",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                size.width / 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  des = 3;
                                                                });

                                                                _showDialog();
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                height: 24,
                                                                child: Image.asset(
                                                                    'assets/quote.png'),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                            width:
                                                                size.width / 4,
                                                            child: Text(
                                                              "$est_reach_post",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width / 2.4,
                                                          child: Text(
                                                            "Estimation Reach/Story",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                size.width / 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  des = 4;
                                                                });

                                                                _showDialog();
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                height: 24,
                                                                child: Image.asset(
                                                                    'assets/quote.png'),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                            width:
                                                                size.width / 4,
                                                            child: Text(
                                                              "$est_reach_story",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width / 2.4,
                                                          child: Text(
                                                            "Estimation Price/Post",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                size.width / 10,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  des = 5;
                                                                });
                                                                _showDialog();
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                height: 24,
                                                                child: Image.asset(
                                                                    'assets/quote.png'),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                            width:
                                                                size.width / 4,
                                                            child: Text(
                                                              "$est_low_price-$est_high_price",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: size.width / 1.4,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (k == 1) {
                                                      k = 0;
                                                    }
                                                  });
                                                },
                                                child: k == 1
                                                    ? Container(
                                                        width: 20,
                                                        child: Image.asset(
                                                            'assets/up.png'),
                                                      )
                                                    : Container())
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                              Positioned(
                                left: size.width / 2 - 55,
                                top: 145,
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(profile_avatar)),
                                    border: Border.all(
                                        width: 5,
                                        color: Colors.grey.withOpacity(0.5)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(55.0),
                                  ),
                                  height: 110,
                                  width: 110,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      expandedHeight: k == 0 ? 570 : 780,
                      bottom: PreferredSize(
                          preferredSize: Size.fromHeight(40.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 2),
                                  blurRadius: 5.0,
                                )
                              ],
                            ),
                            height: 40.0,
                            width: MediaQuery.of(context).size.width,
                            child: TabBar(
                                onTap: (index) {
                                  profile_opentab = index;
                                  print(index);
                                },
                                controller: tabController_profile,
                                unselectedLabelColor: kUnselectedLabelColor,
                                labelColor: kSelectedLabelColor,
                                indicatorColor: kSelectedLabelColor,
                                labelStyle: TextStyle(fontSize: 12.0),
                                tabs: [
                                  Tab(
                                    text: "Timeline",
                                  ),
                                  Tab(
                                    text: "Activity",
                                  ),
                                  Tab(
                                    text: "Analytics",
                                  ),
                                ]),
                          )),
                    )
                  ];
                },
                body: TabBarView(
                    controller: tabController_profile,
                    children: [Timeline(), Activity(), Analytics()])));
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        des == 1
                            ? "Guarantee Reach is a surely number of people who seen your post."
                            : des == 2
                                ? "Engagement Rate is the percentage of an indicator of interaction between a social media account and followers."
                                : des == 3
                                    ? "Estimated range and frequency for one feed."
                                    : des == 4
                                        ? "Estimated range and frequency for one story."
                                        : "Estimation Price/Post is estimated fee for one post.",
                        style: TextStyle(height: 1.5, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
