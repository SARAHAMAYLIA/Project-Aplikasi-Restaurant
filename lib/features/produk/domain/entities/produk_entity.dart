/// Domain Entity: Produk
/// Representasi data produk di layer domain (tidak bergantung pada external library)
class ProdukEntity {
  final String id;
  final String nama;
  final String deskripsi;
  final double harga;
  final String gambar;
  final double rating;

  ProdukEntity({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.rating,
  });
}
