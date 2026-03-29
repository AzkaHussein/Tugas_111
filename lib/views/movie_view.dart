import 'package:flutter/material.dart';
import 'package:kasir_1/models/movie_model.dart'; // Sesuaikan package name
import 'package:kasir_1/services/movie_service.dart';      // Sesuaikan package name

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  // 1. Deklarasi Service dan Variabel Penampung Data
  MovieService movie = MovieService();
  List? film;

  // 2. Fungsi untuk mengambil data dari API
  getFilm() async {
    var getMovie = await movie.getMovie();
    setState(() {
      film = getMovie.data;
    });
  }

  // 3. initState agar fungsi getFilm dijalankan saat halaman dibuka
  @override
  void initState() {
    super.initState();
    getFilm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Film"),
        backgroundColor: Colors.blueAccent,
      ),
      // 4. Logika tampilan: Cek apakah data film masih null atau sudah ada
      body: film != null
          ? ListView.builder(
              itemCount: film!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: film![index].posterPath != null
                        ? Image.network(
                            film![index].posterPath!,
                            width: 50,
                            fit: BoxFit.cover,
                            // Error builder jika gambar gagal load
                            errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.movie),
                    title: Text(
                      film![index].title ?? "Tanpa Judul",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      film![index].overview ?? "Tidak ada deskripsi",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(), // Loading saat data masih null
            ),
    );
  }
}