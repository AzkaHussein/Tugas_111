import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kasir_1/models/response_data_map.dart';
import 'package:kasir_1/models/user_login.dart';
import 'package:kasir_1/services/url.dart' as url;

class UserService {

  /// ================= REGISTER =================
  Future<ResponseDataMap> registerUser(data) async {
    var uri = Uri.parse(url.Baseurl + "/auth/register");
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      if (jsonData["status"] == true) {
        return ResponseDataMap(
          status: true,
          message: "Sukses menambah user",
          data: jsonData,
        );
      } else {
        String message = "";
        jsonData["message"].forEach((key, value) {
          message += value[0] + "\n";
        });

        return ResponseDataMap(
          status: false,
          message: message,
        );
      }
    }

    return ResponseDataMap(
      status: false,
      message: "Gagal register (${response.statusCode})",
    );
  }

  /// ================= LOGIN =================
  Future<ResponseDataMap> loginUser(data) async {
    var uri = Uri.parse(url.Baseurl + "/auth/login");
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      if (jsonData["status"] == true) {
        /// SIMPAN SESSION LOGIN
        UserLogin userLogin = UserLogin(
          status: true,
          token: jsonData["token"],
          id: jsonData["data"]["id"],
          nama_user: jsonData["data"]["name"],
          email: jsonData["data"]["email"],
          role: jsonData["data"]["role"],
          message: jsonData["message"],
        );

        await userLogin.save();

        return ResponseDataMap(
          status: true,
          message: jsonData["message"],
          data: jsonData,
        );
      } else {
        return ResponseDataMap(
          status: false,
          message: jsonData["message"],
        );
      }
    }

    return ResponseDataMap(
      status: false,
      message: "Login gagal (${response.statusCode})",
    );
  }
}
