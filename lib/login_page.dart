import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/login_splash.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'CustomDialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'home/home_page.dart';

class MyDemo extends StatefulWidget {
  @override
  login_page createState() => login_page();
}

class login_page extends State<MyDemo> {
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
    return "Success";
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

  String formstep_url =
      "https://web.iam.id/iam-mobile/api/influencer/form-step";
  String kota_url = "https://web.iam.id/iam-mobile/api/influencer/get-kota";
  var currentSelectedcity;
  String currentSelectedcity_id;
  var currentSelectedprovinsi;
  int currentSelectedprovinsi_id;

  final TextEditingController full_nameFilter = new TextEditingController();
  String full_name = "";
  login_page() {
    full_nameFilter.addListener(full_nameListen);
    usernameFilter.addListener(usernameListen);
    no_handphoneFilter.addListener(no_handphoneListen);
    id_provinsiFilter.addListener(id_provinsiListen);
    id_kotaFilter.addListener(id_kotaListen);
  }
  void full_nameListen() {
    if (full_nameFilter.text.isEmpty) {
      full_name = "";
    } else {
      full_name = full_nameFilter.text;
    }
  }

  final TextEditingController usernameFilter = new TextEditingController();
  String username = "";
  void usernameListen() {
    if (usernameFilter.text.isEmpty) {
      username = "";
    } else {
      username = usernameFilter.text;
    }
  }

  final TextEditingController no_handphoneFilter = new TextEditingController();
  String no_handphone = "";
  void no_handphoneListen() {
    if (no_handphoneFilter.text.isEmpty) {
      no_handphone = "";
    } else {
      no_handphone = no_handphoneFilter.text;
    }
  }

  final TextEditingController id_provinsiFilter = new TextEditingController();
  String id_provinsi = "";
  void id_provinsiListen() {
    if (id_provinsiFilter.text.isEmpty) {
      id_provinsi = "";
    } else {
      id_provinsi = id_provinsiFilter.text;
    }
  }

  final TextEditingController id_kotaFilter = new TextEditingController();
  String id_kota = "";
  void id_kotaListen() {
    if (id_kotaFilter.text.isEmpty) {
      id_kota = "";
    } else {
      id_kota = id_kotaFilter.text;
    }
  }

  void initState() {
    super.initState();
  }

  Future<String> getJsonData_kota(String url, int id_provinsi) async {
    List<String> kkootta;
    http.post(Uri.encodeFull(url), body: {
      "id_provinsi": id_provinsi.toString(),
    }).then((response) {
      if (response.statusCode == 200) {
        var convertDataToJson = jsonDecode(response.body);
        data_kota = convertDataToJson['data'];
      }
      kkootta = List<String>();
      for (int i = 0; i < data_kota.length; i++) {
        kkootta.add(data_kota[i]['name']);
      }
      setState(() {
        kota = kkootta;
      });
    });
    return "Success";
  }

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  String validateFullname(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "* Full name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "* Full name must be a-z and A-Z";
    }
    return null;
  }

  String validateusername(String value) {
    if (value.length == 0) {
      return "* Username is Required";
    }
    return null;
  }

  String validateHandphone_number(String value) {
    if (value.length == 0) {
      return "* Handphone number is Required";
    }
    return null;
  }

  String validateProvinsi_city(String value) {
    if ((currentSelectedprovinsi == null) | (currentSelectedcity == null)) {
      return "       * Province and City are Required";
    }
    return null;
  }

  String validatecheckbox(String value) {
    if (checked == false) {
      return "        * You need to check this agreement";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color red = Color(0xFFef5642);
    const Color light_red = Color(0xFFf23367);
    const Color light_white = Color(0xFFf7c8b6);
    const Color light_grey = Color(0xFFf0afb0);
    const Color text_color = Color(0xFFfbd5d6);
    const Color blue = Color(0xFF0035b3);
    const Color next = Color(0xFF674575);
    const Color checkbox_white = Color(0xFFffffff);
    return Scaffold(
        body: Form(
      key: _formKey,
      autovalidate: _validate,
      child: Center(
          child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [light_red, red],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          color: red,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: size.height / 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Complete Registration",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: size.height / 40,
                    color: light_white),
              ),
            ),
            SizedBox(height: size.height / 30),
            Row(children: [
              SizedBox(width: size.width / 10),
              Text(
                "Nama Lengkap",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: size.height / 50,
                    color: light_grey),
              ),
            ]),
            Container(
              height: 50,
              margin: EdgeInsets.only(
                top: size.height / 60,
                left: size.width / 10,
                right: size.width / 10,
              ),
              child: TextFormField(
                validator: validateFullname,
                autovalidate: _validate,
                controller: full_nameFilter,
                style: TextStyle(
                    fontSize: size.height / 45, color: Colors.black54),
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: light_grey,
                    contentPadding:
                        const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(height: size.height / 70),
            Row(children: [
              SizedBox(width: size.width / 10),
              Text(
                "Akun Instagram",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: size.height / 50,
                    color: light_grey),
              ),
            ]),
            Container(
              height: size.height / 15,
              margin: EdgeInsets.only(
                top: size.height / 60,
                left: size.width / 10,
                right: size.width / 10,
              ),
              child: TextFormField(
                validator: validateusername,
                autovalidate: _validate,
                controller: usernameFilter,
                autofocus: false,
                style: TextStyle(
                    fontSize: size.height / 45, color: Colors.black54),
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: light_grey,
                    contentPadding:
                        const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(height: size.height / 70),
            Row(children: [
              SizedBox(width: size.width / 10),
              Text(
                "No Handphone",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: size.height / 50,
                    color: light_grey),
              ),
            ]),
            Container(
              height: size.height / 15,
              margin: EdgeInsets.only(
                top: size.height / 60,
                left: size.width / 10,
                right: size.width / 10,
              ),
              child: TextFormField(
                validator: validateHandphone_number,
                autovalidate: _validate,
                controller: no_handphoneFilter,
                autofocus: false,
                style: TextStyle(
                    fontSize: size.height / 45, color: Colors.black54),
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: light_grey,
                    contentPadding:
                        const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: size.height / 70),
            Row(children: [
              SizedBox(width: size.width / 10),
              Text(
                "Lokasi Domisili",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: size.height / 50,
                    color: light_grey),
              ),
            ]),
            SizedBox(height: size.height / 60),
            Container(
              margin: EdgeInsets.only(
                  left: size.width / 10, right: size.width / 10),
              decoration: BoxDecoration(
                color: light_grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 14.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Pilih Provinsi",
                            style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                        value: currentSelectedprovinsi,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedprovinsi = newValue;
                            currentSelectedprovinsi_id = int.parse(
                                data_provinsi[provinsi.indexOf(
                                    currentSelectedprovinsi)]['id_provinsi']);
                            currentSelectedcity = null;
                            getJsonData_kota(
                                kota_url, currentSelectedprovinsi_id);
                          });
                        },
                        items: provinsi.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11,
                                    color: Colors.black54)),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height / 50),
            Container(
              margin: EdgeInsets.only(
                  left: size.width / 10, right: size.width / 10),
              decoration: BoxDecoration(
                color: light_grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 14.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Pilih Kota",
                            style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                        value: currentSelectedcity,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedcity = newValue;
                            currentSelectedcity_id =
                                data_kota[kota.indexOf(newValue)]['id_kota'];
                          });
                        },
                        items: kota.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11,
                                    color: Colors.black54)),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: size.height / 40,
              margin: EdgeInsets.only(
                top: size.height / 60,
                left: size.width / 10,
                right: size.width / 10,
              ),
              child: TextFormField(
                validator: validateProvinsi_city,
                autovalidate: _validate,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ),
            Row(
              children: [
                SizedBox(width: size.width / 10),
                GestureDetector(
                  onTap: () {
                    checked = !(checked);
                  },
                  child: new Transform.scale(
                      scale: 1,
                      child: new Checkbox(
                          checkColor: Colors.black,
                          activeColor: checkbox_white,
                          value: checked,
                          onChanged: (val) {
                            setState(() {
                              checked = val;
                            });
                          })),
                ),
                Text(
                  "I accept the terms in the  ",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: size.height / 60,
                      color: light_white),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(),
                    );
                  },
                  child: Text(
                    "T&C agreement",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: size.height / 60,
                        color: blue),
                  ),
                ),
              ],
            ),
            Container(
              height: size.height / 40,
              margin: EdgeInsets.only(
                left: size.width / 10,
                right: size.width / 10,
              ),
              child: TextFormField(
                validator: validatecheckbox,
                autovalidate: _validate,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ),
            SizedBox(height: size.height / 30),
            Row(
              children: [
                SizedBox(width: size.width / 1.5),
                ButtonTheme(
                  minWidth: size.width / 4,
                  height: size.height / 18,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(currentSelectedprovinsi_id);
                        print(currentSelectedcity_id);
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        http.post(Uri.encodeFull(formstep_url), headers: {
                          HttpHeaders.authorizationHeader: 'Bearer $token'
                        }, body: {
                          "full_name": full_name,
                          "username": username,
                          "no_handphone": no_handphone,
                          "id_provinsi": currentSelectedprovinsi_id.toString(),
                          "id_kota": currentSelectedcity_id.toString(),
                        }).then((response) {
                          if (response.statusCode == 200) {
                            var json = jsonDecode(response.body);
                            if (json['status'] == 1) {
                              getJsonData_profile(profile_url);
                            }
                          }
                        });
                      }
                    },
                    color: next,
                    textColor: light_white,
                    child: Text("Next",
                        style: TextStyle(fontSize: size.width / 30)),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    ));
  }
}
