import 'package:flutter/material.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 120, 210),
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 138, 0, 189),
      ),
    );
  }
}
