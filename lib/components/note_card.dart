import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.title, required this.content}) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 16.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: Theme.of(context).textTheme.headline2,),
            Text(
              content,
            maxLines: 10,
              overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
