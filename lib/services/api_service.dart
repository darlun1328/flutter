// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:trii_api/models/character.dart';

class ApiService {
  static const String apiUrl = "https://rickandmortyapi.com/api/character";

  static Future<List<Character>> getCharacters() async {
    final response = await get(apiUrl);
    final List<Character> lista = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for (var item in jsonData["results"]) {
        lista.add(Character(
            id: item["id"],
            name: item["name"],
            status: item["status"],
            species: item["species"],
            gender: item["gender"],
            image: item['image']));
      }
    } else {
      throw Exception("ERROR: Los datos no pudieron ser obtenidos");
    }

    return lista;
  }

  Future<Character> getCharacterById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      return Character.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error obteniendo personaje por id');
    }
  }
}
