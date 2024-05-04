import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:major_vcare/screen/Medicines/medicinereminder.dart';

import 'medicinessecondscreen.dart';
class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () {Navigator.push(context,
        MaterialPageRoute(builder: (context)=>Reminder()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Image(image: AssetImage("assets/medpres.png")),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text("       We take care of \nyour regular medication",style: TextStyle(
                fontSize: 30,
                fontFamily: "Chil",
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Text("Keep yourself and loved ones safe and \n     never forget to take your meds,\n           supplements and vitamins.",style:
              TextStyle(
                  fontSize: 15,
                  fontFamily: "Chil",
                  color: Colors.deepPurple,

              ),),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width*0.17,
            child: ElevatedButton(
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Medicines()));},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple,elevation: 10,),
              child: Text(
              "Get Started",textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Chil",
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),

            ),
          ),
       SizedBox(
         height: MediaQuery.of(context).size.height*0.05,
       ),
       Center(

         child: JumpingDots(
           color: Colors.white,
           radius: 10,
         ),
       )
        ],
      ),
    );
  }
}
