import 'package:flutter/material.dart';

class detaild_view extends StatefulWidget {
  const detaild_view({Key? key}) : super(key: key);

  @override
  State<detaild_view> createState() => _detaild_viewState();
}

class _detaild_viewState extends State<detaild_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 236),
      appBar: AppBar(
        title: const Text("Detailed View"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 162, 93),
      ),
    );
  }
}
