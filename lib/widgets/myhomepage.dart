import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laboratorio4_app/widgets/homenoticias.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Noticias>> noticiasFuture = getNoticias();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Noticias"),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(onPressed: null, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: noticiasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final noticias = snapshot.data as List<Noticias>;
              return buildNoticias(noticias);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  static Future<List<Noticias>> getNoticias() async {
    var url = Uri.parse("https://newsapi.org/v2/top-headlines?country=us&apiKey=c91c9d16bec84438baacbf5ec9055a13");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);
    final List articles = body['articles'];
    return articles.map((e) => Noticias.fromJson(e)).toList();
  }
}

Widget buildNoticias(List<Noticias> noticias) {
  return ListView.separated(
    itemCount: noticias.length,
    itemBuilder: (BuildContext context, int index) {
      final noticia = noticias[index];
      final url = noticia.url;

      return ListTile(
        title: Text(noticia.name),
        leading: CircleAvatar(backgroundImage: NetworkImage(url)),
        subtitle: Text(noticia.description),
        trailing: const Icon(Icons.arrow_forward_ios),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return const Divider(
        thickness: 2,
      );
    },
  );
}