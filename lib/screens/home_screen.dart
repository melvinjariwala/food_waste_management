import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_waste_management/screens/detailed_view.dart';
import 'package:food_waste_management/screens/faq.dart';
import 'package:food_waste_management/screens/history.dart';
import 'package:food_waste_management/screens/login_screen.dart';
import 'package:food_waste_management/screens/order_tracking.dart';

void main() {
  runApp(const dash());
}

class dash extends StatefulWidget {
  const dash({Key? key}) : super(key: key);

  @override
  State<dash> createState() => _dashState();
}

class _dashState extends State<dash> {
  late String _userId;
  //late String phoneNo = "0000";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String? phoneNo = _auth.currentUser!.phoneNumber;
  final searchController = TextEditingController();

  get PhoneNumber => phoneNo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 188, 120, 210),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 188, 105, 213),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(),
                      accountName: const Text(
                        "Welcome back, ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Colors.black),
                      ),
                      accountEmail: Text(
                        PhoneNumber!,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      currentAccountPicture: const CircleAvatar(
                          child: Icon(Icons.account_circle_rounded,size: 42,), backgroundColor: Color.fromARGB(255, 138, 0, 189)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,8.0,18.0,8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 138, 0, 189),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.3,
                          blurRadius: 3,
                        )
                      ]),
                  child: ListTile(
                    leading: const Icon(Icons.history,color: Colors.white,),
                    title: const Text(
                        "History",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const history()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,8.0,18.0,8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 138, 0, 189),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black, spreadRadius: 0.3, blurRadius: 3)
                      ]),
                  child: ListTile(
                    leading: const Icon(CupertinoIcons.map,color: Colors.white,),
                    title: const Text(
                      "Order Tracking",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const order_tracking()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,8.0,18.0,8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 138, 0, 189),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black, spreadRadius: 0.3, blurRadius: 3)
                      ]),
                  child: ListTile(
                    leading: const Icon(Icons.question_answer_outlined,color: Colors.white,),
                    title: const Text(
                      "FAQ",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const faq()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,8.0,18.0,8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 0, 189),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3,
                          )
                        ]),
                    child: ListTile(
                      leading: const Icon(Icons.logout,color: Colors.white,),
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("FEED"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 138, 0, 189),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autocorrect: true,
                          controller: searchController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21.0)),
                                borderSide:
                                    BorderSide(color: Color.fromARGB(255, 138, 0, 189))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(21.0)),
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            labelText: 'Search',
                            hintText: "Enter your desired location",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.search,color: Color.fromARGB(255, 138, 0, 189),),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(21.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.3,
                              blurRadius: 3
                          )
                        ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                  "Donor Name",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                  "Melvin Jariwala",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                  "Donor Address",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                  "126, Narayan Nagar",
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(21.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Donor Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Dharal Zaveri",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                "Donor Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "B-4 Vishranti App.",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(21.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Donor Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Arunava Guhatha",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                "Donor Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "B-4 Sai App.",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(21.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Donor Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Joy Toor",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                "Donor Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "D-6 JoyCity App.",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(21.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Donor Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Vats Balar",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                "Donor Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "G-6 Girdhar App.",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(21.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Donor Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Melvin Jariwala",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                "Donor Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "126, Narayan Nagar",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(21.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 3
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Donor Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Melvin Jariwala",
                                style: TextStyle(
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
                            children: const <Widget>[
                              Text(
                                "Donor Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "126, Narayan Nagar",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const detaild_view()));
                  },
                ),
              )
            ],
          ),
        ),

        /*floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const current_booking()));
            },
            child: Icon(CupertinoIcons.ticket_fill),
        ),*/
      ),
    );
  }
}
