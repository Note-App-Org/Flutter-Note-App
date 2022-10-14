import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/components/note_card.dart';
import 'package:note_app/res/colors.dart';
import 'package:note_app/view_model/note_view_model.dart';
import 'package:note_app/views/new_note_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import '../models/note_model.dart';
import '../view_model/new_note_view_model.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NoteViewModel>(context, listen: false).getNotes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteViewModel>(
      builder: (BuildContext context, NoteViewModel provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Notes',
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Transform.scale(
                  scale: 1.5,
                  child: Switch(
                    value: provider.isDark,
                    onChanged: (bool value) {
                      provider.setIsDark = value;
                    },
                    activeThumbImage: const AssetImage('assets/images/dark_mode.png'),
                    inactiveThumbImage: const AssetImage('assets/images/light_mode.png'),
                    activeColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: !provider.isLoading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    children: provider.noteList.map((note) {
                      return NoteCard(
                        note: note,
                      );
                    }).toList(),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomRight,
                  child: ChangeNotifierProvider(
                    create: (_) => NewNoteViewModel(),
                    child:const NewNoteView(),
                  ),
                ),
              );
            },
            backgroundColor: CustomColors.primaryColor,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}