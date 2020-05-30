import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firewebauth/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _controllers;

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  void initState() {
    super.initState();
    _controllers = TextEditingController();
  }

  @override
  void dispose() {
    _controllers.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/wallpaper-login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: _controllers,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'Enter phone number',
                              contentPadding:
                                  EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                              prefixIcon: Icon(Icons.phone),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0))),
                          onChanged: (val) {
                            setState(() {
                              this.phoneNo = val;
                            });
                          },
                        )),
                    SizedBox(height: 20),
                    codeSent
                        ? Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: 'Enter OTP',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      25.0, 20.0, 25.0, 20.0),
                                  prefixIcon: Icon(Icons.sms),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 32.0),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 32.0),
                                      borderRadius:
                                          BorderRadius.circular(25.0))),
                              onChanged: (val) {
                                setState(() {
                                  this.smsCode = val;
                                });
                              },
                            ))
                        : Container(),
                    SizedBox(height: 20),
                    Padding(
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff374ABE),
                                      Color(0xff64B6FF)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                //width: 80,
                                //height: 30,
                                child: Center(
                                    child: codeSent
                                        ? Text('Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Helvetica",
                                                fontSize: 25))
                                        : Text(
                                            'Verify',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Helvetica",
                                                fontSize: 25),
                                          )),
                              ),
                            ),
                            onPressed: () {
                              codeSent
                                  ? AuthService()
                                      .signInWithOTP(smsCode, verificationId)
                                  : verifyPhone(phoneNo);
                            },
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    String phoneNoo = "+91" + phoneNo.toString();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNoo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
