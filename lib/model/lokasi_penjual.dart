import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiPenjual {
  final String id;
  final String nama;
  final double latitude;
  final double longitude;
  final String alamat;
  final String nomorTelepon;
  final String jamBuka;
  final String jamTutup;
  final double rating;
  final String fotoUrl;
  final List<String> kategoriMakanan;

  LokasiPenjual({
    required this.id,
    required this.nama,
    required this.latitude,
    required this.longitude,
    required this.alamat,
    required this.nomorTelepon,
    required this.jamBuka,
    required this.jamTutup,
    required this.rating,
    required this.fotoUrl,
    required this.kategoriMakanan,
  });

  // Convert to LatLng untuk Google Maps
  LatLng get latLng => LatLng(latitude, longitude);

  // Buat dari JSON
  factory LokasiPenjual.fromJson(Map<String, dynamic> json) {
    // Accept both camelCase and snake_case keys from different sources
    String _getString(
      Map<String, dynamic> m,
      List<String> keys, [
      String def = '',
    ]) {
      for (var k in keys) {
        if (m.containsKey(k) && m[k] != null) return m[k].toString();
      }
      return def;
    }

    double _getDouble(
      Map<String, dynamic> m,
      List<String> keys, [
      double def = 0,
    ]) {
      for (var k in keys) {
        if (m.containsKey(k) && m[k] != null) return (m[k] as num).toDouble();
      }
      return def;
    }

    List<String> _getStringList(Map<String, dynamic> m, List<String> keys) {
      for (var k in keys) {
        if (m.containsKey(k) && m[k] != null) {
          final value = m[k];
          if (value is List)
            return List<String>.from(value.map((e) => e.toString()));
        }
      }
      return <String>[];
    }

    return LokasiPenjual(
      id: _getString(json, ['id', 'Id']),
      nama: _getString(json, ['nama', 'name']),
      latitude: _getDouble(json, ['latitude', 'lat']),
      longitude: _getDouble(json, ['longitude', 'lng', 'lon']),
      alamat: _getString(json, ['alamat', 'address']),
      nomorTelepon: _getString(json, [
        'nomor_telepon',
        'nomorTelepon',
        'phone',
      ]),
      jamBuka: _getString(json, ['jam_buka', 'jamBuka', 'open']),
      jamTutup: _getString(json, ['jam_tutup', 'jamTutup', 'close']),
      rating: _getDouble(json, ['rating']),
      fotoUrl: _getString(json, ['foto_url', 'fotoUrl', 'photo', 'image']),
      kategoriMakanan: _getStringList(json, [
        'kategori_makanan',
        'kategoriMakanan',
        'categories',
      ]),
    );
  }

  // Convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'latitude': latitude,
      'longitude': longitude,
      'alamat': alamat,
      'nomor_telepon': nomorTelepon,
      'jam_buka': jamBuka,
      'jam_tutup': jamTutup,
      'rating': rating,
      'foto_url': fotoUrl,
      'kategori_makanan': kategoriMakanan,
    };
  }
}
