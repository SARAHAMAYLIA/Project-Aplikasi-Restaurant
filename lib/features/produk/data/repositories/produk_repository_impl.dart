import 'package:menu_makanan/features/produk/data/datasources/produk_datasource.dart';
import 'package:menu_makanan/features/produk/domain/entities/produk_entity.dart';
import 'package:menu_makanan/features/produk/domain/repositories/produk_repository.dart';

/// Concrete Repository Implementation
/// Mengimplementasikan domain repository interface menggunakan data source
class ProdukRepositoryImpl implements ProdukRepository {
  final ProdukDataSource dataSource;

  ProdukRepositoryImpl({required this.dataSource});

  @override
  Future<List<ProdukEntity>> getAllProduk() async {
    try {
      return await dataSource.getAllProduk();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProdukEntity> getProdukById(String id) async {
    try {
      return await dataSource.getProdukById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProdukEntity>> searchProduk(String query) async {
    try {
      return await dataSource.searchProduk(query);
    } catch (e) {
      rethrow;
    }
  }
}
