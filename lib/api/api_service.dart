import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = "http://192.168.174.97:8000/";

  Future<bool> login(String email, String password) async {
    final response = await http.get(Uri.parse("${baseUrl}users/password/email/$email/"));
    if (response.statusCode == 200) {
      return response.body.replaceAll('"', '') == password;
    }
    return false;
  }

  Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse("${baseUrl}users/"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // ✅ Add this method for fetching wardrobe images
  Future<List<String>> fetchWardrobeImages() async {
    final response = await http.get(Uri.parse("${baseUrl}wardrobe/"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Assuming response is: [{"image": "base64string"}, ...]
      return data.map((item) => item['image'] as String).toList();
    } else {
      throw Exception("Failed to fetch wardrobe images");
    }
  }
}
