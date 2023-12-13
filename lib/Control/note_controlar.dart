

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../Model/note_model.dart';
class NoteController extends GetxController{

  final Box box=Hive.box("notes");

void createNote(NoteModel note){
 box.add(note);
}

void updateNote(NoteModel note, int index){
box.putAt(index, note);
}
void deletNote(int index){
box.deleteAt(index);
}

}