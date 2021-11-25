

import 'package:flutter/material.dart';

class ScaledPersonCard extends StatefulWidget {
   String firstName;
  String lastName;
  String phoneNo;
  String mailId;
  ScaledPersonCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.mailId,
  }) : super(key: key);

  @override
  _ScaledPersonCardState createState() => _ScaledPersonCardState();
}

class _ScaledPersonCardState extends State<ScaledPersonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        elevation: 20,
        margin: EdgeInsets.all(10),
        shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Row(children: [Text(
                          widget.firstName,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          widget.lastName,
                          style: const TextStyle(fontSize: 20),
                        )],),
                    Row(children: [Text(
                          widget.phoneNo,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          widget.mailId,
                          style: const TextStyle(fontSize: 20),
                        )],)
                  ],
                ),
      ),
      
    );
  }
}