import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/CustomSlider.dart';
import 'package:flutter_app_kazee5/utils/color.dart';

class Filter extends StatefulWidget {
  Filter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Filter createState() => _Filter();
}


class _Filter extends State<Filter> {
  double _starValue = 0;
  double _endValue = 0;
  double minValue = 0;
  double maxValue = 100000;

  final startController = TextEditingController();
  final endController = TextEditingController();

  @override
  void initState() {
    super.initState();

    startController.addListener(_setStartValue);
    endController.addListener(_setEndValue);
  }


  _setStartValue() {
    if (double.parse(startController.text).roundToDouble() <=
        double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _starValue = double.parse(startController.text).roundToDouble();
      });
    }
    print("Second text field: ${startController.text}");
  }

  _setEndValue() {
    if (double.parse(startController.text).roundToDouble() <=
        double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _endValue = double.parse(endController.text).roundToDouble();
      });
    }
    print("Second text field: ${endController.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<String> kategori = [
      "Parenting",
      "Entertainment",
      "Health & Sport",
      "Lifestyle & Travel",
      "Fashion",
      "Technology",
      "Beauty",
      "Food",
      "Other"
    ];
    List<String> status = [
      "On Going",
      "Finished",
    ];
    List<String> gender = [
      "Male",
      "Female",
    ];
    List<String> selectedReportList = List();

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text("Filter Campaign ",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: kLinearGradient),
        ),
        actions: [
          Container(
            margin:EdgeInsets.only(top:size.width/150,right:size.width/10,),
            alignment: Alignment.center,
            child: Text("Clear",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22),),)
        ],
      ),
      body:SingleChildScrollView(child: Center(
          child:Column(
            children: [
              SizedBox(height: size.height/15,),
              Row(children: [
                SizedBox(width: size.width/20,),
                Text("Katgori",style:TextStyle(fontSize: size.width/22)),
              ],),
              SizedBox(height: size.height/40,),
              Container(margin: EdgeInsets.only(left:size.width/20,),child:SingleChildScrollView(scrollDirection:Axis.horizontal,child:MultiSelectChip(kategori,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedReportList = selectedList;
                  });
                },),),),
              SizedBox(height: size.height/20,),
              Row(children: [
                SizedBox(width: size.width/20,),
                Text("Status",style:TextStyle(fontSize: size.width/22)),


              ],),
              SizedBox(height: size.height/40,),
              Container(alignment:Alignment.centerLeft,margin: EdgeInsets.only(left:size.width/20,),child:SingleChildScrollView(scrollDirection:Axis.horizontal,child:MultiSelectChip(status, onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },),),),
              SizedBox(height: size.height/20,),
              Row(children: [
                SizedBox(width: size.width/20,),
                Text("Gender",style:TextStyle(fontSize: size.width/22)),

              ],),
              SizedBox(height: size.height/50,),
              Container(alignment:Alignment.centerLeft,margin: EdgeInsets.only(left:size.width/20,),child:SingleChildScrollView(scrollDirection:Axis.horizontal,child:MultiSelectChip(gender, onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },),),),
              SizedBox(height: size.height/20,),
              Row(children: [
                SizedBox(width: size.width/15,),
                Text("Followers",style:TextStyle(fontSize: size.width/22)),
              ],),
              SizedBox(height: size.height/40,),
              Row(children: [
                SizedBox(width: size.width/20,),
                Container(height: size.height/30,width: size.width/3.5,alignment:Alignment.center,child:TextField(  controller: startController,textAlign:TextAlign.center,style: TextStyle(color:kSelectedLabelColor,fontSize: size.height/50),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                  ),
                ),),
                Text("  -  "),
                Container(height: size.height/30,width: size.width/3.5,alignment:Alignment.center,child:TextField(controller: endController,textAlign:TextAlign.center,style: TextStyle(color:kSelectedLabelColor,fontSize: size.height/50),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                  ),
                ),)
              ],),
              SizedBox(height: size.height/30),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: kSelectedLabelColor,
              inactiveTrackColor:  Colors.grey[300],
              trackHeight: 3.0,
              thumbShape:CustomSliderThumbCircle(),
              thumbColor: kSelectedLabelColor,
              overlayColor: kSelectedLabelColor.withAlpha(50),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            ),child: RangeSlider(
            values: RangeValues(_starValue, _endValue),
            min: minValue,
            max: maxValue,
            onChanged: (values) {
              setState(() {
                _starValue = values.start.roundToDouble();
                _endValue = values.end.roundToDouble();
                startController.text =
                    values.start.roundToDouble().toString();
                endController.text = values.end.roundToDouble().toString();
              });
            },
          ),),

              SizedBox(height: size.height/15,),
              GestureDetector(
                onTap: () {
                },
                child: Container(
                    width: size.width/1.7,
                    height: size.height/20,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),gradient: kLinearGradient),
                  child: Center(child:Text("Save",style: TextStyle(color:Colors.white,fontSize:  size.height/40,)),)
                ),
              )
            ],
          )
      ),)
    );
  }
}

class SliderCustomShape {

}
class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip(
      this.reportList,
      {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          padding: const EdgeInsets.only(top:6.0,bottom: 6,left: 10,right: 10),
          label: Text(item,style: TextStyle(fontSize: 16,color:selectedChoices.contains(item)
              ?Colors.white:Colors.black38 ),),
          selected: selectedChoices.contains(item),
          selectedColor: kSelectedLabelColor,
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}