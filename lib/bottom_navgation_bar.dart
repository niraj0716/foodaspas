import 'package:flutter/material.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:foodaspas/user_profile.dart';
import 'package:sizer/sizer.dart';
import 'business_listing.dart';
import 'feed_post.dart';

class BottomNavgationBar extends StatefulWidget {
  const BottomNavgationBar({Key? key}) : super(key: key);

  @override
  State<BottomNavgationBar> createState() => _BottomNavgationBarState();
}

class _BottomNavgationBarState extends State<BottomNavgationBar> {
  int select = 0;

  List<Widget> screens = [
    FeedPost(),
    BusinessListingPage(),
    UserProfile(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(
            () {
              select = value;
            },
          );
        },
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        selectedFontSize: 14.sp,
        unselectedItemColor: ColorHelper.kOrange,
        selectedItemColor: ColorHelper.kWhite,
        type: BottomNavigationBarType.fixed,
        currentIndex: select,
        backgroundColor: ColorHelper.kBrown,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lunch_dining),
            label: "Food",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: screens[select],
    );
  }
}
