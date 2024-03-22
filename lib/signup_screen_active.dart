import 'dart:async';

import 'package:custom_otp_textfield/custom_otp_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sizer/sizer.dart';

import 'Constant/color_constant.dart';
import 'User_Profile.dart';
import 'bottom_navgation_bar.dart';
import 'constant/common_button_constant.dart';

class SignupScreenActive extends StatefulWidget {
  const SignupScreenActive(
      {Key? key, this.verfication, this.token, this.mobile})
      : super(key: key);
  final String? verfication;
  final int? token;
  final String? mobile;

  @override
  State<SignupScreenActive> createState() => _SignupScreenActiveState();
}

class _SignupScreenActiveState extends State<SignupScreenActive> {
  int second = 30;
  final box = GetStorage();
  void time() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      second--;
      setState(() {
        if (second == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    time();
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController sms = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.kBlack,
      body: Center(
        child: Container(
          width: 90.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: Color(0xff86848F),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login/Signup",
                style: TextStyle(
                  color: ColorHelper.kWhite,
                  fontSize: 25.sp,
                ),
              ),
              SizedBox(height: 1.h),
              CustomOTPTextField(
                deviceWidth: MediaQuery.of(context).size.width,
                textEditingController: sms, spaceBetweenTextFields: 0.h,
                boxSize: 50,
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColorHelper.kOrange, width: 2),
                ),
                cursorColor: ColorHelper.kOrange,
                otpLength: 6,
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: ColorHelper.kBlack,
                ),
                // spaceBetweenTextFields: width * 0.04,
                cursorHeight: 25,
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Resend code in",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorHelper.kBlack,
                    ),
                  ),
                  Text(
                    " ${second}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: ColorHelper.kOrange,
                    ),
                  ),
                  Text(
                    " second",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorHelper.kBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.h,
              ),
              CommonButtom(
                onpress: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verfication!, smsCode: sms.text);

                  UserCredential user =
                      await auth.signInWithCredential(credential);

                  await box.write("uid", user.user!.uid);
                  print('USERID: ${user.user!.uid}');
                  print('USERID: ${user.user!.phoneNumber}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavgationBar(),
                    ),
                  );
                },
                height: 5.h,
                width: 75.w,
                color: ColorHelper.kOrange,
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 15.sp,
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
