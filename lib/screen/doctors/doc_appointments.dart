import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class Doc_AppointmentPage extends StatefulWidget {
  final String doctorName = 'Dr. Emily Garcia';
  @override
  _Doc_AppointmentPageState createState() => _Doc_AppointmentPageState();
}

class _Doc_AppointmentPageState extends State<Doc_AppointmentPage> {
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
        print(appointments);
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
          title: const Text(
            'Cancel Appointment',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Itim",
            ),
          ),
          content: const Text(
            'Are you sure you want to cancel this appointment?',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Itim",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
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
              child: const Text(
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Appointment List'),
      ),
      body: appointments.isEmpty
          ? Container(
        height: MediaQuery.of(context).size.height * .7,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/empty.json",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .2),
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
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          if (appointment['name'] != widget.doctorName) {
            return SizedBox
                .shrink(); // Hide appointment for other doctors
          }
          return Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.23,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
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
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                appointment['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Itim",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              appointment['speciality'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Itim",
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Icon(
                            Icons.video_call,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
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
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${appointment['date']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Itim",
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.access_time_filled,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${appointment['time']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Itim",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .07,
                        child: ElevatedButton(
                            onPressed: () =>
                                _showCancelConfirmationDialog(index),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 30,
                            )),
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
