import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';

class Activity extends StatefulWidget {
  @override
  _Activity createState() => _Activity();
}
class _Activity extends State<Activity>with AutomaticKeepAliveClientMixin<Activity> {
  @override
  bool get wantKeepAlive => true;

  int perPage_activity  = 10;
  int present_activity = 0;
  void initState(){
    setState(() {
      if(data_activity!=null){ if((10>=data_activity.length)){items_activity.clear();items_activity.addAll(data_activity);present_activity=data_activity.length;}else{items_activity.clear();items_activity.addAll(data_activity.getRange(0, 10));present_activity=10;}}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: data_activity==null?Container(): new ListView.builder(
          itemCount:(present_activity< data_activity.length) ? items_activity.length + 1 : items_activity.length,
          itemBuilder: (BuildContext context, int index) {
            return ((index == items_activity.length )&&(index!=data_activity.length)) ?
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
                if((present_activity+ perPage_activity)> data_activity.length) {
                  items_activity.addAll(
                      data_activity.getRange(present_activity, data_activity.length));
                } else {
                  items_activity.addAll(
                      data_activity.getRange(present_activity, present_activity+ perPage_activity));
                }
                present_activity= present_activity+ perPage_activity;
              });
            },):buildCard(context,index);
          }),


    );
  }

  Container buildCard(BuildContext context,int index) {
    return Container(
      margin: index==0?EdgeInsets.only(top:120):EdgeInsets.only(top:20),
       height: 100,
      child: Row(
        children: [
          Container(

            margin: EdgeInsets.all(10),
            width:70,
            height: 70,
            decoration: BoxDecoration(
              image:DecorationImage(
                  image: NetworkImage(data_activity[index]['logo_campaign'])

              ),
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width:250,child:  Container(child:Text(data_activity[index]['campaign_name'],style: TextStyle(fontSize: 15, color: Colors.black54),),),),
              Container(  margin: EdgeInsets.only(top:10,bottom: 10),child: Text(data_activity[index]['status'], style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15, color: Colors.red),),),
              Container(  margin: EdgeInsets.only(bottom: 0),child:     Text(data_activity[index]['datetime'], style: TextStyle(fontSize: 15, color: Colors.black54),),),
            ],
          ),

        ],
      ),
    );
  }
}