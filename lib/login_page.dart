import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/login_splash.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'CustomDialog.dart';
class MyDemo extends StatefulWidget {
  @override
  login_page createState() => login_page();
}
class login_page extends State<MyDemo> {
  var currentSelectedcity;
  var currentSelectedprovinsi;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var Kota = ["Bandung", "Batu", "Bekasi","Denpasar"];
    var Provinsi = ["Papua", "East Java", "Aceh","Central Java","West Java","West Sumatra"];
    const Color red = Color(0xFFef5642);
    const Color light_red = Color(0xFFf23367);
    const Color light_white = Color(0xFFf7c8b6);
    const Color light_grey = Color(0xFFf0afb0);
    const Color text_color = Color(0xFFfbd5d6);
    const Color blue = Color(0xFF0035b3);
    const Color next = Color(0xFF674575);
    const Color checkbox_white = Color(0xFFffffff);
    return Scaffold(
      body: Center(
         child:Container(
           width: size.width,height: size.height,
           decoration: BoxDecoration(
             gradient:LinearGradient(colors: [light_red,red],begin: Alignment.bottomCenter,end: Alignment.topCenter,),
             color: red,),
             child:  ListView(
               scrollDirection: Axis.vertical,
               children: [
                 SizedBox(height: size.height/15),
                 Container(
                   alignment: Alignment.center,
                   child:Text("Complete Registration",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/40, color: light_white),),),
                 SizedBox(height: size.height/25),
                 Row( children:[SizedBox(width: size.width/10),Text("Nama Lengkap",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: light_grey),), ]),
                 Container(
                   height: size.height/15,
                   margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                   child: TextField(
                     autofocus: false,
                     style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                     cursorColor: Colors.black54,
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       filled: true,
                       fillColor: light_grey,
                       contentPadding:
                       const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: size.height/50),
                 Row( children:[SizedBox(width: size.width/10),Text("Akun Instagram",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: light_grey),), ]),
                 Container(
                   height: size.height/15,
                   margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                   child: TextField(
                     autofocus: false,
                     style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                     cursorColor: Colors.black54,
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       filled: true,
                       fillColor: light_grey,
                       contentPadding:
                       const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: size.height/50),
                 Row( children:[SizedBox(width: size.width/10),Text("No Handphone",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: light_grey),), ]),
                 Container(
                   height: size.height/15,
                   margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                   child: TextField(
                     autofocus: false,
                     style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                     cursorColor: Colors.black54,
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       filled: true,
                       fillColor: light_grey,
                       contentPadding:
                       const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: size.height/50),
                 Row( children:[SizedBox(width: size.width/10),Text("Lokasi Domisili",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: light_grey),), ]),
                 SizedBox(height: size.height/60),
                 Container(

                   margin: EdgeInsets.only(left: size.width/10,right: size.width/10),
                   decoration: BoxDecoration(
                     color: light_grey,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: FormField<String>(
                     builder: (FormFieldState<String> state) {
                       return InputDecorator(
                         decoration: InputDecoration(
                             contentPadding:const EdgeInsets.only(left: 14.0),
                             border: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.transparent),
                                 borderRadius: BorderRadius.circular(10.0))),
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton<String>(
                             hint: Text("Pilih Provinsi",style: TextStyle(fontSize: size.height/45,fontStyle: FontStyle.normal, color: Colors.white)),
                             value: currentSelectedprovinsi,
                             isDense: true,
                             onChanged: (newValue) {
                               setState(() {
                                 currentSelectedprovinsi=newValue;
                               });
                             },
                             items: Provinsi.map((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/52, color: Colors.black54)),
                               );
                             }).toList(),
                           ),
                         ),
                       );
                     },
                   ),
                 ),
                 SizedBox(height: size.height/50),
                 Container(
               margin: EdgeInsets.only(left: size.width/10,right: size.width/10),
               decoration: BoxDecoration(
               color: light_grey,
               borderRadius: BorderRadius.circular(10),
               ),
               child: FormField<String>(
                 builder: (FormFieldState<String> state) {
                   return InputDecorator(
                     decoration: InputDecoration(
                             contentPadding:const EdgeInsets.only(left: 14.0),
                             border: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.transparent),
                             borderRadius: BorderRadius.circular(10.0))),
                     child: DropdownButtonHideUnderline(
                       child: DropdownButton<String>(
                         hint: Text("Pilih Kota",style: TextStyle(fontSize: size.height/45,fontStyle: FontStyle.normal, color: Colors.white)),
                         value: currentSelectedcity,
                         isDense: true,
                         onChanged: (newValue) {
                           setState(() {
                             currentSelectedcity=newValue;
                           });
                         },
                         items: Kota.map((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/52, color: Colors.black54)),
                           );
                         }).toList(),
                       ),
                     ),
                   );
                 },
               ),
             ),
                 SizedBox(height: size.height/40),
                 Row(
                   children: [
                     SizedBox(width: size.width/10),
                     GestureDetector(
                       onTap: (){
                         checked=!(checked);
                       },
                       child: new Transform.scale(
                           scale:1.5,
                           child:new Checkbox(
                           checkColor: Colors.black,
                           activeColor: checkbox_white,
                           value: checked,
                           onChanged: (val) {
                             setState(() {
                               checked = val;
                             });}
                       )),),

                     Text(" I accept the terms in the  ",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/60, color: light_white),),
                     GestureDetector(
                       onTap: (){
                         showDialog(context: context, builder: (BuildContext context) => CustomDialog(),);
                       },
                       child:Text("T&C agreement",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/60, color: blue),),),

                   ],
                 ),
                 SizedBox(height: size.height/30),
                 Row(
                   children: [
                     SizedBox(width: size.width/1.5),
                     ButtonTheme(
                       minWidth: size.width/4,
                       height: size.height/18,
                       child: RaisedButton(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.0),
                            ),
                         onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => login_splash(),));
                         },
                         color: next,
                         textColor: light_white,
                         child: Text("Next",style: TextStyle(fontSize: size.width/30)),
                       ),
                     )
                   ],
                    )
               ],
             ),
         )
      ),
    );

  }
}