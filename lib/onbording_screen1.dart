import 'package:flutter/material.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:foodaspas/onbording_screen2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class OnbordingScreen1 extends StatefulWidget {
  const OnbordingScreen1({Key? key}) : super(key: key);

  @override
  State<OnbordingScreen1> createState() => _OnbordingScreen1State();
}

class _OnbordingScreen1State extends State<OnbordingScreen1> {
  final box = GetStorage();
  List statename = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
  ];

  String? select;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.kBlack,
      appBar: AppBar(
        title: Text("Foodaspas"),
        backgroundColor: ColorHelper.kBlack,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Your City",
                style: TextStyle(
                  color: ColorHelper.kWhite,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                value: select,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 21.w),
                dropdownColor: ColorHelper.kBlack,
                hint: Text(
                  "Select",
                  style: TextStyle(
                    color: ColorHelper.kOrange,
                  ),
                ),
                items: List.generate(
                  statename.length,
                  (index) => DropdownMenuItem(
                    value: statename[index],
                    child: Text(
                      "${statename[index]}",
                      style: TextStyle(color: ColorHelper.kOrange),
                    ),
                  ),
                ),
                onChanged: (value) async {
                  setState(() {});
                  select = value.toString();
                  await box.write("location", value);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnbordingScreen2(),
                      ));
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Coming to other cities very soon!",
                style: TextStyle(
                  color: ColorHelper.kGrey,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
