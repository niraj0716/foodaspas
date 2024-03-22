import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  List<Map<String, dynamic>> student = [
    {
      "name": "yash",
      "div": "A",
    },
    {
      "name": "miraj",
      "div": "A",
    },
    {
      "name": "vivek",
      "div": "B",
    },
    {
      "name": "harshil",
      "div": "B",
    },
    {
      "name": "raj",
      "div": "C",
    },
    {
      "name": "abhi",
      "div": "C",
    },
    {
      "name": "Niraj",
      "div": "D",
    },
    {
      "name": "shruti",
      "div": "D",
    },
    {
      "name": "hitt",
      "div": "E",
    },
    {
      "name": "Mahi",
      "div": "E",
    },
  ];
  List<Map<String, dynamic>> divA = [];
  bool loding = false;

  void GetData() {
    setState(() {
      loding = true;
    });

    student.forEach((element) {
      if (element["div"] == "E") {
        divA.add(element);
      }
    });

    setState(() {
      loding = false;
    });
  }

  @override
  void initState() {
    GetData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // int i;
          // for (i = 0; i < student.length; i++) {
          //   if (student[i]["div"] == "A") {
          //     print(student[i]["name"]);
          //   }
          // }
        },
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: loding
                ? CircularProgressIndicator()
                : GridView.builder(
                    itemCount: divA.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "name:${divA[index]["name"]}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "div: ${divA[index]["div"]}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      );
                    },
                  )),
      ),
    );
  }
}
