import 'package:flutter/material.dart';

class order_tracking extends StatefulWidget {
  const order_tracking({Key? key}) : super(key: key);

  @override
  State<order_tracking> createState() => _order_trackingState();
}

class _order_trackingState extends State<order_tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 120, 210),
      appBar: AppBar(
        title: const Text("Order Tracking"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 138, 0, 189),
      ),
    );
  }
}
