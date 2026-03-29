import 'package:flutter/material.dart';
import 'package:kasir_1/services/user.dart';
import 'package:kasir_1/widgets/alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final UserService user = UserService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLoading = false;
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /// EMAIL
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email harus diisi";
                    }
                    return null;
                  },
                ),

                /// PASSWORD
                TextFormField(
                  controller: password,
                  obscureText: showPass,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPass
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password harus diisi";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                /// BUTTON LOGIN
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.green,
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              var result = await user.loginUser({
                                "email": email.text,
                                "password": password.text,
                              });

                              setState(() {
                                isLoading = false;
                              });

                              if (result.status == true) {
                                AlertPopup().show(
                                  context,
                                  result.message,
                                  true,
                                );

                                Future.delayed(
                                  const Duration(seconds: 1),
                                  () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/dashboard',
                                    );
                                  },
                                );
                              } else {
                                AlertPopup().show(
                                  context,
                                  result.message,
                                  false,
                                );
                              }
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
