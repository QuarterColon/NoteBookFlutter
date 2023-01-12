import 'package:flutter/material.dart';
import 'package:learning_dart/Services/auth/auth_service.dart';
import 'package:learning_dart/Services/cloud/firebase_cloud_storage.dart';
import 'package:learning_dart/utilities/Generics/get_arguments.dart';
import '../../Services/cloud/cloud_note.dart';

class CreateOrUpdateNoteView extends StatefulWidget {
  const CreateOrUpdateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateOrUpdateNoteView> createState() => _CreateOrUpdateNoteViewState();
}

class _CreateOrUpdateNoteViewState extends State<CreateOrUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesService.update(
        documentId: note.documentId,
        text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {

    final widgetNote = context.getArgument<CloudNote>();

    if(widgetNote != null){
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null){
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveIfTextIsNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (text.isNotEmpty && note != null){
      _notesService.update(
        documentId: note.documentId,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveIfTextIsNotEmpty();
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('New Note'),
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done :
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Start typing your note...",
                ),
              );
            default :
              return const CircularProgressIndicator();
          }
        }
      )
    );
  }
}
