import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoLike extends StatefulWidget {
  const DemoLike({Key? key}) : super(key: key);

  @override
  State<DemoLike> createState() => _DemoLikeState();
}

class _DemoLikeState extends State<DemoLike> {
  List<Map<String, dynamic>> products = [];

  bool isLoading = false;

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    var data = await FirebaseFirestore.instance.collection("demo").get();
    for (var element in data.docs) {
      Map<String, dynamic> temp = element.data();

      temp.addAll({"product_id": element.id});

      products.add(temp);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return IconButton(
                        onPressed: () {
                          if (products[index]['isLike'].contains("A")) {
                            products[index]['isLike'].remove("A");

                            print('REMOVE');
                          } else {
                            products[index]['isLike'].add('A');
                            print('Add');
                          }

                          // products[index]['isLike'] =
                          //     !products[index]['isLike'];
                          setState(() {});

                          FirebaseFirestore.instance
                              .collection("demo")
                              .doc("${products[index]['product_id']}")
                              .update({"isLike": products[index]['isLike']});
                        },
                        icon: products[index]['isLike'].contains("A")
                            ? Icon(
                                Icons.favorite,
                                size: 50,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border, size: 50),
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}
