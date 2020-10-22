import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/component/gradient_button.dart';
import 'package:flutter_app_kazee5/detailcampaign/detailcampaign.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';
import '../LoginDialog.dart';
import '../login.dart';
import 'package:http/http.dart' as http;

class Invitation extends StatefulWidget {
  @override
  _Invitation createState() => _Invitation();
}

class _Invitation extends State<Invitation>
    with AutomaticKeepAliveClientMixin<Invitation> {
  @override
  bool get wantKeepAlive => true;
  List items = List();
  String list_saved = "https://web.iam.id/iam-mobile/api/list-save-campaign";
  String save_url = "https://web.iam.id/iam-mobile/api/save-campaign";
  String delete_url = "https://web.iam.id/iam-mobile/api/delete-campaign";
  List data;
  List<String> data_saved_id = new List();
  void initState() {
    super.initState();
    setState(() {
      if (loged == false) {
        Timer(
            Duration(seconds: 1),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SecondScreen())));
      } else {
        if (data_invitations != null) {
          if (loged == true) {
            http.get(Uri.encodeFull(list_saved), headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token'
            }).then((response) {
              var rep = jsonDecode(response.body);
              data = rep['data'];
              for (int i = 0; i < data.length; i++) {
                data_saved_id.add(data[i]['id_campaign'].toString());
              }
            });
          }
          if (data_invitations != null) {
            if ((5 >= data_invitations.length)) {
              items_invitations.clear();
              items_invitations.addAll(data_invitations);
              invitation_present = data_invitations.length;
            } else {
              items_invitations.clear();
              items_invitations.addAll(data_invitations.getRange(0, 5));
              invitation_present = 5;
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color black2 = Color(0xFFbcbcbc);
    var size = MediaQuery.of(context).size;
    return (loged == false)
        ? Container(child: LoginDialog())
        : (data_invitations != null
            ? Stack(
                children: [
                  new ListView.builder(
                      itemCount: (invitation_present < data_invitations.length)
                          ? items_invitations.length + 1
                          : items_invitations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ((index == items_invitations.length) &&
                                (index != data_invitations.length))
                            ? InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 80),
                                    height: 35.0,
                                    width: size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: kLinearGradient,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0))),
                                    child: Text(
                                      "Load more",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                onTap: () {
                                  setState(() {
                                    if ((invitation_present +
                                            invitation_perPage) >
                                        data_invitations.length) {
                                      items.addAll(data_invitations.getRange(
                                          invitation_present,
                                          data_invitations.length));
                                    } else {
                                      items.addAll(data_invitations.getRange(
                                          invitation_present,
                                          invitation_present +
                                              invitation_perPage));
                                    }
                                    invitation_present =
                                        invitation_present + invitation_perPage;
                                  });
                                },
                              )
                            : InkWell(
                                onTap: () async {
                                  if (loged == false) {
                                    showAlertDialog(context);
                                    Timer(
                                        Duration(seconds: 2),
                                        () => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SecondScreen())));
                                  } else {
                                    detail_campaign_id =
                                        data_allcampagins[index]['id_campaign'];
                                    await http.post(
                                        Uri.encodeFull(detailcampaign_url),
                                        body: {
                                          "id_campaign":
                                              detail_campaign_id.toString()
                                        },
                                        headers: {
                                          HttpHeaders.authorizationHeader:
                                              'Bearer $token'
                                        }).then((response) {
                                      if (response.statusCode == 200) {
                                        var convertDataToJson =
                                            jsonDecode(response.body);
                                        data_detail_campaign =
                                            convertDataToJson['data'];
                                      }
                                      print(data_detail_campaign[0]
                                              ['id_campaign']
                                          .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailCampaign()));
                                    });
                                  }
                                },
                                child: buildCard(context, index));
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GradientButton(
                      text: "Filter",
                      onclick: () => print("Hello Filter"),
                    ),
                  ),
                ],
              )
            : Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Image.asset("assets/laba.png"),
                    Container(
                      margin: EdgeInsets.only(top: size.height / 50),
                      child: Text("Campaign Invitation Tidak Tersedia",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: size.height / 40,
                              color: black2)),
                    )
                  ],
                ),
              ));
  }

  Container buildCard(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 45),
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
                  data_invitations[index]['logo_campaign'],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logopremium 567@3x (1).png",
                      height: 35.0,
                      width: 70.0,
                    ),
                    Container(
                      width: 50.0,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (data_saved_id.contains(data_invitations[index]
                                    ['id_campaign']
                                .toString())) {
                              http.post(Uri.encodeFull(delete_url), headers: {
                                HttpHeaders.authorizationHeader: 'Bearer $token'
                              }, body: {
                                "id_campaign": data_invitations[index]
                                        ['id_campaign']
                                    .toString(),
                              }).then((response) {
                                print(response.body);
                                if (loged == true) {
                                  http.get(Uri.encodeFull(list_saved),
                                      headers: {
                                        HttpHeaders.authorizationHeader:
                                            'Bearer $token'
                                      }).then((response) {
                                    var rep = jsonDecode(response.body);
                                    data = rep['data'];
                                    for (int i = 0; i < data.length; i++) {
                                      data_saved_id.add(
                                          data[i]['id_campaign'].toString());
                                    }
                                  });
                                }
                              });
                            } else {
                              http.post(Uri.encodeFull(save_url), headers: {
                                HttpHeaders.authorizationHeader: 'Bearer $token'
                              }, body: {
                                "id_campaign": data_invitations[index]
                                        ['id_campaign']
                                    .toString(),
                              }).then((response) {
                                print(response.body);
                                if (loged == true) {
                                  http.get(Uri.encodeFull(list_saved),
                                      headers: {
                                        HttpHeaders.authorizationHeader:
                                            'Bearer $token'
                                      }).then((response) {
                                    var rep = jsonDecode(response.body);
                                    data = rep['data'];
                                    for (int i = 0; i < data.length; i++) {
                                      data_saved_id.add(
                                          data[i]['id_campaign'].toString());
                                    }
                                  });
                                }
                              });
                            }
                          });
                        },
                        child: Image.asset(
                          "assets/fav 567@3x (2).png",
                          color: (loged == true)
                              ? (data_saved_id.contains((data_invitations[index]
                                          ['id_campaign']
                                      .toString()))
                                  ? kSelectedLabelColor
                                  : kBackgoundColor)
                              : kBackgoundColor,
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
                          data_invitations[index]['countdown'].toString(),
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
                                Flexible(
                                    child: Text(
                                  data_invitations[index]['hashtag'] != null
                                      ? data_invitations[index]['hashtag']
                                          .toString()
                                      : "",
                                  style: TextStyle(
                                      color: kTextThemColor1, fontSize: 12.0),
                                )),
                                Text(
                                  data_invitations[index]['price'] != null
                                      ? data_invitations[index]['price']
                                      : "",
                                  style: TextStyle(
                                      color: kTextThemColor2, fontSize: 12.0),
                                )
                              ],
                            ),
                            Text(
                              data_invitations[index]['campaign_name']
                                  .toString(),
                              style: TextStyle(
                                  color: kTextThemColor3, fontSize: 18.0),
                            ),
                            Text(
                              data_invitations[index]['location'].toString(),
                              style: TextStyle(
                                  color: kTextThemColor1, fontSize: 12.0),
                            ),
                            Text(
                              data_invitations[index]['niche'].toString() +
                                  " - " +
                                  data_invitations[index]['gender'].toString(),
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
              Row(children: [
                SizedBox(
                  width: size.width / 12,
                ),
                new Image.asset(
                  'assets/facebook.png',
                  fit: BoxFit.fill,
                ),
                SizedBox(width: size.width / 12),
                new Image.asset(
                  'assets/google.png',
                  fit: BoxFit.fill,
                ),
              ])
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
