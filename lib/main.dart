import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/view_model/note_view_model.dart';
import 'package:note_app/views/note_view.dart';
import 'package:provider/provider.dart';
import 'res/colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // TODO : navigate to home page
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteViewModel>(builder: (BuildContext context, NoteViewModel provider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          canvasColor: CustomColors.backgroundLightColor,
          cardColor: CustomColors.cardColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: CustomColors.primaryColor,
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,fontSize: 24.0,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 20.0,
            ),
            headline3: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        darkTheme: ThemeData(
          canvasColor: CustomColors.backgroundDarkColor,
          cardColor: CustomColors.cardColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: CustomColors.primaryColor,
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24.0,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 20.0,
            ),
            headline3: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        home: const NoteView(),
      );
    });
  }
}
