import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/allcampaigns/all_campaigns.dart';
import 'package:flutter_app_kazee5/filter/filter.dart';
import 'package:flutter_app_kazee5/invitation/invitation.dart';
import 'package:flutter_app_kazee5/mycampaigns/my_campaigns.dart';
import 'package:flutter_app_kazee5/profile/profile.dart';
import 'package:flutter_app_kazee5/search/search.dart';
import 'package:flutter_app_kazee5/upcoming/upcoming.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int index = 0;
  int bottomIndex = 0;

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    super.initState();
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/logo 198@3x.png",
            height: 20.0,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
            IconButton(
                icon: Image.asset(
                  "assets/bell 155@3x.png",
                  height: 25.0,
                ),
                onPressed: () {})
          ],
        ),
        body: IndexedStack(
          index: bottomIndex,
          children: [
            homeView(context),
            Search(),
            MyCampaigns(),
            Profile(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: bottomIndex == 0
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Filter(),
                      ));
                },
                child: Container(
                  height: 35.0,
                  width: 105.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: kLinearGradient,
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  child: Text(
                    "Filter",
                    style: TextStyle(color: kBackgoundColor),
                  ),
                ),
              )
            : SizedBox.shrink(),
        bottomNavigationBar:Container(
            height: 70.0,
            decoration: BoxDecoration(
                gradient: kLinearGradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.0),
                    topRight: Radius.circular(14.0))),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bottomIndex = 0;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/home137@3x.png",
                              height: 25,
                                color: (bottomIndex==0)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  color: (bottomIndex==0)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bottomIndex = 1;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/search 208@3x.png",
                              height: 25, color: (bottomIndex==1)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  color: (bottomIndex==1)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bottomIndex = 2;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/speaker 137@3x.png",
                              height: 25, color: (bottomIndex==2)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "My Campaigns",
                              style: TextStyle(
                                  color: (bottomIndex==2)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bottomIndex = 3;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/account 136@3x.png",
                              height: 25, color: (bottomIndex==3)?knavigationSelectedLabelColor:kBackgoundColor
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                  color: (bottomIndex==3)?knavigationSelectedLabelColor:kBackgoundColor, fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            )));
  }

  Column homeView(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: kTabbarColor,
          child: TabBar(
              controller: tabController,
              unselectedLabelColor: kUnselectedLabelColor,
              labelColor: kSelectedLabelColor,
              indicatorColor: kSelectedLabelColor,
              labelStyle: TextStyle(fontSize: 12.0),
              tabs: [
                Tab(
                  text: "All Campaigns",
                ),
                Tab(
                  text: "Upcoming",
                ),
                Tab(
                  text: "Invitation",
                )
              ]),
        ),
        Expanded(
            child: TabBarView(
                controller: tabController,
                children: [AllCampaigns(), UpComing(), Invitation()]))
      ],
    );
  }
}
