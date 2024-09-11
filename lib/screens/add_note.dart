import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview1/helper/database.dart';
import 'package:interview1/screens/home_page_showing_notes.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  DataBaseHelper sqlDb = DataBaseHelper();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController title= TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController deadline = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        deadline.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(
            children: [
              Form(
                  key: formState,
                  child: Column(
                    children: [
                      SizedBox(height: 60,),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(hintText: 'Add title',hintStyle: TextStyle(color: Colors.grey[600])),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 60,),
                      TextFormField(
                        controller: description,
                        decoration: InputDecoration(hintText: 'Add description',hintStyle: TextStyle(color: Colors.grey[600])),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 60,),
                      TextFormField(
                        controller: deadline,
                        decoration: InputDecoration(hintText: 'Add deadline',hintStyle: TextStyle(color: Colors.grey[600])),
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 60,
                      ),
                      MaterialButton(
                          color: Colors.deepPurple[300],
                          textColor: Colors.white,
                          child: Text('Save'),
                          onPressed: () async {

                            if (formState.currentState!.validate()){
                           int    response = await sqlDb.insertData('''
                           INSERT INTO notes  ( 'title', 'description', 'deadline')
                           VALUES ("${title.text}","${description.text}","${deadline.text}")
                           ''');
                           if (response > 0) {
                             Navigator.of(context).pushAndRemoveUntil(
                               MaterialPageRoute(builder: (context) => Home()),
                                   (route) => false,
                             );

                           }
                            }



                            }
                          ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
