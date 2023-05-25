import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final String name;
  final String address;
  const Checkout({Key? key,
    required this.name,
    required this.address
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 236),
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 162, 93),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.face_retouching_off_outlined,size: 72,)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  Text(
                      "No volunteers found!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                    "You might need to visit donor to get the food.",
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
              ],
            ),
            const SizedBox(height: 81),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(27.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment : MainAxisAlignment.center,
                            children: const[
                              Text(
                                  "Donor Details",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                  "Name : ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                  widget.name,
                                style: const TextStyle(
                                  fontSize: 18
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Address : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                widget.address,
                                style: const TextStyle(
                                    fontSize: 18
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
