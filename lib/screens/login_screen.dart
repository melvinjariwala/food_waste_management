// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_waste_management/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

enum MobileVerificationState {
  // ignore: constant_identifier_names
  SHOW_MOBILE_FORM_STATE,
  // ignore: constant_identifier_names
  SHOW_OTP_FORM_STATE,
}

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  MobileVerificationState currentstate =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  late String verificationId;
  bool showLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const dash()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? '')));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white30,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(21.0)),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 100, 162, 93)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(21.0)),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 100, 162, 93)),
                ),
                labelText: 'Enter Phone No.',
                labelStyle: TextStyle(color: Color.fromARGB(255, 100, 162, 93)),
                hintText: '+919876543210',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21.0),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 100, 162, 93)),
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });

                  await _auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Verification Failed")));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentstate =
                              MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {});
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Verify your Phone No.',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Pinput(
            length: 6,
            controller: otpController,
            showCursor: true,
            // ignore: avoid_print
            onCompleted: (pin) => print(pin),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 100, 162, 93)),
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otpController.text);
                signInWithPhoneAuthCredential(phoneAuthCredential);
                currentstate = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
              },
              child: const Text(
                "Verify",
                style: TextStyle(color: Colors.white),
              )),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 100, 162, 93)),
          onPressed: () {
            currentstate = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
          },
          child: const Text(
            "Change Phone No.",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final PinTheme defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(40, 87, 30, 1.0),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 119, 220, 102),
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "Welcome to FEED",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 100, 162, 93),
        ),
        body: Container(
          child: showLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 100, 162, 93),
                  ),
                )
              : currentstate == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(8.0),
          color: const Color.fromARGB(255, 238, 255, 236),
        ));
  }
}
