import 'package:flutter/material.dart';
import 'package:note_app/res/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../view_model/new_note_view_model.dart';
import '../views/new_note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            child: ChangeNotifierProvider(
              create: (_) => NewNoteViewModel(),
              child: NewNoteView(
                note: note,
              ),
            ),
          ),
        );
      },
      child: Card(
        color: CustomColors.notesColors[note.colorId],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0,top: 4.0),
                child: Text(
                  note.date!.split('T')[0].replaceAll('-', '/'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(height: 16.0,),
              Text(
                note.content!,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
