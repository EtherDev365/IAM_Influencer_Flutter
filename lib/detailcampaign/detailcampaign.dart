import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_kazee5/detailcampaign/submit_content.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;
class DetailCampaign extends StatefulWidget {
  DetailCampaign({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DetailCampaign createState() => _DetailCampaign();
}
class _DetailCampaign extends State<DetailCampaign> with SingleTickerProviderStateMixin {
   void initState() {
     open_tab_detail=0;
     status_campaign=data_detail_campaign[0]['status_campaign'].toString();
     status_apply=data_detail_campaign[0]['status_apply'];
     tabController = new TabController(length: 2, vsync: this);
     tabController.addListener(() {
       setState(() {

         open_tab_detail = tabController.index;
       }); });
    super.initState();
    if(loged==true){http.get(Uri.encodeFull(list_saved), headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {var rep = jsonDecode(response.body);data=rep['data'];for(int i=0;i<data.length;i++){data_saved_id.add(data[i]['id_campaign'].toString());}});}
   }
   File feed_submit_content;
   File story_submit_content;
   String submit_content_url="http://36.37.120.131/iam-mobile/api/influencer/report/submit-content";
   Future<String> getJsonData_submit_content(String url, File feed, File story, String caption) async {
     Map<String, String> headers = {
       "Content-Type": "multipart/form-data",
       "Authorization": "Baerer " + token,
     };
     // var formData = FormData.fromMap({
     //   'id_campaign':data_detail_campaign[0]['id_campaign'].toString() ,
     //   'caption': caption,
     //   'foto_feed': await MultipartFile.fromFile(feed.readAsStringSync(),
     //       filename: feed.readAsStringSync() .split("/") .last, ),
     //   'foto_story': await MultipartFile.fromFile(story.readAsStringSync(),
     //     filename: story.readAsStringSync() .split("/") .last, ),
     // });
     // var response = await dio.post(
     //    url, data: formData,
     //     options: Options(headers: headers));
     // final multipartRequest = new http.MultipartRequest('POST', Uri.parse(url));
     // multipartRequest.headers.addAll(headers);
     // multipartRequest.files.add(
     //     await http.MultipartFile.fromPath(
     //         'foto_feed',
     //         feed.path
     //     )
     // );
     // multipartRequest.files.add(
     //     await http.MultipartFile.fromPath(
     //         'foto_story',
     //         story.path
     //     )
     // );
     // multipartRequest.fields['id_campaign'] = data_detail_campaign[0]['id_campaign'].toString();
     // multipartRequest.fields['caption'] = caption;
     // multipartRequest.send().then((response) {
     //   print(response.statusCode);
     //   if (response.statusCode == 200) {print("Uploaded!");}
     // });
     return "Success";
   }

   List data;
   String status_campaign="";
   String status_apply="";
   String messaage="";
   String apply_url="http://36.37.120.131/iam-mobile/api/influencer/apply/campaign";
  String save_url="http://36.37.120.131/iam-mobile/api/save-campaign";
  String delete_url="http://36.37.120.131/iam-mobile/api/delete-campaign";
  String check_url="http://36.37.120.131/iam-mobile/api/check-save-campaign";
  String list_saved="http://36.37.120.131/iam-mobile/api/list-save-campaign";
  List<String> data_saved_id=new List();
  TabController tabController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(255-MediaQuery.of(context).padding.top),
          child:AppBar(

          flexibleSpace: Container(
            height: 255,
            margin: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              color: Colors.green,
                image: DecorationImage(image: NetworkImage(data_detail_campaign[0]['logo_campaign']),
                    fit: BoxFit.cover),
            ),
            child:Column(
              children: [
                Row(
                  children: [
                  SizedBox(width: size.width/1.15,),
                  Column(children: [
                    SizedBox(height: 40,),
                    InkWell(
                        onTap: () {
                          setState(() {
                            if(data_saved_id.contains(data_detail_campaign[0]['id_campaign'].toString()))
                            {http.post(Uri.encodeFull(delete_url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},body: { "id_campaign":data_detail_campaign[0]['id_campaign'].toString(),}).then((response)
                            { print(response.body); if(loged==true){http.get(Uri.encodeFull(list_saved), headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {var rep = jsonDecode(response.body);data=rep['data'];for(int i=0;i<data.length;i++){data_saved_id.add(data[i]['id_campaign'].toString());}});}});}
                            else{http.post(Uri.encodeFull(save_url), headers: {HttpHeaders.authorizationHeader:'Bearer $token'},body: {"id_campaign": data_detail_campaign[0]['id_campaign'].toString(), }).then((response)
                            { print(response.body); if(loged==true){http.get(Uri.encodeFull(list_saved), headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {var rep = jsonDecode(response.body);data=rep['data'];for(int i=0;i<data.length;i++){data_saved_id.add(data[i]['id_campaign'].toString());}});}});}

                          });
                        },
                        child: Container(height:30,child:Image.asset(
                          "assets/fav 567@3x (2).png",
                          color:
                          (loged==true)?(data_saved_id.contains((data_detail_campaign[0]['id_campaign'].toString()))? kSelectedLabelColor : kBackgoundColor):kBackgoundColor,
                          height: 25.0,
                          width:25.0,
                        ),)
                    ),
                    SizedBox(height: 150,)
                  ],)
                ],),
                Container(
                    width: size.width,
                    height: 35,
                    decoration: BoxDecoration(
                      color: pink_red,
                    ),
                    child:Row(children: [
                      SizedBox(width: 10,),
                      Column( children:[SizedBox(height: 10,),Text(data_detail_campaign[0]['countdown'].toString(),style: TextStyle(fontStyle: FontStyle.normal,fontSize: 15, color: Colors.white),)])
                    ],)

                ),
              ],
            )
          ),
          actions: [
          ],
        ),),
        body: Column(
          children: [
            Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: TabBar(
                  onTap: (index) {
                    open_tab_detail=index;
                  },
                  controller: tabController,
                  unselectedLabelColor: kUnselectedLabelColor,
                  labelColor: kSelectedLabelColor,
                  indicatorColor: kSelectedLabelColor,
                  labelStyle: TextStyle(fontSize: 12.0),
                  tabs: [
                    Tab(
                      text: "Campaign Detail",
                    ),
                    Tab(
                      text: "Report Submission",
                    ),

                  ]),
            ),
            Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [Campaign_Detail(), Report()]))
          ],
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (open_tab_detail==0 && status_campaign=="Open"&& status_apply=="Belum Apply")?InkWell(
        onTap:(){
          showAlertDialog(context);
        },
        child:  Container(
            margin:EdgeInsets.only(top: 15),
            width: 120,
            height: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),gradient: kLinearGradient),
            child:Center(child:Text("Apply",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 15)),)
        ),
      ):SizedBox.shrink()

    );
  }
  Widget Campaign_Detail(){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(gradient:LinearGradient(colors: [Colors.white,light_grey],begin: Alignment.bottomCenter,end: Alignment.topCenter,),
                color: Colors.white,),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:EdgeInsets.only(left: 25,top: 20),
                        child:  Text(data_detail_campaign[0]['hashtag']!=null?data_detail_campaign[0]['hashtag'].toString():"",style: TextStyle(color: Colors.black45),),
                      ),
                      Container(
                          margin:EdgeInsets.only(right: 25,top: 20),
                          child:   Text(data_detail_campaign[0]['price']!=null?data_detail_campaign[0]['price'].toString():"")
                      ),

                    ],
                  ),
                  Container(
                    margin:EdgeInsets.only(left: 25,top: 15,right: 25),
                    alignment: Alignment.centerLeft,
                    child:  Text(data_detail_campaign[0]['campaign_name']!=null?data_detail_campaign[0]['campaign_name'].toString():"",style: TextStyle(fontSize: 20,color: Colors.black87),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:EdgeInsets.only(left: 25,top: 20),
                    child:  Text(data_detail_campaign[0]['location']!=null?data_detail_campaign[0]['location'].toString():"",style: TextStyle(fontSize: 12,color: Colors.black45),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:EdgeInsets.only(left: 25,top: 10),
                    child:  Text(data_detail_campaign[0]['niche']!=null?data_detail_campaign[0]['niche'].toString():"",style: TextStyle(fontSize: 12,color: Colors.black45),),
                  ),
                ],
              ),
            ),
            Container(
              height:85,
              decoration: BoxDecoration(gradient:LinearGradient(colors: [Colors.white,light_grey],begin: Alignment.bottomCenter,end: Alignment.topCenter,),
                color: Colors.white,),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:EdgeInsets.only(left: 35,top: 20),
                        child:  Text("Status Campaign",style: TextStyle(color: pink_red, ),),
                      ),
                      Container(
                          margin:EdgeInsets.only(right: 35,top: 20),
                          child:   Text("Status apply",style: TextStyle(color: pink_red,),)
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:EdgeInsets.only(left:35,top: 10),
                        child:  Text(data_detail_campaign[0]['status_campaign']!=null?data_detail_campaign[0]['status_campaign'].toString():"",style: TextStyle(color: pink_red, fontWeight: FontWeight.bold,),),
                      ),
                      Container(
                          margin:EdgeInsets.only(right: 35,top: 10),
                          child:   Text(status_apply,style: TextStyle(color: status_apply=="Menunggu Persetujuan"?Colors.deepOrangeAccent:pink_red, fontWeight: FontWeight.bold,),)
                      ),

                    ],
                  ),

                ],
              ),
            ),
            Container(
              child: Column(
               children: [
                 Container(
                   margin:EdgeInsets.only(left: 25,top: 25,right: 25),
                   alignment: Alignment.centerLeft,
                   child:  Text("INFLUENCER CRITERIA",style: TextStyle(fontSize: 14,color: Colors.black45),),
                 ),
                 Container(
                   margin:EdgeInsets.only(left: 25,top: 15,right: 25),
                   alignment: Alignment.centerLeft,
                   child:  Text(data_detail_campaign[0]['influencer_criteria'],style: TextStyle(fontSize: 13,height: 1.5,color: Colors.black54),),
                 ),
                 Container(
                   margin:EdgeInsets.only(left: 25,top: 40,right: 25),
                   alignment: Alignment.centerLeft,
                   child:  Text("CAMPAIGN BRIEF",style: TextStyle(fontSize: 14,color: Colors.black45),),
                 ),
                 Container(
                   margin:EdgeInsets.only(left: 25,top: 15,right: 25, bottom: 25),
                   alignment: Alignment.centerLeft,
                   child:  Text(data_detail_campaign[0]['direction'],style: TextStyle(fontSize: 13,height: 1.5,color: Colors.black54),),
                 ),
               ],
              ),
            )
          ],
        ),
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
           height: size.height/3,
           decoration: BoxDecoration(
             shape: BoxShape.rectangle,
             borderRadius: BorderRadius.circular(30.0),),
           child:Column(
             children: [
               SizedBox(height: size.height/30,),
               Image.asset("assets/alert.png"),
               SizedBox(height: size.height/25,),
               Container(
                 alignment: Alignment.center,
                 child:Text("Apakah kamu yakin ingin mendaftar pada campaign ini?",textAlign:TextAlign.center,style: TextStyle(height:1.5,fontStyle: FontStyle.normal,fontSize: 15, color: Colors.white),),),
               SizedBox(height: size.height/20,),

               Row(
                   children:[
                     SizedBox(width: size.width/12,),
                     InkWell(
                     onTap:(){ Navigator.of(context).pop();},
                       child:Container(

                           width: size.width/5,
                           height: 30,
                           decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(30),color:knavigationSelectedLabelColor),
                           child:Center(child:Text("Cancel",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                       ),
                     ),
                     SizedBox(width: size.width/12),
                     InkWell(
                       onTap:() async {
                         await http.post(Uri.encodeFull(apply_url), body: {
                           "id_campaign":detail_campaign_id.toString()}, headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) async {
                           if(response.statusCode==200){  var convertDataToJson = jsonDecode(response.body);
                          if(convertDataToJson['status']==0){
                            messaage=convertDataToJson['message'].toString();
                            Navigator.of(context).pop();
                            showAlertDialog_next(context);
                          }else{
                            await http.post(Uri.encodeFull(detailcampaign_url), body: {
                              "id_campaign":detail_campaign_id.toString()}, headers: {HttpHeaders.authorizationHeader:'Bearer $token'}).then((response) {
                              if(response.statusCode==200){  var convertDataToJson = jsonDecode(response.body);
                              data_detail_campaign = convertDataToJson['data'];}
                            });
                            setState(()  {
                              status_apply=data_detail_campaign[0]['status_apply'].toString();
                            });
                            Navigator.of(context).pop();
                          }}

                         });
                       },
                       child:Container(
                           width: size.width/5,
                           height: 30,
                           decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(30),color:knavigationSelectedLabelColor),
                           child:Center(child:Text("Ok",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                       ),
                     ),

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
   showAlertDialog_next(BuildContext context) {
     // set up the AlertDialog
     const Color red = Color(0xFFee7f9f);
     var size = MediaQuery.of(context).size;
     AlertDialog alert = AlertDialog(
       shape: RoundedRectangleBorder(borderRadius:
       BorderRadius.all(Radius.circular(30))),
       backgroundColor: red.withOpacity(0.6),

       content:  Container(
           height: size.height/3,
           decoration: BoxDecoration(
             shape: BoxShape.rectangle,
             borderRadius: BorderRadius.circular(30.0),),
           child:Column(
             children: [
               SizedBox(height: size.height/30,),
               Image.asset("assets/alert.png"),
               SizedBox(height: size.height/25,),
               Container(
                 alignment: Alignment.center,
                 child:Text(messaage,textAlign:TextAlign.center,style: TextStyle(height:1.5,fontStyle: FontStyle.normal,fontSize: 15, color: Colors.white),),),
               SizedBox(height: size.height/20,),

               InkWell( onTap:(){ Navigator.of(context).pop();   },
                 child:Container(
                     width: size.width/5,
                     height: 30,
                     decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(30),color:knavigationSelectedLabelColor),
                     child:Center(child:Text("Ok",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                 ),
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
   Widget Report(){
     int _index=0;
     var size = MediaQuery.of(context).size;
    return status_apply=="Diterima"?
       SingleChildScrollView(child:  Container(
         child: Column(
           children: [
             SizedBox(height: size.height/20),
             Container(width:size.width/3,child:new Image.asset(status_apply=="Ditolak"?'assets/ditolak.png':'assets/waiting.png',fit:BoxFit.cover,),),
             Text(status_apply=="Ditolak"?"Anda tidak lulus pada\n campaign ini":status_apply=="Menunggu Persetujuan"?"Campaign ini sedang\n menunggu persetujuan brand":"Anda tidak mendaftar pada\n campaign ini",textAlign:TextAlign.center,style:TextStyle(height:1.5,fontSize: 15))
           ],
         ),
       ),):SingleChildScrollView(child: Column(
        children: [
          Container(margin:EdgeInsets.all(20),child:  Text("Let's complete the report's steps to\n finish your campaign",textAlign:TextAlign.center,style:TextStyle(fontSize: 15,height: 2,color: Colors.black45) ),),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
             child: Stepper(
                 steps: [
                   Step( isActive:true,
                    title: Text("Step 1",style: TextStyle(color: Colors.pink),),
                    content: Container(
                      height: 90,
                      width: size.width/1.4,
                      decoration: BoxDecoration( color: light_grey,borderRadius:BorderRadius.all(Radius.circular(12))),
                     child: Column(
                       crossAxisAlignment:CrossAxisAlignment.start,
                       children: [
                         Container(margin:EdgeInsets.only(top:15,left:20),child: Text("Submit Content",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),),
                         SizedBox(height: 15),
                         Row(
                             children:[
                               SizedBox(width: size.width/5),
                               InkWell(
                                 onTap:()async{
                                   final List<File> pageResult = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => submit_content()));
                                   feed_submit_content=pageResult[0];
                                   story_submit_content=pageResult[1];
                                 },
                                 child:Container(

                                     width: size.width/5,
                                     height: 30,
                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.pink),
                                     child:Center(child:Text("Open",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                                 ),
                               ),
                               SizedBox(width: size.width/20),
                               InkWell(
                                 onTap:()  {
                                   // getJsonData_submit_content(submit_content_url, feed_submit_content, story_submit_content, caption);
                                 },
                                 child:Container(
                                     width: size.width/5,
                                     height: 30,
                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.deepOrangeAccent),
                                     child:Center(child:Text("Submit",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                                 ),
                               ),

                             ]
                         )
                       ],
                     ), ) ),
                   Step(
                       isActive:true,
                    title:Text("Step 2",style: TextStyle(color: Colors.pink),),
                    content:Container(
                            height: 90,
                             width: size.width/1.4,
                             decoration: BoxDecoration( color: light_grey,borderRadius:BorderRadius.all(Radius.circular(12))),
                            child: Column(
                             crossAxisAlignment:CrossAxisAlignment.start,
                             children: [
                             Container(margin:EdgeInsets.only(top:15,left:20),child: Text("Link Post",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),),
                            SizedBox(height: 15),
                            Row(
               children:[
                 SizedBox(width: size.width/5),
                 InkWell(
                   onTap:(){ },
                   child:Container(

                       width: size.width/5,
                       height: 30,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.pink),
                       child:Center(child:Text("Open",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                   ),
                 ),
                 SizedBox(width: size.width/20),
                 InkWell(
                   onTap:()  {   },
                   child:Container(
                       width: size.width/5,
                       height: 30,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.deepOrangeAccent),
                       child:Center(child:Text("Submit",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                   ),
                 ),

               ]
           )
                                   ],
                                     ), )
                                          ),
                   Step(
                       isActive:true,
                      title:Text("Step 3",style: TextStyle(color: Colors.pink),),
                       content: Container(
                         height: 90,
                         width: size.width/1.4,
                         decoration: BoxDecoration( color: light_grey,borderRadius:BorderRadius.all(Radius.circular(12))),
                         child: Column(
                           crossAxisAlignment:CrossAxisAlignment.start,
                           children: [
                             Container(margin:EdgeInsets.only(top:15,left:20),child: Text("Insight Upload",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),),
                             SizedBox(height: 15),
                             Row(
                                 children:[
                                   SizedBox(width: size.width/5),
                                   InkWell(
                                     onTap:(){ },
                                     child:Container(

                                         width: size.width/5,
                                         height: 30,
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.pink),
                                         child:Center(child:Text("Open",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                                     ),
                                   ),
                                   SizedBox(width: size.width/20),
                                   InkWell(
                                     onTap:()  {   },
                                     child:Container(
                                         width: size.width/5,
                                         height: 30,
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.deepOrangeAccent),
                                         child:Center(child:Text("Submit",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                                     ),
                                   ),

                                 ]
                             )
                           ],
                         ), )
                      ),
                   Step(
                       isActive:true,
                       title:Text("Step 4",style: TextStyle(color: Colors.pink),),
                       content: Container(
                         height: 90,
                         width: size.width/1.4,
                         decoration: BoxDecoration( color: light_grey,borderRadius:BorderRadius.all(Radius.circular(12))),
                         child: Column(
                           crossAxisAlignment:CrossAxisAlignment.start,
                           children: [
                             Container(margin:EdgeInsets.only(top:15,left:20),child: Text("Your Result",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),),
                             SizedBox(height: 15),
                             Row(
                                 children:[
                                   SizedBox(width: size.width/5),
                                   InkWell(
                                     onTap:(){ },
                                     child:Container(

                                         width: size.width/5,
                                         height: 30,
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.pink),
                                         child:Center(child:Text("Open",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                                     ),
                                   ),
                                   SizedBox(width: size.width/20),
                                   InkWell(
                                     onTap:()  {   },
                                     child:Container(
                                         width: size.width/5,
                                         height: 30,
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.deepOrangeAccent),
                                         child:Center(child:Text("Submit",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                                     ),
                                   ),

                                 ]
                             )
                           ],
                         ), )
                   ),
                ],
                currentStep: _index,
                onStepTapped: (index) {
                  setState(() {
                  _index = index;   });
                     },
              controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) => Container(  ),
            ),
           )
        ]),);
   }
}
