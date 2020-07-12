import 'package:http/http.dart' show Client;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://192.168.43.194:8000";
  Client client = Client();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await client.post("$baseUrl/api/login",
        body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      String token = data["token"];
      Map user = data["user"];
      return {"token": token, "user": user, "error": false};
    } else {
      var data = json.decode(response.body);
      String message = data["message"];
      return {"message": message, "error": true};
    }
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    final response = await client.post("$baseUrl/api/regis", body: {
      "name": name,
      "email": email,
      "password": password,
    });
    if (response.statusCode == 201) {
      return {"message": "Berhasil registrasi.", "error": false};
    } else {
      return {"message": "terjadi kesalahan", "error": true};
    }
  }

  Future jadwal(String token) async {
    final response = await client.get(
      "$baseUrl/api/jadwal",
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return {"jadwal": data, "error": false};
    } else {
      return {"message": "terjadi kesalahan", "error": true};
    }
  }

  Future buatJadwal(String token, String nama, String waktu) async {
    final response = await client.post("$baseUrl/api/jadwal", headers: {
      "Authorization": "Bearer $token"
    }, body: {
      "nama": nama,
      "waktu": waktu,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return {"jadwal": data, "error": false};
    } else {
      return {"message": "terjadi kesalahan", "error": true};
    }
  }
}
