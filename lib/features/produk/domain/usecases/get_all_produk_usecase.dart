import 'package:menu_makanan/features/produk/domain/entities/produk_entity.dart';
import 'package:menu_makanan/features/produk/domain/repositories/produk_repository.dart';

/// UseCase: Mengambil semua produk
/// Mengenkapsulasi business logic untuk fetch produk
class GetAllProdukUseCase {
  final ProdukRepository repository;

  GetAllProdukUseCase(this.repository);

  /// Execute usecase
  Future<List<ProdukEntity>> call() async {
    return await repository.getAllProduk();
  }
}
