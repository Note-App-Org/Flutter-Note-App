import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/view_model/note_view_model.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/register_view.dart';
import 'package:provider/provider.dart';
import 'res/colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NoteViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteViewModel>(
      builder: (BuildContext context, NoteViewModel provider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Note App',
          themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            canvasColor: CustomColors.backgroundLightColor,
            cardColor: CustomColors.cardColor,
            cardTheme: const CardTheme(shadowColor: Colors.black),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: CustomColors.primaryColor,
            ),
            textTheme: const TextTheme(
              headline1: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              headline2: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              headline3: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              headline4: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              headline5: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 15.0,
              ),
            ),
          ),
          darkTheme: ThemeData(
            canvasColor: CustomColors.backgroundDarkColor,
            cardColor: CustomColors.cardColor,
            cardTheme: const CardTheme(shadowColor: Colors.white54),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: CustomColors.primaryColor,
            ),
            textTheme:const  TextTheme(
              headline1: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              headline2: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              headline3: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              headline4: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              headline5: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 15.0,
              ),
            ),
          ),
          home: const LoginView(),
        );
      },
    );
  }
}
