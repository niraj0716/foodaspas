import 'package:flutter/material.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:foodaspas/onbording_screen3.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class OnbordingScreen2 extends StatefulWidget {
  const OnbordingScreen2({Key? key}) : super(key: key);

  @override
  State<OnbordingScreen2> createState() => _OnbordingScreen2State();
}

class _OnbordingScreen2State extends State<OnbordingScreen2> {
  final box = GetStorage();
  List<String> circle = [
    "assets/images/Group 847 (2).png",
    "assets/images/Group 841 (1).png",
    "assets/images/Group 845 (1).png",
    "assets/images/Group 843 (2).png",
    "assets/images/Group 847 (2).png",
    "assets/images/Group 841 (1).png",
    "assets/images/Group 845 (1).png",
    "assets/images/Group 843 (2).png",
  ];
  List name = [
    "Malwani",
    "Chinese",
    "Kolhapuri",
    "Chinese",
    "Konkani",
    "Malwani",
    "Chinese",
    "Kolhapuri",
  ];
  List padding = [
    EdgeInsets.only(),
    EdgeInsets.only(right: 250),
    EdgeInsets.only(left: 250),
    EdgeInsets.only(),
    EdgeInsets.only(),
    EdgeInsets.only(),
    EdgeInsets.only(right: 250),
    EdgeInsets.only(left: 250),
  ];
  int selectednameIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "foodaspas",
        ),
        backgroundColor: ColorHelper.kBlack,
      ),
      backgroundColor: ColorHelper.kDarkBrown,
      body: ListView.builder(
        itemCount: circle.length,
        itemBuilder: (context, index) {
          return index == 4
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Which",
                      style: TextStyle(
                        color: ColorHelper.kWhite,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      " cuisine ",
                      style: TextStyle(
                        color: ColorHelper.kOrange,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      "you want to see?",
                      style: TextStyle(
                        color: ColorHelper.kWhite,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: padding[index],
                        child: CircleAvatar(
                          radius: 30.sp,
                          backgroundImage: AssetImage(circle[index]),
                        ),
                      ),
                      Padding(
                        padding: padding[index],
                        child: ElevatedButton(
                          onPressed: () async {
                            String itemname = name[selectednameIndex];
                            print('Selected Avatar URL: $itemname');
                            await box.write("itemname", itemname);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnbordingScreen3(),
                              ),
                            );
                          },
                          child: Text(
                            "${name[index]}",
                            style: TextStyle(
                              color: ColorHelper.kWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

          // onTap: () {
          //   setState(() {
          //     selectedAvatarIndex = index;
          //   });

          // tileColor: index == selectedAvatarIndex ? Colors.blue : null,
        },
      ),
    );
  }
}
