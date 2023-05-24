import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:food_waste_management/DatabaseManager/database_manager.dart';
import 'package:food_waste_management/screens/detailed_view.dart';
import 'package:food_waste_management/screens/faq.dart';
import 'package:food_waste_management/screens/history.dart';
import 'package:food_waste_management/screens/login_screen.dart';
import 'package:food_waste_management/screens/order_tracking.dart';
import 'package:food_waste_management/widgets/donation_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final _db = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> _donationsCollection;
  List<Map<String,dynamic>> _donations = [];
  List<Map<String,dynamic>> _filteredDonations = [];
  int _requirement = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _reqController = TextEditingController();

  get PhoneNumber => phoneNo ?? '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reqController.text = _requirement.toString();
    _donationsCollection = _db.collection('Donations').withConverter<Map<String,dynamic>>(
        fromFirestore: (snapshot,_) => snapshot.data()!,
        toFirestore: (data, _) => data
    );
    fetchAllDonations();
  }

  Future<void> fetchAllDonations() async {
    try {
      final querySnapshot = await _donationsCollection.get();
      setState(() {
        _donations = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
      print(_donations.toString());
    } catch (error) {
      print('Error handling donations: $error');
    }
  }

  Future<void> addDonation(
      String name, String address, String food, int quantity, int people) async {
    try {
      final newDonation = {
        'name': name,
        'address': address,
        'food': food,
        'quantity': quantity,
        'people': people,
      };
      await _donationsCollection.add(newDonation);
      print('Donation added successfully');
    } catch (error) {
      print('Failed to add donation: $error');
    }
  }

  void filterDonations(int requirement){
    setState(() {
      _filteredDonations.clear();

      _filteredDonations = _donations.where((donation) => donation['people'] >= requirement).toList();
    });
  }

  void incrementRequirement(){
    setState(() {
      _requirement++;
      _reqController.text = _requirement.toString();
      filterDonations(_requirement);
    });
  }

  void decrementRequirement(){
    setState(() {
      _requirement--;
      _reqController.text = _requirement.toString();
      filterDonations(_requirement);
    });
  }

  void showAddDonationDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
            backgroundColor: const Color.fromARGB(255, 238, 255, 236),
            title: const Text(
                "Add Donation",
              style: TextStyle(
                color: Color.fromARGB(255, 100, 162, 93)
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name'
                    ),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                        labelText: 'Address'
                    ),
                  ),
                  TextField(
                    controller: _foodController,
                    decoration: const InputDecoration(
                        labelText: 'Food'
                    ),
                  ),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                        labelText: 'Quantity'
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _peopleController,
                    decoration: const InputDecoration(
                        labelText: 'People'
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text(
                      "Cancel",
                    style: TextStyle(
                      color: Color.fromARGB(255, 100, 162, 93)
                    ),
                  )
              ),
              TextButton(
                  onPressed: (){
                    String name = _nameController.text;
                    String address = _addressController.text;
                    String food = _foodController.text;
                    int quantity = int.tryParse(_quantityController.text) ?? 0;
                    int people = int.parse(_peopleController.text);
                    addDonation(name, address, food, quantity, people);
                    Navigator.pop(context);
                  },
                  child: const Text(
                      "Add",
                    style: TextStyle(
                      color: Color.fromARGB(255, 100, 162, 93)
                    ),
                  )
              ),
            ],
          );
        },
    );
  }

  void showFilterDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))
        ),
        backgroundColor: const Color.fromARGB(255, 238, 255, 236),
        title: const Text(
            "Filter",
          style: TextStyle(
            color: Color.fromARGB(255, 100, 162, 93)
          ),
        ),
        content: Flexible(
          child: Row(
            children: [
              const Text("No. of people : "),
              IconButton(onPressed: (){
                setState(() {
                  decrementRequirement();
                });
              },
                  icon: const Icon(Icons.remove),color: const Color.fromARGB(255, 100, 162, 93),),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: _reqController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    setState(() {
                      _requirement = int.tryParse(value) ?? 0;
                      filterDonations(_requirement);
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: (){
                    setState(() {
                      incrementRequirement();
                    });
                  },
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 100, 162, 93))
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 255, 236),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 238, 255, 236),
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
                          child: Icon(Icons.account_circle_rounded,size: 42,color: Color.fromARGB(255, 238, 255, 236),), backgroundColor: Color.fromARGB(255, 100, 162, 93)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,8.0,18.0,8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 100, 162, 93),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.3,
                          blurRadius: 1,
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
                      color: const Color.fromARGB(255, 100, 162, 93),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black, spreadRadius: 0.3, blurRadius: 1)
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
                      color: const Color.fromARGB(255, 100, 162, 93),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black, spreadRadius: 0.3, blurRadius: 1)
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
                        color: const Color.fromARGB(255, 100, 162, 93),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.3,
                            blurRadius: 1,
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
          title: const Text(
              "FEED",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 100, 162, 93),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              IconButton(
                  onPressed: (){
                    showFilterDialog();
                  },
                  icon: const Icon(Icons.filter_alt_rounded)),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _filteredDonations.length,
                          itemBuilder: (context, index){
                            final donation = _filteredDonations[index];
                            print("Index : $index");
                            print("Inside ListView.builder");
                            print(_donations);
                            print(donation);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DonationTile(name: donation['name'].toString(), address: donation['address'].toString(),food : donation['food'].toString(), quantity: donation['quantity'], people : donation['people']),
                            );

                          }),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 100, 162, 93),
            onPressed: (){
              showAddDonationDialog();
            },
          child: const Icon(Icons.add),
        ),

      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _foodController.dispose();
    _quantityController.dispose();
    _peopleController.dispose();
    super.dispose();
  }
}
