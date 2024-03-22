import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'Constant/color_constant.dart';
import 'bottom_navgation_bar.dart';
import 'constant/common_button_constant.dart';

class OnbordingScreen3 extends StatefulWidget {
  const OnbordingScreen3({Key? key}) : super(key: key);

  @override
  State<OnbordingScreen3> createState() => _OnbordingScreen3State();
}

class _OnbordingScreen3State extends State<OnbordingScreen3> {
  final box = GetStorage();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.kBlack,
      body: Center(
        child: Container(
          width: 80.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: Color(0xff86848F),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your name",
                style: TextStyle(
                  color: ColorHelper.kWhite,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  constraints: BoxConstraints(
                    maxHeight: 10.h,
                    maxWidth: 60.w,
                  ),
                  hintText: "First Name",
                  fillColor: ColorHelper.kOrange,
                ),
              ),
              SizedBox(height: 2.h),
              CommonButtom(
                onpress: () async {
                  await box.write("personname", name.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavgationBar(),
                    ),
                  );
                },
                height: 4.h,
                width: 55.w,
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
