import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class freeComponent_viewpage extends StatefulWidget {
  const freeComponent_viewpage({Key? key}) : super(key: key);

  @override
  State<freeComponent_viewpage> createState() => freeComponentviewpageState();
}

class freeComponentviewpageState extends State<freeComponent_viewpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 25),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 10),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Apart').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 130,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text("test"),
                        ],
                      )),
                ));
            }),
      ],
    );
  }
}
