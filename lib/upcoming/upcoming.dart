import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/component/gradient_button.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
class UpComing extends StatefulWidget {
  @override
  _UpComing createState() => _UpComing();
}

class _UpComing extends State<UpComing>with AutomaticKeepAliveClientMixin<UpComing> {
  @override
  bool get wantKeepAlive => true;
  int perPage_upcoming  = 5;
  int present_upcoming = 0;
  List<bool> _selected = List.generate(1000, (i) => false);
  void initState() {
    super.initState();
    items_upcoming.clear();
    setState(() {
      if((5>=data_upcoming.length)){items_upcoming.addAll(data_upcoming);present_upcoming=data_upcoming.length;}else{items_upcoming.addAll(data_upcoming.getRange(0, 5));present_upcoming=5;}
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);
    return data_upcoming != null ?
    Stack(
      children: [
        new ListView.builder(
            itemCount:(present_upcoming < data_upcoming.length) ? items_upcoming.length + 1 : items_upcoming.length,
            itemBuilder: (BuildContext context, int index) {
              return ((index == items_upcoming.length)&&(index!=data_upcoming.length) ) ?
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
                  if((present_upcoming + perPage_upcoming)> data_upcoming.length) {
                    items_upcoming.addAll(
                        data_upcoming.getRange(present_upcoming, data_upcoming.length));
                  } else {
                    items_upcoming.addAll(
                        data_upcoming.getRange(present_upcoming, present_upcoming + perPage_upcoming));
                  }
                  present_upcoming = present_upcoming + perPage_upcoming;
                });
              },)
                  :buildCard(context,index);
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
            child:Text("Campaign Upcoming Tidak Tersedia",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/40, color: black2)),)
        ],
      ),
    );

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
                  items_upcoming[index]['logo_campaign'],
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
                        if (items_upcoming[index]['premium_campaign']==0) {
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
                            _selected[index] = !_selected[index];
                          });
                        },
                        child: Image.asset(
                          "assets/fav 567@3x (2).png",
                          color:
                          _selected[index]  ? kSelectedLabelColor : kBackgoundColor,
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
                          items_upcoming[index]['release_date'],
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
                                      items_upcoming[index]['hashtag'],
                                      style: TextStyle(
                                          color: kTextThemColor1, fontSize: 12.0),
                                    ),
                                    Text(
                                      data_upcoming[index]['price'] != null ? data_upcoming[index]['price'].toString(): "",
                                      style: TextStyle(
                                          color: kTextThemColor2, fontSize: 12.0),
                                    )
                                  ],
                                ),
                                Text(
                                  items_upcoming[index]['campaign_name'],
                                  style: TextStyle(
                                      color: kTextThemColor3, fontSize: 18.0),
                                ),
                                Text(
                                  items_upcoming[index]['location'],
                                  style: TextStyle(
                                      color: kTextThemColor1, fontSize: 12.0),
                                ),
                                Text(
                                  items_upcoming[index]['niche'] +" - "+data_upcoming[index]['gender'],
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








