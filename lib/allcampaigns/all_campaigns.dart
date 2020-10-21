import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/LoginDialog.dart';
import 'package:flutter_app_kazee5/component/gradient_button.dart';
import 'package:flutter_app_kazee5/detailcampaign/detailcampaign.dart';
import 'package:flutter_app_kazee5/login.dart';
import 'package:flutter_app_kazee5/notification.dart';
import 'package:flutter_app_kazee5/search/search.dart';
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
class AllCampaigns extends StatefulWidget {
  @override
  _AllCampaignsState createState() => _AllCampaignsState();
}

class _AllCampaignsState extends State<AllCampaigns>with AutomaticKeepAliveClientMixin<AllCampaigns> {
  @override
  bool get wantKeepAlive => true;

  //////////////////////////////////////////////////////////// Login part
  //load profile page data
  String profile_url="http://36.37.120.131/iam-mobile/api/influencer/data/detail";
  Future<String> getJsonData_profile(String url) async {
    var response = await http.get(
      Uri.encodeFull(profile_url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},).then((response) {
      if(response.statusCode==200){var   convertDataToJson = jsonDecode(response.body);
      if(convertDataToJson['status']==1){
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

        });}else{profile_full_name="";profile_background="";profile_avatar="";profile_regencies_name="";profile_post_count="";profile_followers="";profile_following="";profile_niche="";niche=List<String>();guarantee_reach="";engagement_rate="";est_reach_post="";est_reach_story="";est_low_price="";est_high_price="";
      }
      }
    });
    getJsonData_timeline(timeline);
    return "Success";
  }
  String timeline="http://36.37.120.131/iam-mobile/api/influencer/timeline-activity";
  Future<String> getJsonData_timeline(String url) async {
    var response = await http.get(
      Uri.encodeFull(timeline), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},).then((response) {
      if(response.statusCode==200){var convertTojson=jsonDecode(response.body);
      if(convertTojson['status']==1){
        setState(() {
          data_timeline=convertTojson['data'];

        });}else{data_timeline=null;
      }
      }
    });
    getJsonData_activity(activity);
    return "success";
  }
  String activity="http://36.37.120.131/iam-mobile/api/influencer/history-campaign";
  Future<String> getJsonData_activity(String url) async {
    var response = await http.get(
      Uri.encodeFull(activity), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},).then((response) {
      if(response.statusCode==200){var convertDataToJson = jsonDecode(response.body);
      if(convertDataToJson['status']==1){
        setState(() {
          data_activity=convertDataToJson['data'];
        });}else{
      }
      }
    });
    // goto login_splash
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    return "Success";
  }


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



  Map userProfile;
  final facebookLogin = FacebookLogin();
  _loginWithFB() async{
    var facebookLoginResult =
    await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        final token = facebookLoginResult.accessToken.token;
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





  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String save_url="http://36.37.120.131/iam-mobile/api/save-campaign";
  String delete_url="http://36.37.120.131/iam-mobile/api/delete-campaign";
  String check_url="http://36.37.120.131/iam-mobile/api/check-save-campaign";
  String list_saved="http://36.37.120.131/iam-mobile/api/list-save-campaign";
  int perPage  = 5;
  int present = 0;
  List data;
  List<String> data_saved_id=new List();

  void initState() {

    super.initState();
    items.clear();
    setState(() {
      if(data_allcampagins!=null){ if((5>=data_allcampagins.length)){items.clear();items.addAll(data_allcampagins);present=data_allcampagins.length;}else{items.clear();items.addAll(data_allcampagins.getRange(0, 5));present=5;}}
      if(loged==true){http.get(Uri.encodeFull(list_saved), headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {var rep = jsonDecode(response.body);data=rep['data'];for(int i=0;i<data.length;i++){data_saved_id.add(data[i]['id_campaign'].toString());}});}
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);
    return data_allcampagins!=null? Stack(
      children: [
        new ListView.builder(
            itemCount:(present < data_allcampagins.length) ? items.length + 1 : items.length,
            itemBuilder: (BuildContext context, int index) {
              return ((index == items.length )&&(index!=data_allcampagins.length)) ?
              InkWell( child:Container(
                  margin: EdgeInsets.only(bottom: 80),
                  height: 35.0,width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: kLinearGradient,
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child:Text("Load more",style: TextStyle(color: Colors.white),)
              ),  onTap: () {
                setState(() {
                  if((present + perPage)> data_allcampagins.length) {
                    items.addAll(
                        data_allcampagins.getRange(present, data_allcampagins.length));
                  } else {
                    items.addAll(
                        data_allcampagins.getRange(present, present + perPage));
                  }
                  present = present + perPage;
                });
              },)
                  :InkWell(onTap:() async {
                if(loged==false){showAlertDialog(context);
               }else{
                  detail_campaign_id=data_allcampagins[index]['id_campaign'];
                  await http.post(Uri.encodeFull(detailcampaign_url), body: {
                    "id_campaign":detail_campaign_id.toString()}, headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {
                    if(response.statusCode==200){  var convertDataToJson = jsonDecode(response.body);
                    data_detail_campaign = convertDataToJson['data'];}
                    print(data_detail_campaign[0]['id_campaign'].toString());
                    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  DetailCampaign()));
                  });
                   }
              },child:buildCard(context,index));
            }),

        Align(
          alignment: Alignment.bottomCenter,
          child: GradientButton(
            text: "Filter",
            onclick: () => print("Hello Filter"),
          ),
        ),
      ],
    ):Container(
      child: Column(
        children: [
          SizedBox(height: size.height/10,),
          Image.asset("assets/laba.png"),
          Container(
            margin:EdgeInsets.only(top: size.height/50),
            child:Text("Campaign Tidak Tersedia",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/40, color: black2)),)
        ],
      ),
    );
  }
  Container buildCard(BuildContext context,int index) {
    bool fav=false;
    return Container(
      margin: EdgeInsets.only(bottom:45),
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  data_allcampagins[index]['logo_campaign'],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraint) {
                        if (data_allcampagins[index]['premium_campaign']==0) {
                          return Container();
                        } else {
                          return Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/logopremium 567@3x (1).png",
                                height: 35.0,
                                width: 70.0,
                              ),
                              Container()
                            ],
                          );
                        }
                      },
                    ),


                    Container(
                      width: 50.0,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if(data_saved_id.contains(data_allcampagins[index]['id_campaign'].toString()))
                            {http.post(Uri.encodeFull(delete_url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},body: { "id_campaign":data_allcampagins[index]['id_campaign'].toString(),}).then((response)
                            { print(response.body); if(loged==true){http.get(Uri.encodeFull(list_saved), headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {var rep = jsonDecode(response.body);data=rep['data'];for(int i=0;i<data.length;i++){data_saved_id.add(data[i]['id_campaign'].toString());}});}});}
                            else{http.post(Uri.encodeFull(save_url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},body: {"id_campaign": data_allcampagins[index]['id_campaign'].toString(), }).then((response)
                            { print(response.body); if(loged==true){http.get(Uri.encodeFull(list_saved), headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {var rep = jsonDecode(response.body);data=rep['data'];for(int i=0;i<data.length;i++){data_saved_id.add(data[i]['id_campaign'].toString());}});}});}

                          });
                        },
                        child: Image.asset(
                          "assets/fav 567@3x (2).png",
                          color:
                          (loged==true)?(data_saved_id.contains((data_allcampagins[index]['id_campaign'].toString()))? kSelectedLabelColor : kBackgoundColor):kBackgoundColor,
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        color: kCardHeaderColor,
                        height: 30.0,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          data_allcampagins[index]['countdown'].toString(),
                          style:
                          TextStyle(color: kBackgoundColor, fontSize: 10.0),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child:Text(
                                      data_allcampagins[index]['hashtag'] != null ? data_allcampagins[index]['hashtag'].toString(): "",
                                      style: TextStyle(color: kTextThemColor1, fontSize: 12.0), )),
                                    Text(
                                      data_allcampagins[index]['price'] != null ? data_allcampagins[index]['price'].toString(): "",
                                      style: TextStyle(
                                          color: kTextThemColor2, fontSize: 12.0),
                                    )
                                  ],
                                ),
                                Text(
                                  data_allcampagins[index]['campaign_name'].toString(),
                                  style: TextStyle(
                                      color: kTextThemColor3, fontSize: 18.0),
                                ),
                                Text(
                                  data_allcampagins[index]['location'].toString(),
                                  style: TextStyle(
                                      color: kTextThemColor1, fontSize: 12.0),
                                ),
                                Text(
                                  data_allcampagins[index]['niche'].toString() +" - "+data_allcampagins[index]['gender'].toString(),
                                  style: TextStyle(
                                      color: kTextThemColor1, fontSize: 12.0),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height/20,),
              Image.asset("assets/smile.png"),
              SizedBox(height: size.height/30,),
              Container(
                alignment: Alignment.center,
                child:Text("You need to register \nor\n Log In first to access this page",textAlign:TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/40, color: Colors.white),),),
              SizedBox(height: size.height/30,),

              Row( mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[

                InkWell(onTap: (){ _loginWithFB().whenComplete(() {
                  http.post(Uri.encodeFull(facebook_login_url), body: {
                    "name":name,
                    "email": email,
                    "google_id": uid,
                    "avatar":imageUrl
                  }).then((response) {
                    var convertDataToJson = jsonDecode(response.body);
                    var data=convertDataToJson['data'];
                    if(data['username']==null){Navigator.push(context, MaterialPageRoute(builder: (context) => MyDemo(),));}else{getJsonData_profile(profile_url);}
                  });
                }).catchError((onError) {
                  Navigator.pushReplacementNamed(context, "/auth");
                });  },child: Container(width:size.width/5,child:new Image.asset('assets/facebook.png',fit:BoxFit.cover,),)),
                SizedBox(width: size.width/12),
                InkWell(onTap: (){

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
                      if(data['username']==null){Navigator.push(context, MaterialPageRoute(builder: (context) => MyDemo(),));}else{
                        getJsonData_profile(profile_url);}
                    });
                  }).catchError((onError) {
                    Navigator.pushReplacementNamed(context, "/auth");
                  });
                },
                    child: Container(width:size.width/5,child:new Image.asset('assets/google.png',fit:BoxFit.cover,),))
              ]
              ),
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
