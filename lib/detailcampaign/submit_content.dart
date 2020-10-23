import 'dart:async';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
class submit_content extends StatefulWidget {
  submit_content({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _submit_content createState() => _submit_content();
}
class _submit_content extends State<submit_content>with AutomaticKeepAliveClientMixin<submit_content> {
  @override
  bool get wantKeepAlive => true;





  final TextEditingController captionFilter = new TextEditingController();
  String caption = "";
  void captionListen() {
    if (captionFilter.text.isEmpty) {
      caption = "";
    } else {
      caption = captionFilter.text;
    }
  }

  bool isplaying_feed;

  VideoPlayerController _videoPlayerController;
  File _video_feed;
  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    _video_feed = video;

    _videoPlayerController = VideoPlayerController.file(_video_feed)..initialize().then((_) {
      setState(() {  if(video!=null){select_foto_feed=false;} });

      isplaying_feed=false;
      _videoPlayerController.pause();
    });
  }

// This funcion will helps you to pick and Image from Gallery
  File  _image_feed;
  _pickImageFromGallery() async {
    File image = await  ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if(image!=null){select_foto_feed=true;}
      _image_feed = image;
    });
  }




  bool isplaying_story;

  VideoPlayerController _videoPlayerController_story;
  File _video_story;
  _pickVideo_story() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    _video_story = video;
    _videoPlayerController_story = VideoPlayerController.file(_video_story)..initialize().then((_) {
      setState(() {
        if(video!=null){select_foto_story=false;}
      });
      isplaying_story=false;
      _videoPlayerController_story.pause();
    });
  }

// This funcion will helps you to pick and Image from Gallery
  File  _image_story;
  _pickImageFromGallery_story() async {
    File image = await  ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if(image!=null){select_foto_story=true;}
      _image_story= image;
    });
  }

  void initState() {

  captionFilter.addListener(captionListen);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color grey = Color(0xFFefefef);
    const Color grey1 = Color(0xFFbdbdbd);
    const Color grey2 = Color(0xFFeaeaea);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text("Submit Content",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
          ],
        ),
        body:SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top:40,left: 20,right: 20,bottom: 20),
            child:
              Column(
                children: [
                  InkWell(
                      onTap:(){
                        showAlertDialog(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(color:grey2,borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                        child: Text("Foto/Video for Feed*",style: TextStyle(fontSize: 15),),
                      )
                  ),
                  SizedBox(height: 20),
                  select_foto_feed==null?Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Container(
                          height: 50,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Image.asset('assets/upload.png'),
                        ),
                          Text("Upload file here",style: TextStyle(color: grey1,fontSize: 18,),),]
                    ),
                  ):( select_foto_feed? Container(
                    width: size.width,
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                    child: Image.file(_image_feed)
                    ,):Stack(
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children:[

                            (_video_feed != null)?
                            (_videoPlayerController.value.initialized
                                ? AspectRatio(
                                aspectRatio: _videoPlayerController.value.aspectRatio,
                                child:  VideoPlayer(_videoPlayerController)
                            )
                                :Container())
                                :Container(
                              height: 200,
                              width: size.width,
                              decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Container(
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Image.asset('assets/upload.png'),
                                  ),
                                    Text("Upload file here",style: TextStyle(color: grey1,fontSize: 18,),),]
                              ),
                            ),

                          ],
                        ),
                      ),
                      (_video_feed!=null)?FloatingActionButton(
                        onPressed: () {
                          setState(() {

                            if(_videoPlayerController.value.isPlaying==true || (isplaying_feed==true && _videoPlayerController.value.position <  _videoPlayerController.value.duration)){setState(() {
                              _videoPlayerController.pause();isplaying_feed=false;
                            });}
                            else if(_videoPlayerController.value.position >= _videoPlayerController.value.duration){setState(() {_videoPlayerController.play();isplaying_feed=true;  Timer(Duration(seconds:1),
                                    ()=>_videoPlayerController.initialize()
                            );

                            });}
                            else{setState(() {
                              _videoPlayerController.play();isplaying_feed=true;
                            });}
                          });
                        },
                        // Display the correct icon depending on the state of the player.
                        child: Icon(
                          isplaying_feed? Icons.pause : Icons.play_arrow,
                        ),
                      ):Container()
                    ],
                  )),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap:(){
                      showAlertDialog_story(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(color:grey2,borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                      child: Text("Foto/Video for Stories*",style: TextStyle(fontSize: 15),),
                    )
                  ),
                 SizedBox(height: 20),
                 select_foto_story==null?Container(
                   height: 200,
                   width: size.width,
                   decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                   child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [Container(
                         height: 50,
                         margin: EdgeInsets.only(bottom: 10),
                         child: Image.asset('assets/upload.png'),
                       ),
                         Text("Upload file here",style: TextStyle(color: grey1,fontSize: 18,),),]
                   ),
                 ):( select_foto_story? Container(
                   width: size.width,
                   decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                   child: Image.file(_image_story)
                   ,):Stack(
                   children: [
                     Container(
                       width: size.width,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                       margin: EdgeInsets.all(20),
                       child: Column(
                         children:[
                           (_video_story != null)?
                           (_videoPlayerController_story.value.initialized
                               ? AspectRatio(
                               aspectRatio: _videoPlayerController_story.value.aspectRatio,
                               child:  VideoPlayer(_videoPlayerController_story)
                           )
                               :Container())
                               :Container(
                             height: 200,
                             width: size.width,
                             decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: grey),
                             child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [Container(
                                   height: 50,
                                   margin: EdgeInsets.only(bottom: 10),
                                   child: Image.asset('assets/upload.png'),
                                 ),
                                   Text("Upload file here",style: TextStyle(color: grey1,fontSize: 18,),),]
                             ),
                           ),

                         ],
                       ),
                     ),
                     (_video_story!=null)?FloatingActionButton(
                       onPressed: () {
                         setState(() {

                           if(_videoPlayerController_story.value.isPlaying==true || (isplaying_story==true && _videoPlayerController_story.value.position <  _videoPlayerController_story.value.duration)){setState(() {
                             _videoPlayerController_story.pause();isplaying_story=false;
                           });}
                           else if(_videoPlayerController_story.value.position >= _videoPlayerController_story.value.duration){setState(() {_videoPlayerController_story.play();isplaying_story=true;  _videoPlayerController_story.initialize();

                           });}
                           else{setState(() {
                             _videoPlayerController_story.play();isplaying_story=true;
                           });}
                         });
                       },
                       // Display the correct icon depending on the state of the player.
                       child: Icon(
                         isplaying_story? Icons.pause : Icons.play_arrow,
                       ),
                     ):Container()
                   ],
                 )),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Your planned caption",style: TextStyle(color: grey1),),
                      InkWell(onTap: () {
                      _showDialog();
                       },
              child: Container(margin:EdgeInsets.only(left: 10),padding:EdgeInsets.only(top: 5,),height:30,child: Image.asset(
                  'assets/quote.png'),),),
                    ],
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    controller: captionFilter,
                    style: TextStyle(fontSize: 17, color: Colors.black54),
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        errorStyle: TextStyle(color: Colors.red),
                        filled: true,
                        fillColor: pink,
                        contentPadding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(40),)

                    ),

                  ),
                  SizedBox(height: 50,),
                  InkWell(onTap:(){
                    caption=captionFilter.text;
                    Navigator.pop(context, [select_foto_feed==true?_image_feed:_video_feed, select_foto_story==true?_image_story:_video_story]);
                    select_foto_feed=null; select_foto_story=null;
                  },
                  child:  Container(

                      width: size.width/5,
                      height: 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.pink),
                      child:Center(child:Text("Save",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,fontSize: 12)),)
                  ), )
                ],
              )
          ),
        )
    );
  }
  showAlertDialog(BuildContext context) {
    const Color grey = Color(0xFFefefef);
    // set up the AlertDialog
    const Color red = Color(0xFFee7f9f);
    var size = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius:
      BorderRadius.all(Radius.circular(30))),
       content:  Container(
          height:150,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30.0),),
         child: Column(
           children:[
             SizedBox(height: 20,),
             Text("Silakan Pilih upload foto\n atau video",textAlign:TextAlign.center,style: TextStyle(fontSize: 17),),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Container(
                 padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                 decoration: BoxDecoration( color: grey,borderRadius: BorderRadius.circular(5)),
                 child: InkWell(
                   onTap:(){

                    Navigator.pop(context);
                    _pickImageFromGallery();
                   },
                   child: Text("Foto"),
                 ),
               ),
               SizedBox(width: 30,),
               Container(
                 padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                 decoration: BoxDecoration( color: grey,borderRadius: BorderRadius.circular(5)),
                 child: InkWell(
                   onTap:(){

                      Navigator.pop(context);
                     _pickVideo();
                   },
                   child: Text("Video"),
                 ) ,
               )

           ],
         )]
         ),
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
  showAlertDialog_story(BuildContext context) {
    const Color grey = Color(0xFFefefef);
    // set up the AlertDialog
    const Color red = Color(0xFFee7f9f);
    var size = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius:
      BorderRadius.all(Radius.circular(30))),
      content:  Container(
        height:150,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30.0),),
        child: Column(
            children:[
              SizedBox(height: 20,),
              Text("Silakan Pilih upload foto\n atau video",textAlign:TextAlign.center,style: TextStyle(fontSize: 17),),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    decoration: BoxDecoration( color: grey,borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap:(){

                        select_foto_story=true;
                        Navigator.pop(context);
                        _pickImageFromGallery_story();
                      },
                      child: Text("Foto"),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    decoration: BoxDecoration( color: grey,borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap:(){
                        select_foto_story=false;
                        Navigator.pop(context);
                        _pickVideo_story();
                      },
                      child: Text("Video"),
                    ) ,
                  )

                ],
              )]
        ),
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
  void _showDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return  Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  height: 50,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],)

                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                     Text("Write down the caption that you plan to publish on your post. Please make sure the mandatory captions that client want you to publish are included in your planned caption.",style: TextStyle(height:1.5,fontSize: 16),)
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
