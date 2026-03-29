import 'package:flutter/material.dart';
import 'package:kasir_1/services/user.dart';
import 'package:kasir_1/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthday = TextEditingController();

  List roleChoice = ["admin", "user"];
  String? role;

  UserService user = UserService();
  AlertPopup alert = AlertPopup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: const Text("Register Kantin Sekolah"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  "Form Registrasi Pengguna",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),

                buildField(name, "Nama"),
                buildField(email, "Email"),
                buildDropdown(),
                buildField(password, "Password", obscure: true),
                buildField(address, "Alamat"),
                buildField(birthday, "Tanggal Lahir"),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var data = {
                          'name': name.text,
                          'email': email.text,
                          'role': role,
                          'password': password.text,
                          'address': address.text,
                          'birthday': birthday.text,
                        };

                        var result = await user.registerUser(data);

                        alert.show(
                          context,
                          result.message ?? "Registrasi selesai",
                          result.status,
                        );

                        if (result.status == true) {
                          name.clear();
                          email.clear();
                          password.clear();
                          address.clear();
                          birthday.clear();
                          setState(() {
                            role = null;
                          });
                        }
                      }
                    },
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(TextEditingController controller, String label,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: (value) {
          if (value!.isEmpty) {
            return "$label wajib diisi";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.red),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField(
        value: role,
        items: roleChoice.map((r) {
          return DropdownMenuItem(value: r, child: Text(r));
        }).toList(),
        onChanged: (value) {
          setState(() {
            role = value.toString();
          });
        },
        validator: (value) {
          if (value == null) {
            return "Role wajib dipilih";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Role",
          labelStyle: const TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
