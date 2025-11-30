import 'package:menu_makanan/features/produk/domain/entities/produk_entity.dart';

/// Abstract Data Source interface untuk Produk
/// Mendefinisikan contract untuk data sources (local, remote, etc)
abstract class ProdukDataSource {
  /// Fetch semua produk
  Future<List<ProdukEntity>> getAllProduk();

  /// Fetch produk berdasarkan ID
  Future<ProdukEntity> getProdukById(String id);

  /// Search produk berdasarkan query
  Future<List<ProdukEntity>> searchProduk(String query);
}
