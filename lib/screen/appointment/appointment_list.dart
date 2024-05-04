import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppointmentListPage extends StatefulWidget {
  @override
  _AppointmentListPageState createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
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

  Future<void> _saveAppointments(
      List<Map<String, dynamic>> appointments) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/appointment_list.json');
      await file.writeAsString(jsonEncode(appointments));
    } catch (e) {
      print('Error saving appointments: $e');
      // Handle error saving appointments
    }
  }

  Future<void> _showCancelConfirmationDialog(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black38,
          title: Text(
            'Cancel Appointment',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Itim",
            ),
          ),
          content: Text(
            'Are you sure you want to cancel this appointment?',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Itim",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Itim",
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Itim",
                ),
              ),
              onPressed: () {
                setState(() {
                  appointments.removeAt(index);
                  _saveAppointments(appointments);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment List'),
      ),
      body: appointments.isEmpty
          ? Center(
              child: Text('No appointments booked.'),
            )
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Container(
                  margin: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage("assets/p.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(appointment['picture']),
                              backgroundColor: Colors.white,
                              radius: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      appointment['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Itim",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    appointment['speciality'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Itim",
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.08,
                            ),

                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.height*0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                 boxShadow: [BoxShadow(
                                   color: Colors.grey,
                                   spreadRadius: 1,
                                   blurRadius: 3
                                 )]
                                ),

                                child: Icon(
                                  Icons.video_call_rounded,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .07,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${appointment['date']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Itim",
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.access_time_filled,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${appointment['time']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Itim",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: ()=>_showCancelConfirmationDialog(index),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.height*0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius: 3
                                    )]
                                ),

                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
