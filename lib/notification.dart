import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

import 'LoginDialog.dart';
import 'login.dart';

class notification extends StatefulWidget {
  notification({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Notification createState() => _Notification();
}

class _Notification extends State<notification>
    with AutomaticKeepAliveClientMixin<notification> {
  @override
  bool get wantKeepAlive => true;
  String url_notifikasi =
      "https://web.iam.id/iam-mobile/api/influencer/notifikasi";
  String read_notifikasi =
      "https://web.iam.id/iam-mobile/api/influencer/notifikasi/read";
  int perPage_notifi = 5;
  int present_notifi = 0;
  void initState() {
    super.initState();
    items_notifi.clear();
    setState(() {
      if (data_notifikasi != null) {
        if ((5 >= data_notifikasi.length)) {
          items_notifi.addAll(data_notifikasi);
          present_notifi = data_notifikasi.length;
        } else {
          items_notifi.addAll(data_notifikasi.getRange(0, 5));
          present_notifi = 5;
        }
      }
    });
  }

  Future<String> getJsonData_notifikasi(String url) async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_notifikasi = convertDataToJson['data'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);
    const Color notifi_unread_background = Color(0xFFf1dfe1);
    const Color notifi_read_background = Color(0xFFf0f0f0);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Notifikasi",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.width / 22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [],
        ),
        body: (data_notifikasi == null)
            ? Container()
            : new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: (present_notifi < data_notifikasi.length)
                    ? items_notifi.length + 1
                    : items_notifi.length,
                itemBuilder: (BuildContext context, int index) {
                  return ((index == items_notifi.length) &&
                          (index != data_notifikasi.length))
                      ? InkWell(
                          child: Container(
                              margin: EdgeInsets.only(top: 30, bottom: 30),
                              height: 35.0,
                              width: size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: kLinearGradient,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0))),
                              child: Text(
                                "Load more",
                                style: TextStyle(color: Colors.white),
                              )),
                          onTap: () {
                            setState(() {
                              if ((present_notifi + perPage_notifi) >
                                  data_notifikasi.length) {
                                items_notifi.addAll(data_notifikasi.getRange(
                                    present_notifi, data_notifikasi.length));
                              } else {
                                items_notifi.addAll(data_notifikasi.getRange(
                                    present_notifi,
                                    present_notifi + perPage_notifi));
                              }
                              present_notifi = present_notifi + perPage_notifi;
                            });
                          },
                        )
                      : InkWell(
                          child: buildCard(context, index),
                          onTap: () {
                            setState(() {
                              http.post(Uri.encodeFull(read_notifikasi),
                                  headers: {
                                    HttpHeaders.authorizationHeader:
                                        'Bearer $token'
                                  },
                                  body: {
                                    "id_notifikasi": items_notifi[index]
                                            ['id_notifkasi']
                                        .toString()
                                  }).then((response) {
                                getJsonData_notifikasi(url_notifikasi);
                              });
                            });
                          },
                        );
                }));
  }

  Container buildCard(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);
    const Color notifi_unread_background = Color(0xFFf1dfe1);
    const Color notifi_read_background = Color(0xFFf0f0f0);
    return Container(
        color: (data_notifikasi[index]['status_notifikasi'] == "Unread")
            ? notifi_unread_background
            : Colors.black12,
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
                height: 250,
                padding: EdgeInsets.only(top: 5),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: (data_notifikasi[index]['status_notifikasi'] ==
                            "Unread")
                        ? Image.asset(
                            "assets/unread_label.png",
                            height: 70.0,
                            width: 70.0,
                          )
                        : Image.asset(
                            "assets/notifi_label.png",
                            height: 70.0,
                            width: 70.0,
                          ))),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data_notifikasi[index]['iam_name'].toString(),
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  data_notifikasi[index]['notification_title'].toString(),
                  style: TextStyle(
                      color: Colors.black38, fontSize: 15, height: 1.2),
                ),
                SizedBox(height: 5),
                Text(
                  data_notifikasi[index]['notification_text'].toString(),
                  style: TextStyle(
                      color: Colors.black38, fontSize: 15, height: 1.2),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Image.asset("assets/time.png"),
                    SizedBox(width: 5),
                    Text(
                      data_notifikasi[index]['created_at'].toString(),
                      style: TextStyle(
                          color: Colors.black38, fontSize: 15, height: 1.2),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            )),
            SizedBox(width: 10),
          ],
        ));
  }
}
