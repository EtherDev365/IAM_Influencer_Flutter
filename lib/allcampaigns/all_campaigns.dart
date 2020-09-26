import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/component/gradient_button.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
class AllCampaigns extends StatefulWidget {
  @override
  _AllCampaignsState createState() => _AllCampaignsState();
}

class _AllCampaignsState extends State<AllCampaigns>with AutomaticKeepAliveClientMixin<AllCampaigns> {
  @override
  bool get wantKeepAlive => true;
  int perPage  = 5;
  int present = 0;
  List<bool> _selected = List.generate(1000, (i) => false);
  void initState() {
    super.initState();
    items.clear();
    setState(() {
      if((5>=data_allcampagins.length)){items.addAll(data_allcampagins);present=data_allcampagins.length;}else{items.addAll(data_allcampagins.getRange(0, 5));present=5;}
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);
    return data_allcampagins!=null? Stack(
      children: [
        new ListView.builder(
            itemCount:(present < data_allcampagins.length) ? items.length + 1 : items.length,
            itemBuilder: (BuildContext context, int index) {
              return (index == items.length ) ?
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
                  if((present + perPage)> data_allcampagins.length) {
                    items.addAll(
                        data_allcampagins.getRange(present, data_allcampagins.length));
                  } else {
                    items.addAll(
                        data_allcampagins.getRange(present, present + perPage));
                  }
                  present = present + perPage;
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
                  data_allcampagins[index]['logo_campaign'],
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
                        if (data_allcampagins[index]['premium_campaign']==0) {
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
                            _selected[index]=!_selected[index];
                          });
                        },
                        child: Image.asset(
                          "assets/fav 567@3x (2).png",
                          color:
                         _selected[index]? kSelectedLabelColor : kBackgoundColor,
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
                        data_allcampagins[index]['countdown'],
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
                                  data_allcampagins[index]['hashtag'],
                                  style: TextStyle(
                                      color: kTextThemColor1, fontSize: 12.0),
                                ),
                                Text(
                                  data_allcampagins[index]['price'] != null ? data_allcampagins[index]['price'].toString(): "",
                                  style: TextStyle(
                                      color: kTextThemColor2, fontSize: 12.0),
                                )
                              ],
                            ),
                            Text(
                            data_allcampagins[index]['campaign_name'],
                            style: TextStyle(
                                  color: kTextThemColor3, fontSize: 18.0),
                            ),
                            Text(
                              data_allcampagins[index]['location'],
                              style: TextStyle(
                                  color: kTextThemColor1, fontSize: 12.0),
                            ),
                            Text(
                              data_allcampagins[index]['niche'] +" - "+data_allcampagins[index]['gender'],
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
