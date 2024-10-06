class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;
  Produk({this.id, this.kodeProduk, this.namaProduk, this.hargaProduk});

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'] is String ? int.tryParse(obj['id']) : obj['id'],
      kodeProduk: obj['kode_produk'],
      namaProduk: obj['nama_produk'],
      hargaProduk:
          obj['harga'] is String ? int.tryParse(obj['harga']) : obj['harga'],
    );
  }
}