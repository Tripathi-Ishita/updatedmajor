import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:major_vcare/screen/doctors/doc_appointments.dart';
import 'package:major_vcare/screen/doctors/patientdetails.dart';
import 'package:major_vcare/screen/doctors/statistics.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  String formattedDate = DateFormat('dd MMM, E').format(DateTime.now());
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          DoctorPage(),
          StatisticsPage(),
          Doc_AppointmentPage()
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.deepPurpleAccent,
        color: Color(0xff7700e5),
        height: 65,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            Icons.stacked_bar_chart,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            Icons.person_search,
            size: 35,
            color: Colors.white,
          )
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
    );
  }
}

class DoctorPage extends StatefulWidget {
  final String doctorName = 'Dr. Emily Garcia';
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  String formattedDate = DateFormat('dd MMM, E').format(DateTime.now());
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/appointment_list.json');
      final jsonString = await file.readAsString();
      final List<dynamic> decodedData = jsonDecode(jsonString);
      setState(() {
        appointments = decodedData.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading appointments: $e');
      // Handle error loading appointments
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Good Morning!!!",
                        style: TextStyle(
                            fontFamily: "itim",
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontFamily: "itim",
                              fontSize: 17,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin:
                    EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                    height: MediaQuery.of(context).size.height * .235,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff7700e5), Color(0xffc591fd)],
                          stops: [0, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(70),
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Dr. Emily Garcia",
                                    style: TextStyle(
                                        fontFamily: "itim",
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  "Psychiatrist, (M.B.B.S, M.D)",
                                  style: TextStyle(
                                      fontFamily: "itim",
                                      fontSize: 15,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("assets/doc.png"),
                            )
                          ],
                        ),
        
                      ],
        
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatisticsPage()));
                    },
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Material(
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20)),
                          elevation: 1,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .2,
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    Text(
                                      "Appointment Statistics",
                                      style: TextStyle(
                                          color: Color(0xff7700e5),
                                          fontFamily: "itim",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Know your statistics here !!!",
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontFamily: "itim",
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Image(
                              image: AssetImage("assets/stats.png"),
                              height: MediaQuery.of(context).size.height * .15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Text(
                    "Today's Appointments",
                    style: TextStyle(
                        fontFamily: "itim",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: appointments.isEmpty
                    ? Container(
                  height: MediaQuery.of(context).size.height*.2,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/empty.json",
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * .15),
                        Text(
                          'No appointments booked.',
                          style: TextStyle(
                            fontFamily: "Itim",
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1),
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      if (appointment['name'] != widget.doctorName) {
                        return SizedBox
                            .shrink(); // Hide appointment for other doctors
                      }
                      return Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [Color(0xff7700e5), Color(0xffc591fd)],
                            stops: [0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/doc.png"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        appointment['name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Itim",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "$formattedDate, $formattedTime",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: "Itim"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          backgroundColor: Color(0xffc086f8)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientDetails()));
                                      },
                                      child: Text(
                                        "See Details",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: "Itim"),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
