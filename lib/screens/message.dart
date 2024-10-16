import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class MessagesPage extends StatefulWidget {
   MessagesPage({super.key,  required this.messages, required this.nom});
 late String nom;
  late String messages;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  late String msg;
  late String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msg = widget.messages;
    name = widget.nom;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyMessageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                  Text(name),
                  Text(msg),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





// Mon App bar perso
class MyMessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      child: Stack(
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: HexColor("#181818"),
            centerTitle: true,
            leading:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white70,
                  ),
                ),

              ],
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  onPressed: (){
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    size: 30,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        /*  Positioned(
            top: 120.0, // Positionnement de la barre de recherche
            left: 0.0,
            right: 0.0,
            child: Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: HexColor("#000000"),
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 32,
                    ),
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: Colors.white60,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
