import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  @override
  _Timeline createState() => _Timeline();
}
class _Timeline extends State<Timeline>with AutomaticKeepAliveClientMixin<Timeline> {
  @override
  bool get wantKeepAlive => true;


  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container()
    );
  }
}