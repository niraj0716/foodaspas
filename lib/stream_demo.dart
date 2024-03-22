import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamDemo extends StatefulWidget {
  const StreamDemo({Key? key}) : super(key: key);

  @override
  State<StreamDemo> createState() => _StreamDemoState();
}

class _StreamDemoState extends State<StreamDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("feed").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        snapshot.data!.docs[index].data();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data['name']}'),
                          SizedBox(
                            height: 30,
                          ),
                          Text('${data['description']}'),
                          SizedBox(
                            height: 30,
                          ),
                          Image.asset("${data["images"]}"),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Text('No Data');
              }
            },
          ),
        ),
      ),
    );
  }
}
