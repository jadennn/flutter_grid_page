import 'package:flutter/material.dart';
import 'package:flutter_grid_page/grid_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridPage(children: _buildChildren(), column: 7, row: 4,),
    );
  }

  ///构建数据
  List<Widget> _buildChildren(){
    List<Widget> list = List();
    for(int i=0; i<133; i++){
      list.add(GestureDetector(child:Icon(Icons.android, color: Colors.green, size: 40.0,), onTap: (){
        Fluttertoast.showToast(msg: "item $i on click");
      },),);
    }
    return list;
  }
}
