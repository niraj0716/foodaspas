import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:foodaspas/signup_screen_active.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'constant/common_button_constant.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final box = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.kBlack,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: Color(0xff86848F),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 7.sp),
                      Text(
                        "Login/Signup",
                        style: TextStyle(
                          color: ColorHelper.kWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 7.sp),
                      TextField(
                        controller: phone,
                        decoration: InputDecoration(
                          // prefixIcon: CountryCodePicker(
                          //   onChanged: print,
                          //   initialSelection: 'IT',
                          //   favorite: ['+39', 'FR'],
                          //   showCountryOnly: false,
                          //   showOnlyCountryWhenClosed: false,
                          //   alignLeft: false,
                          // ),
                          hintText: "Mobile Number",
                          constraints: BoxConstraints(
                            maxWidth: 300,
                            maxHeight: 60,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.sp),
                      CommonButtom(
                        onpress: () {
                          auth.verifyPhoneNumber(
                            phoneNumber: phone.text,
                            verificationCompleted: (phoneAuthCredential) {
                              print('DONE');
                            },
                            verificationFailed: (error) {
                              print('ERROR');
                            },
                            codeSent:
                                (verificationId, forceResendingToken) async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreenActive(
                                      verfication: verificationId,
                                      token: forceResendingToken,
                                      mobile: phone.text,
                                    ),
                                  ));
                              await box.write("phone", phone.text);
                            },
                            codeAutoRetrievalTimeout: (verificationId) {
                              print('TIMEOUT');
                            },
                          );
                        },
                        height: 4.h,
                        width: 55.w,
                        color: ColorHelper.kOrange,
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
