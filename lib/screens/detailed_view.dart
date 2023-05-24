import 'package:flutter/material.dart';

class DetailedView extends StatefulWidget {
  final String name;
  final String address;
  final String food;
  final int quantity;
  final int people;
  const DetailedView({Key? key,
    required this.name,
    required this.address,
    required this.food,
    required this.quantity,
    required this.people
  }) : super(key: key);

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 236),
      appBar: AppBar(
        title: const Text("Donation Details"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 162, 93),
      ),
      body: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Container(
          height: 255,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'Name : ',
                      style: TextStyle(
                        fontSize: 21,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Address : ',
                      style: TextStyle(
                          fontSize: 21,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Food : ',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.food,
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity : ',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      ((widget.quantity)/1000).toString() + " Kg",
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'No. of People : ',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.people.toString(),
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            boxShadow: [BoxShadow(
              color: Colors.black,
              spreadRadius: 0.3,
              blurRadius: 0.3
            )]
          ),
        ),
      ),
    );
  }
}

