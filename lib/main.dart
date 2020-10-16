import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/home/home_page.dart';
// import 'package:flutter_app_kazee5/login.dart';
// import 'package:flutter_app_kazee5/login_page.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IAM Influencer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String allcampagins_url =
      "http://36.37.120.131/iam-mobile/api/influencer/all-campaign";
  final String upcoming_url =
      "http://36.37.120.131/iam-mobile/api/influencer/upcoming-campaign";

  Future<String> getJsonData_allcampagins(String url) async {
    var response = await http.get(
        //Encode the url
        Uri.encodeFull(url));
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_allcampagins = convertDataToJson['data'];
    });
    Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage())));
    return "Success";
  }

  Future<String> getJsonData_upcoming(String url) async {
    var response = await http.get(
        //Encode the url
        Uri.encodeFull(url));
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      release_date = convertDataToJson['release_date'];
      data_upcoming = convertDataToJson['data'];
    });
    return "Success";
  }

  String provinsi_url =
      "http://36.37.120.131/iam-mobile/api/influencer/get-provinsi";
  Future<String> getJsonData_provinsi(String url) async {
    var response = await http.get(
        //Encode the url
        Uri.encodeFull(url));
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_provinsi = convertDataToJson['data'];
      for (int i = 0; i < data_provinsi.length; i++) {
        provinsi.add(data_provinsi[i]['name']);
      }
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    // this.getJsonData_invitation(invitation_url);
    this.getJsonData_provinsi(provinsi_url);
    this.getJsonData_upcoming(upcoming_url);
    this.getJsonData_allcampagins(allcampagins_url);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        child: Image.asset("assets/splash.png", fit: BoxFit.cover));
  }
}
