
import 'package:flutter/material.dart';

class TestCompnent extends StatefulWidget {
  const TestCompnent({super.key});

  @override
  State<TestCompnent> createState() => _TestCompnentState();
}

class _TestCompnentState extends State<TestCompnent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("data")],
    );
  }
}