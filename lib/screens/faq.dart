import 'package:flutter/material.dart';

class faq extends StatefulWidget {
  const faq({Key? key}) : super(key: key);

  @override
  State<faq> createState() => _faqState();
}

class _faqState extends State<faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 120, 210),
      appBar: AppBar(
        title: const Text("Frequently Asked Questions"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 138, 0, 189),
      ),
    );
  }
}
