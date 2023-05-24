
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screens/detailed_view.dart';

class DonationTile extends StatelessWidget {
  final String name;
  final String address;
  final String food;
  final int quantity;
  final int people;
  const DonationTile({Key? key,
    required this.name,
    required this.address,
    required this.food,
    required this.quantity,
    required this.people
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(21.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                spreadRadius: 0.3,
                blurRadius: 0.3
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                  const Text(
                    "Donor Name",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 15
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  const Text(
                    "Donor Address",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),

                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      address,
                      style: const TextStyle(
                          fontSize: 15
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailedView(name: name,address: address,food: food, quantity: quantity,people: people)));
      },
    );
  }
}
