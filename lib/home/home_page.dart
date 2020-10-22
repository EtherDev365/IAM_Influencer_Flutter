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
import '../login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //////////////////////////////////////////////////////////// Login part
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

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  TabController tabController;
  int index = 0;
  int bottomIndex = 0;
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

//edit profile part
  String editprofile_url =
      "https://web.iam.id/iam-mobile/api/influencer/check-data-availability";
  Future<String> getJsonData_editprofile(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    var convertDataToJson = jsonDecode(response.body);
    edit_fullname = (convertDataToJson['data']['full_name'] != null)
        ? convertDataToJson['data']['full_name']
        : "";
    edit_gender = (convertDataToJson['data']['gender'] != null)
        ? convertDataToJson['data']['gender'].toString()
        : "";
    edit_email = (convertDataToJson['data']['email'] != null)
        ? convertDataToJson['data']['email'].toString()
        : "";
    edit_handphone = (convertDataToJson['data']['no_handphone'] != null)
        ? convertDataToJson['data']['no_handphone'].toString()
        : "";
    edit_workplace = (convertDataToJson['data']['work'] != null)
        ? convertDataToJson['data']['work'].toString()
        : "";
    edit_religious = (convertDataToJson['data']['religion'] != null)
        ? convertDataToJson['data']['religion'].toString()
        : "";
    birthday = convertDataToJson['data']['tanggal_lahir'];
    edit_provinsi = (convertDataToJson['data']['province_name'] != null)
        ? convertDataToJson['data']['province_name'].toString()
        : "";
    edit_kota = (convertDataToJson['data']['regencies_name'] != null)
        ? convertDataToJson['data']['regencies_name'].toString()
        : null;
    edit_location = (convertDataToJson['data']['location'] != null)
        ? convertDataToJson['data']['location'].toString()
        : "";

    if (convertDataToJson['data']['province_name'] != null) {
      getJsonData_kota(
          kota_url,
          int.parse(
              data_provinsi[provinsi.indexOf(edit_provinsi)]['id_provinsi']));
    }
    return "Success";
  }

  //my campaigns favorite part
  String url_mycampaigns_favorite =
      "https://web.iam.id/iam-mobile/api/influencer/favorite-campaign";
  Future<String> getJsonData_mycampaigns_favorite(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_favorite = convertDataToJson['data'];
    });
    return "Success";
  }

  //my campaigns finished part
  String url_mycampaigns_finished =
      "https://web.iam.id/iam-mobile/api/influencer/my-campaign/finished";
  Future<String> getJsonData_mycampaigns_finished(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_finished = convertDataToJson['data'];
    });
    return "Success";
  }

  //my camapigns waiting part
  String url_mycampaigns_waiting =
      "https://web.iam.id/iam-mobile/api/influencer/my-campaign/waiting";
  Future<String> getJsonData_mycampaigns_waiting(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_waiting = convertDataToJson['data'];
    });
    return "Success";
  }

//my campaigns invitations part
  String url_mycampaigns_invitations =
      "https://web.iam.id/iam-mobile/api/influencer/my-campaign/invitation";
  Future<String> getJsonData_mycampaignsinvitations(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_mycampaigns_invitation = convertDataToJson['data'];
    });
    return "Success";
  }

  //my campaigns Active part
  String url_active =
      "https://web.iam.id/iam-mobile/api/influencer/my-campaign/active";
  Future<String> getJsonData_active(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_active = convertDataToJson['data'];
    });
    return "Success";
  }

  //home invitation part
  var url_invitation =
      "https://web.iam.id/iam-mobile/api/influencer/my-campaign/invitation";
  Future<String> getJsonData_invitation(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_invitations = convertDataToJson['data'];
      print(response.body);
    });
    return "Success";
  }

  String url_notifikasi =
      "https://web.iam.id/iam-mobile/api/influencer/notifikasi";
  Future<String> getJsonData_notifikasi(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_notifikasi = convertDataToJson['data'];
      print(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    open_tab = 0;
    tabController = new TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        open_tab = tabController.index;
      });
    });
    super.initState();

    if (loged == true) {
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
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: bottomIndex == 0
                  ? Image.asset(
                      "assets/logo 198@3x.png",
                      height: 20.0,
                    )
                  : (bottomIndex == 2 ? Text("My Campaigns") : Text("Profile")),
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
                      if (loged == false) {
                        showAlertDialog(context);
                      } else {
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: bottomIndex == 0
                ? InkWell(
                    onTap: () {
                      if (open_tab == 0) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Filter(),
                            ));
                      } else if (open_tab == 1) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Filter_upcoming(),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Filter_invitation(),
                            ));
                      }
                    },
                    child: Container(
                      height: 35.0,
                      width: 105.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: kLinearGradient,
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: Text(
                        "Filter",
                        style: TextStyle(color: kBackgoundColor),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            bottomNavigationBar: Container(
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
                                Image.asset("assets/home137@3x.png",
                                    height: 20,
                                    color: (bottomIndex == 0)
                                        ? knavigationSelectedLabelColor
                                        : kBackgoundColor),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      color: (bottomIndex == 0)
                                          ? knavigationSelectedLabelColor
                                          : kBackgoundColor,
                                      fontSize: 12.0),
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
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => Search(),
                                  ));
                            });
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/search 208@3x.png",
                                    height: 20,
                                    color: (bottomIndex == 1)
                                        ? knavigationSelectedLabelColor
                                        : kBackgoundColor),
                                Text(
                                  "Search",
                                  style: TextStyle(
                                      color: (bottomIndex == 1)
                                          ? knavigationSelectedLabelColor
                                          : kBackgoundColor,
                                      fontSize: 12.0),
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
                              if (loged == false) {
                                showAlertDialog(context);
                              } else {
                                bottomIndex = 2;
                              }
                              if (data_active != null) {
                                if ((5 >= data_active.length)) {
                                  active_items.clear();
                                  active_items.addAll(data_active);
                                  active_present = data_active.length;
                                } else {
                                  active_items.clear();
                                  active_items
                                      .addAll(data_active.getRange(0, 5));
                                  active_present = 5;
                                }
                              }
                              if (data_mycampaigns_invitation != null) {
                                print(data_mycampaigns_invitation);
                                if ((5 >= data_mycampaigns_invitation.length)) {
                                  mycampaigns_invitation_items.clear();
                                  mycampaigns_invitation_items
                                      .addAll(data_mycampaigns_invitation);
                                  mycampaigns_invitation_present =
                                      data_mycampaigns_invitation.length;
                                } else {
                                  mycampaigns_invitation_items.clear();
                                  mycampaigns_invitation_items.addAll(
                                      data_mycampaigns_invitation.getRange(
                                          0, 5));
                                  mycampaigns_invitation_present = 5;
                                }
                              }
                              if (data_mycampaigns_waiting != null) {
                                if ((5 >= data_mycampaigns_waiting.length)) {
                                  mycampaigns_waiting_items.clear();
                                  mycampaigns_waiting_items
                                      .addAll(data_mycampaigns_waiting);
                                  mycampaigns_waiting_present =
                                      data_mycampaigns_waiting.length;
                                } else {
                                  mycampaigns_waiting_items.clear();
                                  mycampaigns_waiting_items.addAll(
                                      data_mycampaigns_waiting.getRange(0, 5));
                                  mycampaigns_waiting_present = 5;
                                }
                              }
                              if (data_mycampaigns_finished != null) {
                                if ((5 >= data_mycampaigns_finished.length)) {
                                  mycampaigns_finished_items.clear();
                                  mycampaigns_finished_items
                                      .addAll(data_mycampaigns_finished);
                                  mycampaigns_finished_present =
                                      data_mycampaigns_finished.length;
                                } else {
                                  mycampaigns_finished_items.clear();
                                  mycampaigns_finished_items.addAll(
                                      data_mycampaigns_finished.getRange(0, 5));
                                  mycampaigns_finished_present = 5;
                                }
                              }
                              if (data_mycampaigns_favorite != null) {
                                if ((5 >= data_mycampaigns_favorite.length)) {
                                  mycampaigns_favorite_items.clear();
                                  mycampaigns_favorite_items
                                      .addAll(data_mycampaigns_favorite);
                                  mycampaigns_favorite_present =
                                      data_mycampaigns_favorite.length;
                                } else {
                                  mycampaigns_favorite_items.clear();
                                  mycampaigns_favorite_items.addAll(
                                      data_mycampaigns_favorite.getRange(0, 5));
                                  mycampaigns_favorite_present = 5;
                                }
                              }
                            });
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/speaker 137@3x.png",
                                    height: 20,
                                    color: (bottomIndex == 2)
                                        ? knavigationSelectedLabelColor
                                        : kBackgoundColor),
                                Text(
                                  "My Campaigns",
                                  style: TextStyle(
                                      color: (bottomIndex == 2)
                                          ? knavigationSelectedLabelColor
                                          : kBackgoundColor,
                                      fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () async {
                            if (loged == false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondScreen()));
                            } else {
                              setState(() {
                                bottomIndex = 3;
                              });
                            }
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/account 136@3x.png",
                                    height: 20,
                                    color: (bottomIndex == 3)
                                        ? knavigationSelectedLabelColor
                                        : kBackgoundColor),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: (bottomIndex == 3)
                                          ? knavigationSelectedLabelColor
                                          : kBackgoundColor,
                                      fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ))));
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
                open_tab = index;
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
                    onTap: () {
                      if (loged == false) {
                        showAlertDialog(context);
                      } else {
                        tabController.animateTo(2);
                      }
                    },
                    child: Tab(
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: red.withOpacity(0.6),
      content: Container(
          height: size.height / 2,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Image.asset("assets/smile.png"),
              SizedBox(
                height: size.height / 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "You need to register \nor\n Log In first to access this page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: size.height / 40,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          _loginWithFB().whenComplete(() {
                            http.post(Uri.encodeFull(facebook_login_url),
                                body: {
                                  "name": name,
                                  "email": email,
                                  "google_id": uid,
                                  "avatar": imageUrl
                                }).then((response) {
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
                    SizedBox(width: size.width / 12),
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
          )),
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
