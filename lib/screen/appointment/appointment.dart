import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'appoint.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List<Doctors> dataList = [];

  Future<void> getData() async {
    String jsonString = await rootBundle.loadString('assets/json/cardiologists.json');
    List<dynamic> jsonList = json.decode(jsonString);
    dataList = jsonList.map((json) => Doctors.fromJson(json)).toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 10,
        title: Text(
          "Appointment",
          style:
          TextStyle(color: Colors.white, fontFamily: "Itim", fontSize: 20),
        ),
        backgroundColor: Colors.purple[700],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/h.jpeg"),
              fit: BoxFit.cover,
            )),
        child: dataList.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Appoint(index: index)));
                  },
                  child: Hero(
                    tag: "hero-tag",
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height:
                            MediaQuery.of(context).size.height * 0.23,
                            child: Card(
                              elevation: 15,
                              shadowColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.16,
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                dataList[index].picture),
                                            fit: BoxFit.cover),
                                        color:
                                        Color.fromRGBO(170, 77, 254, 1),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    margin: EdgeInsets.all(20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(3.0),
                                            child: Text(
                                              "${dataList[index].name}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Itim",
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(3.0),
                                            child: Text(
                                              "${dataList[index].hospital}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Itim",
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Appoint(
                                                              index:
                                                              index)));
                                            },
                                            child: Text(
                                              "Get Appointment",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Color.fromRGBO(
                                                    170, 77, 254, 1),
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10))),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Text(
                                                " 4.9   (90 reviews)",
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  fontFamily: "Itim",
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class Appoint extends StatefulWidget {
  final int index;

  const Appoint({Key? key, required this.index}) : super(key: key);

  @override
  State<Appoint> createState() => _AppointState();
}

class _AppointState extends State<Appoint> {
  List<Map<String, dynamic>> jsonDataList = [];
  late String selectedMonth;
  int selectedIndex = 0;
  int selectedIndexHour = 0;
  late List<DateTime> timeSlots;

  // List of month names
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
    selectedMonth = months[DateTime.now().month - 1];
    generateTimeSlots();
  }

  void generateTimeSlots() {
    final DateTime currentTime = DateTime.now();
    final DateTime endTime =
    DateTime(currentTime.year, currentTime.month, currentTime.day, 18, 0);

    timeSlots = [];
    DateTime currentTimeSlot =
    DateTime(currentTime.year, currentTime.month, currentTime.day, 10, 0);

    while (currentTimeSlot.isBefore(endTime)) {
      timeSlots.add(currentTimeSlot);
      currentTimeSlot = currentTimeSlot.add(Duration(hours: 1));
    }
  }

  Future<void> _loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/json/cardiologists.json');
    List<dynamic> decodedData = json.decode(jsonString);
    setState(() {
      jsonDataList = decodedData.cast<Map<String, dynamic>>();
    });
  }

  void bookAppointment() async {
    if (selectedIndex >= 0 &&
        selectedIndex < 8 && // Assuming 8 days are shown in the future
        selectedIndexHour >= 0 &&
        selectedIndexHour < timeSlots.length) {
      final DateTime selectedDate =
      DateTime.now().add(Duration(days: selectedIndex));
      final DateTime selectedTime = timeSlots[selectedIndexHour];

      final Map<String, dynamic> appointment = {
        "name": jsonDataList[widget.index]['name'],
        "picture": jsonDataList[widget.index]['picture'],
        "speciality": jsonDataList[widget.index]['speciality'],
        "date": DateFormat('dd/MM/yyyy').format(selectedDate),
        "time": DateFormat('HH:mm').format(selectedTime),
      };

      final file = await _localFile;
      List<Map<String, dynamic>> appointments = [];
      if (await file.exists()) {
        String contents = await file.readAsString();
        appointments = List<Map<String, dynamic>>.from(json.decode(contents));
      }

      appointments.add(appointment);

      await file.writeAsString(json.encode(appointments));

      print("Appointment booked: $appointment");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black38,
            title: Text("Appointment Scheduled",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Itim",
              ),
            ),
            content: Text("Your appointment has been booked successfully.",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Itim",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Pop twice to go back to previous screen
                },
                child: Text("OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Itim",
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/appointment_list.json');
  }

  @override
  Widget build(BuildContext context) {
    if (jsonDataList.isEmpty ||
        widget.index < 0 ||
        widget.index >= jsonDataList.length) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> jsonData = jsonDataList[widget.index];

    return Scaffold(
      body: Hero(
        tag: "hero-tag",
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromRGBO(119, 0, 229, 1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width * .2,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.deepPurple,
                                  blurRadius: 10,
                                  spreadRadius: 8)
                            ],
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(jsonData['picture']),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        jsonData['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'itim',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        jsonData['speciality'],
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'itim',
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .001,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .3,
                            height: MediaQuery.of(context).size.width * .3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  jsonData['hospital'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'itim',
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .3,
                            height: MediaQuery.of(context).size.width * .3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1257",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'itim',
                                      fontSize: 20),
                                ),
                                Text(
                                  "Happy\nPatient",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'itim',
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .3,
                            height: MediaQuery.of(context).size.width * .3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      "  4.3",
                                      style: TextStyle(
                                          fontFamily: "itim",
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Patient \nRatings",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'itim',
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            Positioned(
                top: 30,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Positioned(
                top: 30,
                bottom: 10,
                right: 20,
                child: Text(
                  "Details",
                  style: TextStyle(
                      color: Colors.white, fontSize: 17, fontFamily: "itim"),
                )),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontFamily: "itim"),
                            ),
                            DropdownButton<String>(
                              value: selectedMonth,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: "itim"),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMonth = newValue!;
                                });
                              },
                              items: months.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                            8, // Set the number of days to show in the future
                            itemBuilder: (context, index) {
                              final currentDate =
                              DateTime.now().add(Duration(days: index));
                              final isSelected = index ==
                                  selectedIndex; // Assuming the first date is selected

                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                    // Handle date selection
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.transparent,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          DateFormat('E').format(
                                              currentDate), // Day of the week (e.g., Mon)
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          DateFormat('d').format(
                                              currentDate), // Day of the month (e.g., 1)
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Time",
                              style: TextStyle(
                                  fontFamily: "itim",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                        Expanded(
                            flex: 3,
                            child: GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 3),
                              itemCount: timeSlots.length,
                              itemBuilder: (context, index) {
                                final currentTimeSlot = timeSlots[index];
                                final isSelected = index ==
                                    selectedIndexHour; // Add your logic here to determine if it's selected

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndexHour = index;
                                    });
                                    // Handle time slot selection here
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                      color: isSelected
                                          ? Colors.blue[50]
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      DateFormat('hh:mm a')
                                          .format(currentTimeSlot),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: isSelected
                                            ? FontWeight.w500
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total: \$96",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "itim",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .07,
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow),
                                    onPressed: bookAppointment,
                                    child: Text(
                                      "Book Appointment",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "itim",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
