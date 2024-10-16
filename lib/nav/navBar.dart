import 'package:flutter/material.dart';
import 'package:project_odc/nav/premiere.dart';
import 'package:project_odc/nav/quatrime.dart';
import 'package:project_odc/nav/second.dart';
import 'package:project_odc/nav/trosieme.dart';


class BottomNavationAppBar extends StatefulWidget {
  const BottomNavationAppBar({super.key});

  @override
  State<BottomNavationAppBar> createState() => _BottomNavationAppBarState();
}

class _BottomNavationAppBarState extends State<BottomNavationAppBar> {

  var _currentIndex = 0;

  List<Widget> mesPages = [];


  @override
  void initState() {
    // TODO: implement initState

    mesPages = [
      PremierePage(),
      SecondPage(),
      Troisieme(),
      Quatrieme(),
    ];


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BottomAppBar(

      ),
    );
  }
}
