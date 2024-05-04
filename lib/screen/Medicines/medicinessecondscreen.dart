import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

import 'medicinereminder.dart';

class Medicines extends StatefulWidget {
  Medicines({super.key});

  @override
  State<Medicines> createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                color: Colors.purple[100],
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Drug\n Cabinet",
                          style: TextStyle(
                              fontFamily: "Itim",
                              fontSize: 40,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Reminder()));
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.63,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Activities",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "itim",
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[900],
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            Row(
                              // add image here
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  image: AssetImage("assets/med.png"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lisinopril",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Itim",
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "180 mg,1 Capsule",
                                      style: TextStyle(
                                          fontFamily: "Itim",
                                          fontSize: 15,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Text(
                                      "After Breakfast",
                                      style: TextStyle(
                                          fontFamily: "Itim",
                                          fontSize: 18,
                                          color: Colors.white70),
                                    )
                                  ],
                                ),
                                Icon(

                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Divider(
                              color: Colors.white70,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "X  Skip",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Itim",
                                      color: Colors.white70),
                                ),
                                Text(
                                  "Y  Done",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Itim",
                                      color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1, color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          // add image here
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              height: MediaQuery.of(context).size.height * 0.08,
                              image: AssetImage("assets/pills2.png"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gabapentin",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Itim",
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                Text(
                                  "25 mg,2 Pills",
                                  style: TextStyle(
                                      fontFamily: "Itim",
                                      fontSize: 15,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.black,
                              size: 30,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}







//



