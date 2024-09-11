

import 'package:flutter/material.dart';

import '../helper/database.dart';
import 'home_page_showing_notes.dart';

class EditNote extends StatefulWidget{
  final oldTitle;
  final oldDescription;
  final id ;
  final oldDeadline;

  const EditNote({super.key, this.oldTitle, this.oldDeadline, this.id, this.oldDescription});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  DataBaseHelper sqlDb = DataBaseHelper();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController deadline = TextEditingController();
  @override
  void initState() {
    super.initState();
    title.text=widget.oldTitle;
    //بنخزن القيمه اللي جايه من ال add class =widget.oldnote في القيمه اللي معرفينها هنا بس في شكل note.text
    description.text=widget.oldDescription;
    deadline.text=widget.oldDeadline;


  }
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
        title: const Text('Edit Note',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
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
                        decoration: InputDecoration(hintText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          return null;
                        },
                      ),SizedBox(height: 60,),
                      TextFormField(
                        controller: description,
                        decoration: const InputDecoration(hintText: 'Description',),
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
                        decoration: const InputDecoration(hintText: 'Deadline'),
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
                          child: const Text('Edit Note'),
                          onPressed: () async {
                           if (formState.currentState!.validate()){
                             int response = await sqlDb.updateData('''
                           UPDATE notes SET
                           title = "${title.text}",
                           description ="${description.text}",
                           deadline = "${deadline.text}"
                           WHERE id = ${widget.id}
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