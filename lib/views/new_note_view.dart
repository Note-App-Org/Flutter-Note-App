import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/res/colors.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../view_model/new_note_view_model.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({Key? key, this.note}) : super(key: key);

  final NoteModel? note;

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  late NewNoteViewModel _viewModel;

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late NoteModel? note;

  @override
  void initState() {
    note = widget.note;
    _titleController = TextEditingController(text: note != null ? note!.title : '');
    _contentController = TextEditingController(text: note != null ? note!.content : '');
    _viewModel = NewNoteViewModel();
    super.initState();
  }

  @override
  void dispose() {
    // if (!_viewModel.isSaved) {
    //   if (note == null) {
    //     _viewModel.addNote(
    //       context: context,
    //       title: _titleController.text,
    //       content: _contentController.text,
    //       colorId: 1,
    //       // colorId: Provider.of<NewNoteViewModel>(context,listen: false).currentColorId,
    //     );
    //   } else {
    //     _viewModel.updateNote(
    //       context: context,
    //       title: _titleController.text,
    //       content: _contentController.text,
    //       oldNote: note!,
    //     );
    //   }
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              )),
              onPressed: () async {
                if (note == null) {
                  await _viewModel.addNote(
                    context: context,
                    title: _titleController.text,
                    content: _contentController.text,
                    colorId: Provider.of<NewNoteViewModel>(context, listen: false).currentColorId,
                  );
                } else {
                  await _viewModel.updateNote(
                    context: context,
                    title: _titleController.text,
                    content: _contentController.text,
                    colorId: Provider.of<NewNoteViewModel>(context, listen: false).currentColorId,
                    oldNote: note!,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      body: ExpandableBottomSheet(
        background: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style: Theme.of(context).textTheme.headline4,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: CustomColors.greyColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  style: Theme.of(context).textTheme.headline4,
                  decoration: const InputDecoration(
                    hintText: 'Content',
                    hintStyle: TextStyle(
                      color: CustomColors.greyColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        persistentHeader: note != null
            ? SizedBox(
                width: double.infinity,
                child: Card(
                  // elevation: 16,
                  // height: 40,
                  color: CustomColors.cardColor,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _viewModel.deleteNote(noteId: note!.id!, context: context);
                        },
                        iconSize: 32.0,
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Consumer<NewNoteViewModel>(
                builder: (BuildContext context, NewNoteViewModel provider, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: CustomColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 1; i <= CustomColors.notesColors.values.length; i++)
                              GestureDetector(
                                onTap: () {
                                  provider.setCurrentColorId = i;
                                },
                                child: CircleAvatar(
                                  backgroundColor: CustomColors.notesColors[i],
                                  child: i == provider.currentColorId
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        expandableContent: note != null
            ? Consumer<NewNoteViewModel>(
                builder: (BuildContext context, NewNoteViewModel provider, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: CustomColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 1; i <= CustomColors.notesColors.values.length; i++)
                              GestureDetector(
                                onTap: () {
                                  provider.setCurrentColorId = i;
                                },
                                child: CircleAvatar(
                                  backgroundColor: CustomColors.notesColors[i],
                                  child: i == provider.currentColorId
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(),
      ),
    );
  }
}
