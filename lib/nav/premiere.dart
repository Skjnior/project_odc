import 'package:flutter/material.dart';


class PremierePage extends StatefulWidget {
  const PremierePage({super.key});

  @override
  State<PremierePage> createState() => _PremierePageState();
}

class _PremierePageState extends State<PremierePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Prémière"),
      ),
    );
  }
}
