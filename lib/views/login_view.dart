import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/res/colors.dart';
import 'package:note_app/views/note_view.dart';
import 'package:note_app/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(35))),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/login.gif"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
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
                  height: 16.0,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 160,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    onPressed: isLoading
                        ? null
                        : () async {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              FirebaseAuth authObject = FirebaseAuth.instance;
                              await authObject
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text, password: _passwordController.text)
                                  .then((_) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const NoteView(),
                                    ));
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
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                    child: !isLoading
                        ? const Text(
                            "Login",
                          )
                        : const CircularProgressIndicator(
                            color: CustomColors.cardColor,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do not have an account? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterView();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
