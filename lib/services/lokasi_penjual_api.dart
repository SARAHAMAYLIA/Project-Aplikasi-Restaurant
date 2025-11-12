import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menu_makanan/model/lokasi_penjual.dart';

class LokasiPenjualApi {
  // Update this base URL when your real API is deployed.
  static const String _baseUrl = 'http://localhost:3000';

  static Future<List<LokasiPenjual>> fetchSemuaLokasi() async {
    final uri = Uri.parse('$_baseUrl/api/locations');
    try {
      final resp = await http.get(uri).timeout(const Duration(seconds: 5));
      if (resp.statusCode == 200) {
        final List<dynamic> data = json.decode(resp.body) as List<dynamic>;
        return data
            .map((e) => LokasiPenjual.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        throw Exception('API returned status ${resp.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch locations: $e');
    }
  }
}
