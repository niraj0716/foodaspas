import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:foodaspas/comment.dart';
import 'package:foodaspas/login_singup_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sizer/sizer.dart';

import 'constant/common_button_constant.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var feed = FirebaseFirestore.instance.collection("feed");

  List<Map<String, dynamic>> products = [];

  bool isLoading = false;

  final box = GetStorage();

  List<Map<String, dynamic>> feedData = [];

  Future getUser() async {
    setState(() {
      isLoading = true;
    });

    var data = await FirebaseFirestore.instance
        .collection("feed")
        .where("save", arrayContains: box.read("uid"))
        .get();

    for (var element in data.docs) {
      Map<String, dynamic> temp = element.data();

      temp.addAll({"product_id": element.id});

      feedData.add(temp);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // getData();
    getUser();
    // TODO: implement initState
    super.initState();
  }

  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.kDarkBrown,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: ColorHelper.kOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        height: 20.h,
                        width: 30.w,
                        child: _image == null
                            ? Center(
                                child: CommonButtom(
                                  child: Text(' tap to Upload image'),
                                  onpress: _pickImage,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File(_image!.path),
                                ),
                              )),
                  ],
                ),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${box.read("personname")}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: ColorHelper.kWhite,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Location : ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: ColorHelper.kGrey,
                          ),
                        ),
                        Text(
                          "${box.read("location")}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorHelper.kWhite,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Cousine : ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: ColorHelper.kGrey,
                          ),
                        ),
                        Text(
                          "${box.read("itemname")}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorHelper.kWhite,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Phone No : ",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ColorHelper.kGrey,
                          ),
                        ),
                        Text(
                          "${box.read("phone")}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorHelper.kWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: ColorHelper.kWhite,
            ),
            //box.read("phone") == null
            CommonButtom(
              color: ColorHelper.kDarkBrown,
              child: Text(
                "login to see",
                style: TextStyle(fontSize: 20.sp, color: ColorHelper.kWhite),
              ),
              onpress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginSignupScreen(),
                    ));
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: feedData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "${feedData[index]["images"]}",
                        height: 47.h,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        height: 6.h,
                        color: ColorHelper.kBrown,
                        child: Row(
                          children: [
                            Text(
                              "${feedData[index]["name"]}",
                              // "Malvani katta",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: ColorHelper.kWhite,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.insert_link,
                              color: ColorHelper.kWhite,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "${feedData[index]["description"]}",
                        style: TextStyle(
                          color: ColorHelper.kWhite,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: ColorHelper.kOrange,
                          boxShadow: [
                            BoxShadow(
                              color: ColorHelper.kDarkBrown,
                              blurRadius: 2,
                              spreadRadius: 4.3,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (feedData[index]['fav']
                                    .contains("${box.read("uid")}")) {
                                  feedData[index]['fav']
                                      .remove("${box.read("uid")}");

                                  print('REMOVE');
                                } else {
                                  feedData[index]['fav']
                                      .add('${box.read("uid")}');
                                  print('Add');
                                }

                                // products[index]['isLike'] =
                                //     !products[index]['isLike'];
                                setState(() {});

                                FirebaseFirestore.instance
                                    .collection("feed")
                                    .doc("${feedData[index]['product_id']}")
                                    .update({"fav": feedData[index]['fav']});
                              },
                              icon: feedData[index]['fav']
                                      .contains("${box.read("uid")}")
                                  ? Icon(
                                      Icons.favorite,
                                      size: 20.sp,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.favorite_border, size: 20.sp),
                            ),
                            IconButton(
                              onPressed: () {
                                if (feedData[index]['save']
                                    .contains("${box.read("uid")}")) {
                                  feedData[index]['save']
                                      .remove("${box.read("uid")}");

                                  print('REMOVE');
                                } else {
                                  feedData[index]['save']
                                      .add('${box.read("uid")}');
                                  print('Add');
                                }

                                // products[index]['isLike'] =
                                //     !products[index]['isLike'];
                                setState(() {});

                                FirebaseFirestore.instance
                                    .collection("feed")
                                    .doc("${feedData[index]['product_id']}")
                                    .update({"save": feedData[index]['save']});
                              },
                              icon: feedData[index]['save']
                                      .contains("${box.read("uid")}")
                                  ? Icon(
                                      Icons.bookmark,
                                      size: 20.sp,
                                      color: Colors.blue,
                                    )
                                  : Icon(Icons.bookmark_border, size: 20.sp),
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {},
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Comment(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.comment),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
