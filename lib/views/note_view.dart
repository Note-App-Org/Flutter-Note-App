import 'package:flutter/material.dart';
import 'package:note_app/components/note_card.dart';
import 'package:note_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Provider.of<NoteViewModel>(context,listen: false).getNotes();
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
             builder: (BuildContext context,snapshot){
               return StaggeredGrid.count(
                 crossAxisCount: 2,
                 mainAxisSpacing: 8.0,
                 crossAxisSpacing: 8.0,
                 children: [
                   NoteCard(
                     title: "Title 1",
                     content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   ), NoteCard(
                     title: "Title 1",
                     content: " like Aldus PageMaker including versions of Lorem Ipsum.",
                   ), NoteCard(
                     title: "Title 1",
                     content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                   ),
                   NoteCard(
                     title: "Title 1",
                     content: " like Aldus PageMaker including versions of Lorem Ipsum.",
                   ),
                 ],
               );
             },
            ),
          ),
        );
      },
    );
  }
}
