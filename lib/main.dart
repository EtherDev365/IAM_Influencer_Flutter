import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/login.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;
void main() {
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
   final String allcampagins_url = "http://36.37.120.131/iam-mobile/api/influencer/all-campaign";
   final String invitation_url = "http://36.37.120.131/iam-mobile/api/influencer/my-campaign/invitation";
   final String upcoming_url = "http://36.37.120.131/iam-mobile/api/influencer/upcoming-campaign";
  Future<String> getJsonData_allcampagins(String url) async {
    var response = await http.get(
      //Encode the url
        Uri.encodeFull(url));
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data_allcampagins = convertDataToJson['data'];
    });
    return "Success";
  }
   Future<String> getJsonData_invitation(String url) async {
     var response = await http.get(
       //Encode the url
         Uri.encodeFull(url));
     print(response.body);
     setState(() {
       var convertDataToJson = jsonDecode(response.body);
       data_allcampagins = convertDataToJson['data'];
     });
     return "Success";
   }

   Future<String> getJsonData_upcoming(String url) async {
     var response = await http.get(
       //Encode the url
         Uri.encodeFull(url));
     print(response.body);
     setState(() {
       var convertDataToJson = jsonDecode(response.body);
       release_date=convertDataToJson['release_date'];
       data_upcoming = convertDataToJson['data'];
     });
     return "Success";
   }
  @override
  void initState() {
    super.initState();
    // this.getJsonData_invitation(invitation_url);
    this.getJsonData_allcampagins(allcampagins_url);

    this.getJsonData_upcoming(upcoming_url);

    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                SecondScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height:size.height , width: size.width,
        child:Image.asset("assets/splash.png",fit:BoxFit.cover)
    );
  }
}
