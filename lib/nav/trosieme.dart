import 'package:flutter/material.dart';


class Troisieme extends StatefulWidget {
  const Troisieme({super.key});

  @override
  State<Troisieme> createState() => _TroisiemeState();
}

class _TroisiemeState extends State<Troisieme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Troisième"),
      ),
    );
  }
}
