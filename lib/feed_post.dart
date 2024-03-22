import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodaspas/comment.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'constant/color_constant.dart';

class FeedPost extends StatefulWidget {
  const FeedPost({Key? key}) : super(key: key);

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  var feed = FirebaseFirestore.instance.collection("feed");

  List<Map<String, dynamic>> products = [];

  bool isLoading = false;

  final box = GetStorage();

  List<Map<String, dynamic>> feedData = [];

  Future getUser() async {
    setState(() {
      isLoading = true;
    });

    var data = await FirebaseFirestore.instance.collection("feed").get();

    // for (var element in data.docs) {
    //   feedData.add(element.data());
    //   Map<String, dynamic> temp = element.data();
    //
    //   temp.addAll({"product_id": element.id});
    // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.kOrange,
        title: Text(
          "Feed",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
        ),
      ),
      backgroundColor: ColorHelper.kDarkBrown,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 82.h,
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
                            fontSize: 12.sp,
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
                                      .update(
                                          {"save": feedData[index]['save']});
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
                                onPressed: () {},
                                icon: Icon(Icons.send),
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
      ),
    );
  }
}

// class DemoLike extends StatefulWidget {
//   const DemoLike({Key? key}) : super(key: key);
//
//   @override
//   State<DemoLike> createState() => _DemoLikeState();
// }
//
// class _DemoLikeState extends State<DemoLike> {
//   List<Map<String, dynamic>> products = [];
//
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     getData();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   void getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     var data = await FirebaseFirestore.instance.collection("demo").get();
//     for (var element in data.docs) {
//       Map<String, dynamic> temp = element.data();
//
//       temp.addAll({"product_id": element.id});
//
//       products.add(temp);
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ListView.builder(
//               itemCount: products.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return IconButton(
//                   onPressed: () {
//                     if (products[index]['isLike'].contains("A")) {
//                       products[index]['isLike'].remove("A");
//
//                       print('REMOVE');
//                     } else {
//                       products[index]['isLike'].add('A');
//                       print('Add');
//                     }
//
//                     // products[index]['isLike'] =
//                     //     !products[index]['isLike'];
//                     setState(() {});
//
//                     FirebaseFirestore.instance
//                         .collection("demo")
//                         .doc("${products[index]['product_id']}")
//                         .update({"isLike": products[index]['isLike']});
//                   },
//                   icon: products[index]['isLike'].contains("A")
//                       ? Icon(
//                     Icons.favorite,
//                     size: 50,
//                     color: Colors.red,
//                   )
//                       : Icon(Icons.favorite_border, size: 50),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
