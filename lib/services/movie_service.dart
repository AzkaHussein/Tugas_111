import 'dart:convert';
import 'package:http/http.dart' as http;

// Import model yang dibutuhkan
// Sesuaikan path package dengan nama project kamu (contoh: kasir_1)
import 'package:kasir_1/models/movie_model.dart';
import 'package:kasir_1/models/response_data_list.dart';
import 'package:kasir_1/models/user_login.dart';
import 'package:kasir_1/services/url.dart' as url;

class MovieService {
  Future<ResponseDataList> getMovie() async {
    // 1. Mendapatkan data login user untuk mengambil token
    UserLogin userLogin = UserLogin();
    var user = await UserLogin.getUserLogin();

    // 2. Cek apakah user sudah login
    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'Anda belum login / token invalid',
      );
    }

    // 3. Persiapkan Endpoint dan Header (Token)
    var uri = Uri.parse(url.Baseurl + "/admin/getmovie");
    Map<String, String> headers = {
      "Authorization": "Bearer ${user.token}",
      "Accept": "application/json", // Tambahan opsional agar server tahu format yang diminta
    };

    try {
      // 4. Eksekusi Request HTTP GET
      var getMovieResponse = await http.get(uri, headers: headers);

      // 5. Cek StatusCode dari backend (200 = OK)
      if (getMovieResponse.statusCode == 200) {
        var data = json.decode(getMovieResponse.body);

        // 6. Cek status di dalam body JSON (tergantung format API kamu)
        if (data["status"] == true) {
          // Mapping data list dynamic ke List<MovieModel>
          List<MovieModel> movie = List<MovieModel>.from(
            data["data"].map((item) => MovieModel.fromJson(item)),
          );

          return ResponseDataList(
            status: true,
            message: 'success load data',
            data: movie,
          );
        } else {
          return ResponseDataList(
            status: false, 
            message: 'Failed load data'
          );
        }
      } else {
        // Jika statusCode bukan 200
        return ResponseDataList(
          status: false,
          message: 'gagal load movie dengan code error ${getMovieResponse.statusCode}',
        );
      }
    } catch (e) {
      // Menangani error koneksi atau error lainnya
      return ResponseDataList(
        status: false,
        message: 'Terjadi kesalahan sistem: $e',
      );
    }
  }
}