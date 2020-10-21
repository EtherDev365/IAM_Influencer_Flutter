import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';

class Timeline extends StatefulWidget {
  @override
  _Demo createState() => _Demo();
}
class _Demo extends State<Timeline>with AutomaticKeepAliveClientMixin<Timeline> {
  @override
  bool get wantKeepAlive => true;

  int perPage_timeline  = 10;
  int present_timeline = 0;
  void initState(){
    setState(() {
      if(data_timeline!=null){ if((5>=data_timeline.length)){items_timeline.clear();items_timeline.addAll(data_timeline);present_timeline=data_timeline.length;}else{items_timeline.clear();items_timeline.addAll(data_timeline.getRange(0, 5));present_timeline=5;}}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      
        body: data_timeline==null?Container(): new ListView.builder(
            itemCount:(present_timeline< data_timeline.length) ? items_timeline.length + 1 : items_timeline.length,
            itemBuilder: (BuildContext context, int index) {
              return ((index == items_timeline.length )&&(index!=data_timeline.length)) ?
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
                  if((present_timeline+ perPage_timeline)> data_timeline.length) {
                    items_timeline.addAll(
                        data_timeline.getRange(present_timeline, data_timeline.length));
                  } else {
                    items_timeline.addAll(
                        data_timeline.getRange(present_timeline, present_timeline+ perPage_timeline));
                  }
                  present_timeline= present_timeline+ perPage_timeline;
                });
              },):buildCard(context,index);
            }),


    );
  }

  Container buildCard(BuildContext context,int index) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height:250,
            // child: Image.network(data_timeline[index]['foto_feed']),
            // decoration: BoxDecoration(
            //
            //   borderRadius: BorderRadius.circular(20),
            // ),
            decoration: BoxDecoration(
              image:DecorationImage(
                  image: NetworkImage(data_timeline[index]['foto_feed'])
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 25,right: 20,bottom: 20),
                height:50,
                width: 50,
                // child: Image.network(data_timeline[index]['avatar']),
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image: NetworkImage(data_timeline[index]['avatar'])
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Flexible(child:  Container(margin:EdgeInsets.only(bottom: 20),child:Text(data_timeline[index]['username'], style: TextStyle(fontSize: 20, color: Colors.black54),),),)
            ],
          ),

          Container(  margin: EdgeInsets.only(left: 30,right: 30,bottom: 15,),child: Text(data_timeline[index]['caption']),),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30,right: 5,bottom: 10),
                height:25,
                width: 25,
                child: Image.asset('assets/like.png'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(  margin: EdgeInsets.only(left: 10,right: 5,bottom: 5),height: 25,child:     Text(data_timeline[index]['like_count'].toString(), style: TextStyle(fontSize: 14, color: Colors.black54),),),
              Container(  margin: EdgeInsets.only(left: 0,right: 5,bottom: 5),height: 25,child:     Text("Like", style: TextStyle(fontSize: 14, color: Colors.black54),),),
              Container(
                margin: EdgeInsets.only(left: 30,right: 5,bottom: 10),
                height:25,
                width: 25,
                child: Image.asset('assets/comment.png'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(  margin: EdgeInsets.only(left: 10,right: 5,bottom: 5),height: 25,child:     Text(data_timeline[index]['comment_count'].toString(), style: TextStyle(fontSize: 14, color: Colors.black54),),),
              Container(  margin: EdgeInsets.only(left: 0,right: 5,bottom: 5),height: 25,child:     Text("Comment", style: TextStyle(fontSize: 14, color: Colors.black54),),)

            ],
          ),
          Row(children: [
            Container(  margin: EdgeInsets.only(left: 35,right: 5,bottom:0 ),height: 25,child:     Text(data_timeline[index]['datetime'], style: TextStyle(fontSize: 14, color: Colors.black54),),)
          ],)


        ],
      ),
    );
  }
}