import 'package:flutter/material.dart';

class Continuing extends StatefulWidget {
  const Continuing({super.key});

  @override
  State<Continuing> createState() => _ContinuingState();
}

class _ContinuingState extends State<Continuing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 50.0, left: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff348ef2), Color(0xff4183f1), Color(0xff5177ee)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
