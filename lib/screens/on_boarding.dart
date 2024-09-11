

import 'package:flutter/material.dart';

import 'home_page_showing_notes.dart';

class OnBoarding extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/img/mo1.png',
              //  height: ,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Text("Set Your Goals",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.indigo[900],)),
          Padding(
            padding: const EdgeInsets.only(left:50,right: 10),
            child: Text("Organize your tasks and boost your productivity with ToDoApp.",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black38,)),
          ),
            SizedBox(
              height: 100,
            ),
     Container(
       width: 70,

       decoration: BoxDecoration(
         color: Colors.indigo[100],
        borderRadius: BorderRadius.circular(20)
       ),

       child: IconButton(onPressed:(){
         Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(builder: (context) => Home()),
         (route) => false,
         );
       }, icon:Icon(Icons.arrow_forward_rounded,size: 30,)),
     )
          ],
        ),
      ),
    );
  }

}