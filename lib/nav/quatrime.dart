import 'package:flutter/material.dart';


class Quatrieme extends StatefulWidget {
  const Quatrieme({super.key});

  @override
  State<Quatrieme> createState() => _QuatriemeState();
}

class _QuatriemeState extends State<Quatrieme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Quatrième"),
      ),
    );
  }
}
