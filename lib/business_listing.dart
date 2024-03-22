import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:sizer/sizer.dart';

class BusinessListingPage extends StatefulWidget {
  const BusinessListingPage({Key? key}) : super(key: key);

  @override
  State<BusinessListingPage> createState() => _BusinessListingPageState();
}

class _BusinessListingPageState extends State<BusinessListingPage> {
  var businesss = FirebaseFirestore.instance.collection("business");

  List<Map<String, dynamic>> businesssData = [];

  Future getUser() async {
    setState(() {});

    var data = await businesss.get();

    for (var element in data.docs) {
      businesssData.add(element.data());
    }

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Foodjoints in Mumbai",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ),
        backgroundColor: ColorHelper.kOrange,
      ),
      backgroundColor: ColorHelper.kDarkBrown,
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: businesssData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: ColorHelper.kBrown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 29.h,
                            width: 29.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.network(
                              height: 15.h,
                              "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/kadai-paneer-recipe.jpg",
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${businesssData[index]["name"]}",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: ColorHelper.kWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${businesssData[index]["destination"]}",
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    color: ColorHelper.kGrey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later,
                                      color: ColorHelper.kOrange,
                                    ),
                                    Text(
                                      "${businesssData[index]["time"]}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorHelper.kOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: ColorHelper.kOrange,
                                    ),
                                    Text(
                                      "${businesssData[index]["location"]}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorHelper.kOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_food_beverage_sharp,
                                      color: ColorHelper.kGrey,
                                    ),
                                    Icon(
                                      Icons.emoji_food_beverage_sharp,
                                      color: ColorHelper.kGrey,
                                    ),
                                    Icon(
                                      Icons.emoji_food_beverage_sharp,
                                      color: ColorHelper.kGrey,
                                    ),
                                    Icon(
                                      Icons.emoji_food_beverage_sharp,
                                      color: ColorHelper.kGrey,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Container(
                                      height: 3.5.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                        color: ColorHelper.kDarkBrown,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: ColorHelper.kOrange,
                                            size: 20,
                                          ),
                                          Text(
                                            "5",
                                            style: TextStyle(
                                              color: ColorHelper.kOrange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
