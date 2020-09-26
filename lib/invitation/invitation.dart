// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../LoginDialog.dart';
// class Invitation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//          child:LoginDialog()
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/component/gradient_button.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
class Invitation extends StatefulWidget {
  @override
  _Invitation createState() => _Invitation();
}

class _Invitation extends State<Invitation> {
  List items = List();
  int perPage  = 5;
  int present = 0;
  List list = [false, true, false];
  void initState() {
    super.initState();
    setState(() {
      // items.addAll(data_invitations.getRange(present, present + perPage));
      present = present + perPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container();
    // return Stack(
    //   children: [
    //     new ListView.builder(
    //         itemCount:(present <= data_invitations.length) ? items.length + 1 : items.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return (index == items.length ) ?
    //           InkWell( child:Container(
    //               margin: EdgeInsets.only(bottom: 80),
    //               height: 35.0,width: size.width,
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                   gradient: kLinearGradient,
    //                   borderRadius: BorderRadius.all(Radius.circular(100.0))),
    //               child:Text("Load more",style: TextStyle(color: Colors.white),)
    //           ),  onTap: () {
    //             setState(() {
    //               if((present + perPage)> data_allcampagins.length) {
    //                 items.addAll(
    //                     data_invitations.getRange(present, data_allcampagins.length));
    //               } else {
    //                 items.addAll(
    //                     data_invitations.getRange(present, present + perPage));
    //               }
    //               present = present + perPage;
    //             });
    //           },)
    //               :buildCard(context,index);
    //         }),
    //
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: GradientButton(
    //         text: "Filter",
    //         onclick: () => print("Hello Filter"),
    //       ),
    //     ),
    //   ],
    // );
  }
  Container buildCard(BuildContext context,int index) {
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
                            list[0] = !list[0];
                          });
                        },
                        child: Image.asset(
                          "assets/fav 567@3x (2).png",
                          color:
                          list[0] ? kSelectedLabelColor : kBackgoundColor,
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
                          data_invitations[index]['countdown'],
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
                                    Text(
                                      data_invitations[index]['hashtag'],
                                      style: TextStyle(
                                          color: kTextThemColor1, fontSize: 12.0),
                                    ),
                                    Text(
                                      data_invitations[index]['price'] != null ? data_invitations[index]['price']: "",
                                      style: TextStyle(
                                          color: kTextThemColor2, fontSize: 12.0),
                                    )
                                  ],
                                ),
                                Text(
                                  data_invitations[index]['campaign_name'],
                                  style: TextStyle(
                                      color: kTextThemColor3, fontSize: 18.0),
                                ),
                                Text(
                                  data_invitations[index]['location'],
                                  style: TextStyle(
                                      color: kTextThemColor1, fontSize: 12.0),
                                ),
                                Text(
                                  data_invitations[index]['niche'] +" - "+data_invitations[index]['gender'],
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
}
