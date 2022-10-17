import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/res/colors.dart';
import 'package:note_app/views/login_view.dart';

import 'note_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isLoading = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width * 0.75,
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.headline1!.color,
              borderRadius: const BorderRadius.all(
                Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 55,
                  child:  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        "assets/images/login.gif"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gapPadding: 20,
                        borderSide: BorderSide(width: 50)),
                    prefixIcon: Icon(Icons.person),
                    label: Text("Username"),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gapPadding: 20,
                        borderSide: BorderSide(width: 50)),
                    prefixIcon: Icon(Icons.email),
                    label: Text("Email"),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gapPadding: 20,
                        borderSide: BorderSide(width: 50)),
                    prefixIcon: Icon(Icons.lock),
                    label: Text("Password"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: isLoading? null: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        FirebaseAuth authObject = FirebaseAuth.instance;
                        UserCredential user =
                            await authObject.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        user.user!.updateDisplayName(_usernameController.text).then((_) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const NoteView()));
                        });
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.message.toString()),
                              );
                            });
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.toString()),
                              );
                            });
                      }finally{setState(() {
                        isLoading = false;
                      });
                    }},
                    child: !isLoading
                        ? const Text(
                            "Sign up",
                          )
                        : const CircularProgressIndicator(
                            color: CustomColors.cardColor,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginView();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
