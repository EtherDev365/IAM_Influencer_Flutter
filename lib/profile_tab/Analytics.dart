import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  @override
  _Activity createState() => _Activity();
}
class _Activity extends State<Analytics>with AutomaticKeepAliveClientMixin<Analytics> {
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