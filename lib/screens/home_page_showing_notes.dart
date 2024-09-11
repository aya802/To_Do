import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interview1/helper/database.dart';
import 'package:interview1/screens/edit_note.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataBaseHelper sqlDb = DataBaseHelper();
  List notes = [];
  bool isLoading = true;

  Future myReadData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    myReadData();
    super.initState();
    //كل ما نفتح الصفحه دي هتشتغل
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context,'addnote');
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(child: Text('Loading ...'))
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                      itemCount: notes.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: ListTile(
                              title: Text('${notes[i]['title']}'),
                              subtitle: Text('${notes[i]['description']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        int response = await sqlDb.deleteData(
                                            " DELETE FROM notes WHERE  id = ${notes[i]['id']} ");
                                        //للحذف من قاعدة البيانات
                                        if (response > 0) {
                                          notes.removeWhere((elemnt) =>
                                              elemnt['id'] == notes[i]['id']);
                                          setState(() {});
                                          //للحذف من ال UI
                                        }
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.deepPurple[300],
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => EditNote(
                                                      id: notes[i]['id'],
                                                      oldDeadline: notes[i]['deadline'],
                                                      oldDescription: notes[i]['description'],
                                                      oldTitle: notes[i]['title'],
                                                    )));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.deepPurple[300],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
    );
  }
}
