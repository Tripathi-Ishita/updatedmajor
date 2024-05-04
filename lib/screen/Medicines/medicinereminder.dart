import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  DateTime _dateTime=DateTime.now();
  void _showDatePicker(){
    showDatePicker(context: context,
        firstDate:DateTime(2000) ,
        lastDate: DateTime(2025)).then((value){
          setState(() {
            _dateTime=value!;
          });
    });
  }

  TimeOfDay _timeOfDay=TimeOfDay(hour: 8, minute: 30);
  void _showTimePicker(){
    showTimePicker(context: context,
        initialTime: TimeOfDay.now()).then((value) {
          setState(() {
            _timeOfDay=value!;
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.white70,
          child: Image(
            height: MediaQuery.of(context).size.height*0.2,
            image: AssetImage("assets/med3.png"),
          ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height*0.64,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/med4.jpg")
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(40),
              topLeft: Radius.circular(40))

            ),
            child: Column(

              children: [
                TextField(
                  decoration: InputDecoration(
                      filled:true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),
                              topRight: Radius.circular(20))),
                      labelText: "Medicine ",
                      labelStyle: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 17,
                      ),
                      hintText: "Enter the Medicine",
                      hintStyle: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 15,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Dose ",

                      labelStyle: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 17,
                      ),
                      hintText: "Number of Pills(or in unit)",
                      hintStyle: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 15,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Medication Timing",
                      labelStyle: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 17,
                      ),
                      hintText: "Before/After (Breakfast/Lunch/Supper)",
                      hintStyle: TextStyle(
                        fontFamily: "Itim",
                        fontSize: 15,
                      )),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed:_showDatePicker,
                      child: Container(
                        height:MediaQuery.of(context).size.height*0.08,
                        width:MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Choose Date",style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Itim"
                            ),),
                            Icon(Icons.calendar_today)
                          ],
                        ),
                      ),
                    ),
                    Text(DateFormat('dd MMM yyyy, E').format(_dateTime),style: TextStyle(
                      fontFamily: "Itim",
                      fontSize: 15,

                    ),)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(

                  children: [
                    MaterialButton(onPressed:_showTimePicker,
                      child:
                      Container(
                        height:MediaQuery.of(context).size.height*0.08,
                        width:MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Choose Time",style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Itim"
                            ),),
                            Icon(Icons.access_time_filled)
                          ],
                        ),
                      ),),
                    Text(_timeOfDay.format(context).toString(),style: TextStyle(
                      fontFamily: "Itim",
                      fontSize: 20,

                    ),),

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text(
                      "Add Medicine",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Itim",
                        fontSize: 20,
                      ),
                    ),),
                )

              ],
            ),
          )
        ],

      ),
    );
  }
}
