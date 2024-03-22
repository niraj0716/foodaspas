import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodaspas/Constant/color_constant.dart';
import 'package:sizer/sizer.dart';

class Comment extends StatefulWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  var comments = FirebaseFirestore.instance.collection("comment");

  List<Map<String, dynamic>> commentsData = [];

  Future getUser() async {
    setState(() {});

    var data = await comments.get();

    for (var element in data.docs) {
      commentsData.add(element.data());
    }

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  TextEditingController comment = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("comment");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.kBlack,
        centerTitle: true,
        title: Text(
          "Comment",
          style: TextStyle(color: ColorHelper.kOrange),
        ),
      ),
      // backgroundColor: ColorHelper.KBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: comment,
                decoration: InputDecoration(
                    hintText: "Comment",
                    focusColor: ColorHelper.kOrange,
                    fillColor: ColorHelper.kOrange,
                    constraints: BoxConstraints(
                      maxWidth: 90.w,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        users.add({"comment": comment.text});
                        ClearSelectionEvent();
                      },
                      icon: Icon(
                        Icons.send,
                      ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: commentsData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                              color: ColorHelper.kGrey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${commentsData[index]["comment"]}",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
