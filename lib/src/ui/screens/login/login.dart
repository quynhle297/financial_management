import 'package:financial_management/src/ui/screens/dashboard/home.dart';
import 'package:financial_management/src/ui/screens/common/strings.dart';
import 'package:financial_management/src/ui/screens/common/checkbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool isLogin = true;
  String title = Strings.login;
  String hint = Strings.signupHint;
  String textButton = Strings.register;
  String errorMessage = "";
  // firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void updateErrorMessage(String error) {
    setState(() {
      errorMessage = error;
    });
  }

  Future<void> _register() async {
    checkFirebaseAuth();
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      // send verification mail
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        updateErrorMessage('Verified email sent. Please check your mail box');
      }
    } on FirebaseAuthException catch (e) {
      updateErrorMessage('Register failed: ${e.message} e = $e code ${e.code}');
    } catch (e) {
      updateErrorMessage('Undefine error: $e');
    }
  }

  void checkFirebaseAuth() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      debugPrint(user == null
          ? "Chưa có người dùng nào đăng nhập"
          : "Đã có người dùng đăng nhập");
    } catch (e) {
      debugPrint("Lỗi Firebase Auth: $e");
    }
  }

  void navigateToMainScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // check whether email verify or not
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        navigateToMainScreen();
      } else {
        updateErrorMessage(
            'Email has not verified yet. Please check you mail box.');
      }
    } on FirebaseAuthException catch (e) {
      updateErrorMessage("Login failed: ${e.message}");
    }
  }

  void updatePage(bool isLogin) {
    setState(() {
      if (isLogin) {
        title = Strings.login;
        hint = Strings.signupHint;
        textButton = Strings.register;
      } else {
        title = Strings.register;
        hint = Strings.loginHint;
        textButton = Strings.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login_background.jpg'),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
        child: Card(
          elevation: 10,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                                Text(
                                  hint,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextButton(
                                  onPressed: () => {
                                    setState(() {
                                      isLogin = !isLogin;
                                      updatePage(isLogin);
                                    })
                                  },
                                  child: Text(textButton,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.blue)),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: Strings.emailAddress,
                                      hintText: Strings.emailExample,
                                      border: const OutlineInputBorder(),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  controller: _emailController,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: Strings.password,
                                      hintText: Strings.passwordHint,
                                      border: const OutlineInputBorder(),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                const Checkboxwithtext(
                                    title: Strings.remeberMe),
                                FilledButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 215, 90, 194)),
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.purple)),
                                    onPressed: () {
                                      if (isLogin) {
                                        _login();
                                      } else {
                                        _register();
                                      }
                                    },
                                    child: Text(title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall)),
                                Text(Strings.orLoginWith,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.blue),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.facebook,
                                              color: Colors.indigo,
                                              size: 24,
                                            ),
                                            Text(Strings.facebook,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall)
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.blue),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.g_mobiledata,
                                                color: Colors.red,
                                                size: 24,
                                              ),
                                              Text(Strings.google,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall)
                                            ],
                                          ))
                                    ]),
                                Text(
                                  errorMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.red),
                                )
                              ],
                            )))),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/login_image.jpg'),
                              fit: BoxFit.cover))))
            ],
          ),
        ),
      ),
    );
  }
}
