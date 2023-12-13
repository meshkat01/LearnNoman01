import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp_getx/AllText/alltext.dart';
import 'package:myapp_getx/Control/note_controlar.dart';
import 'package:myapp_getx/Model/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  Color selectColor= Colors.redAccent;

  TextEditingController idfiled=TextEditingController();

  TextEditingController namefiled=TextEditingController();

  TextEditingController departmentfiled=TextEditingController();

  NoteController noteController=Get.put(NoteController(),);

  final Box box=Hive.box("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back,color: Colors.white,),
          title: Text("My Getx Design",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: selectColor,
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDilogue(context);
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: selectColor,
      ),

      body: GetBuilder<NoteController>(builder: (_){

        return ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, box, child) {
            return ListView.builder(
              shrinkWrap: true,
                itemCount: box.keys.length,
                itemBuilder: (context, index){

                NoteModel note=box.getAt(index);

                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),

                    ),
                  ),
                  child: ListTile(
                    leading: Text(note.id),
                    title: Text(note.name),
                    subtitle: Text(note.department),
                    trailing: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                                _showUpdateDialogue(context, index);
                            },
                            child: Icon(Icons.edit),
                          ),
                          InkWell(
                            onTap: (){
  noteController.deletNote(index);
                            },
                            child: Icon(Icons.delete),
                          ),
                        ],
                      ),

                    ),
                  ),
                );
            });
          }
        );
      },),

    );
  }


  _showUpdateDialogue (BuildContext context, int index){
    return showDialog(context: context, builder: (_){
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: MyText.noteIdText,
                  ),
                  controller: idfiled,
                ),
                SizedBox(height: 10.0,),
                TextField(
                  decoration: InputDecoration(
                    hintText: MyText.noteNameText,
                  ),
                  controller: namefiled,
                ),
                SizedBox(height: 10.0,),
                TextField(
                  decoration: InputDecoration(
                    hintText: MyText.noteDepartmentText,
                  ),
                  controller: departmentfiled,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectColor,
                ),
              ),
              ElevatedButton(onPressed: (){
                noteController.updateNote(NoteModel(
                    idfiled.text, namefiled.text, departmentfiled.text), index );
                Navigator.pop(context);
              }, child: Text("Update",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
              ),
            ],
          ),
        ),
      );
    });

  }

  _showDilogue (BuildContext context){
    return showDialog(context: context, builder: (_){
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: [
               TextField(
                 decoration: InputDecoration(
                   hintText: MyText.noteIdText,
                 ),
                 controller: idfiled,
               ),
                SizedBox(height: 10.0,),
                TextField(
                  decoration: InputDecoration(
                    hintText: MyText.noteNameText,
                  ),
                  controller: namefiled,
                ),
                SizedBox(height: 10.0,),
                TextField(
                  decoration: InputDecoration(
                    hintText: MyText.noteDepartmentText,
                  ),
                  controller: departmentfiled,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: selectColor,
              ),
              ),
              ElevatedButton(onPressed: (){
                noteController.createNote(NoteModel(
                    idfiled.text, namefiled.text, departmentfiled.text
                ), );
                Navigator.pop(context);
              }, child: Text("Submit",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
              ),
            ],
          ),
        ),
      );
    });

  }
}
