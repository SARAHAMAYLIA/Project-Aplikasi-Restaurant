import 'package:menu_makanan/features/produk/data/datasources/produk_datasource.dart';
import 'package:menu_makanan/features/produk/domain/entities/produk_entity.dart';
import 'package:menu_makanan/model/dummydata.dart';

/// Local Data Source: Implementasi dari datasource menggunakan dummy data
/// Bisa di-extend untuk menggunakan local database (SQLite, Hive, etc)
class ProdukLocalDataSource extends ProdukDataSource {
  @override
  Future<List<ProdukEntity>> getAllProduk() async {
    // Simulasi delay dari database local
    await Future.delayed(const Duration(milliseconds: 500));

    // Konversi dari model lokal ke domain entity
    final produkList = DummyData.getProdukList();
    return produkList.map((produk) {
      return ProdukEntity(
        id: produk.id,
        nama: produk.nama,
        deskripsi: produk.deskripsi,
        harga: produk.harga,
        gambar: produk.gambar,
        rating: produk.rating,
      );
    }).toList();
  }

  @override
  Future<ProdukEntity> getProdukById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final produkList = DummyData.getProdukList();
    final produk = produkList.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Produk not found'),
    );

    return ProdukEntity(
      id: produk.id,
      nama: produk.nama,
      deskripsi: produk.deskripsi,
      harga: produk.harga,
      gambar: produk.gambar,
      rating: produk.rating,
    );
  }

  @override
  Future<List<ProdukEntity>> searchProduk(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final produkList = DummyData.getProdukList();
    final result = produkList
        .where(
          (produk) =>
              produk.nama.toLowerCase().contains(query.toLowerCase()) ||
              produk.deskripsi.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return result.map((produk) {
      return ProdukEntity(
        id: produk.id,
        nama: produk.nama,
        deskripsi: produk.deskripsi,
        harga: produk.harga,
        gambar: produk.gambar,
        rating: produk.rating,
      );
    }).toList();
  }
}
