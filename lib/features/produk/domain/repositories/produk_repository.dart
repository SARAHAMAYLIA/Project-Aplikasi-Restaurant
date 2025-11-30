import 'package:menu_makanan/features/produk/domain/entities/produk_entity.dart';

/// Abstract Repository Interface untuk Produk
/// Mendefinisikan contract yang harus diimplementasikan oleh repository konkret
abstract class ProdukRepository {
  /// Fetch semua produk dari data source
  Future<List<ProdukEntity>> getAllProduk();

  /// Fetch produk berdasarkan ID
  Future<ProdukEntity> getProdukById(String id);

  /// Search produk berdasarkan nama
  Future<List<ProdukEntity>> searchProduk(String query);
}
