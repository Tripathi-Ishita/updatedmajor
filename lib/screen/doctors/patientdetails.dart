import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  String formattedDate = DateFormat('dd MMM, E').format(DateTime.now());
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    var problem =
    """The patient exhibits a red, itchy rash on the abdomen, likely contact dermatitis from recent exposure to a new detergent. No systemic symptoms reported. Physical examination reveals erythematous, raised patches with scattered vesicles. Treatment includes topical corticosteroids and avoidance of the offending agent. Follow-up scheduled in one week for assessment and management.""";
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/img.png"),
                    )),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * .82,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Alicia Williams",
                        style: TextStyle(
                            fontFamily: "Itim", fontSize: 25, color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Woman,24 y.o.",
                                style: TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Text(
                                "Phone:-223-282-29721",
                                style: TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Text(
                                "SSN: 193 41 3048",
                                style: TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 15,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Blood type: IV+",
                                style: TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Text(
                                "Allergies-None",
                                style: TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Text(
                                "Medications: None",
                                style: TextStyle(
                                    fontFamily: "Itim",
                                    fontSize: 15,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Appointment Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: "Itim"),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.circular(40)),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Date: ',
                                      style: TextStyle(
                                          fontFamily: "itim",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: formattedDate,
                                      style: TextStyle(
                                        fontFamily: "itim",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Date: ',
                                      style: TextStyle(
                                          fontFamily: "itim",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: formattedTime,
                                      style: TextStyle(
                                        fontFamily: "itim",
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .005,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Problem: ',
                                  style: TextStyle(
                                    fontFamily: "itim",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: problem,
                                  style: TextStyle(
                                      fontFamily: "itim",
                                      fontSize: 16,
                                      wordSpacing: 3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .55,
                      height: MediaQuery.of(context).size.height * .06,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Cancel Apointment",
                              style: TextStyle(
                                  fontFamily: "Itim",
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.05,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
            ),
            Positioned(
                top: MediaQuery.of(context).size.width * 0.2,
                left: MediaQuery.of(context).size.width * 0.35,
                child: CircleAvatar(
                  foregroundImage: AssetImage("assets/doc.png"),
                  backgroundColor: Colors.purple[100],
                  maxRadius: 50,
                ))
          ],
        ));
  }
}
