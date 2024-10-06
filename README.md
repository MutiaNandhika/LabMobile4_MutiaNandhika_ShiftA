# LabMobile4_MutiaNandhika_ShiftA
### Screenshot semua halaman UI yang sudah terbentuk
<img src="https://github.com/user-attachments/assets/fdb24fe9-28ab-4af9-a80d-e0f8257665b9" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/782dd2e5-b638-484e-b3a3-191c34abd85f" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/ffc0c842-ab72-4838-b18d-23e54bc72b2e" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/486f4af7-f0a9-437a-b072-d3eb85181d83" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/aa107c39-fec3-41bb-a875-ccfad0084649" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/b3c6688f-0d4e-4592-b245-c9f0dde5863b" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/58f30694-6e7e-49fc-b3a7-066f4ea8b96a" alt="Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/39e1dc9b-93c5-4bcb-bdca-83ba5f1b646b" alt="Screenshot" width="300"/>

# Proses Login dan CRUD dalam bentuk langkah per langkah
## 1. Proses Login
**a. Screenshot form dan isi form**

<img src="https://github.com/user-attachments/assets/c67529aa-26d3-4a21-928c-bba3cbc48b30" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pada proses login, pengguna memasukkan email dan password melalui form. Setelah menekan tombol Login, data tersebut dikirim ke API untuk diverifikasi.

**Kode**:
```dart
LoginBloc.login(
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
)
```
**b. SS PopUp Berhasil/Tidak**

***Berhasil***

<img src="https://github.com/user-attachments/assets/8f51be16-fde2-419d-8426-78c4aafef09d" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pada proses login, Jika berhasil, pengguna diarahkan ke halaman produk.

**Kode**:
```dart
LoginBloc.login(
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
).then((value) async {
  if (value.code == 200) {  // Jika login berhasil
    await UserInfo().setToken(value.token!);  // Simpan token
    await UserInfo().setUserID(int.parse(value.userID.toString()));  // Simpan ID pengguna
    
    // Arahkan ke halaman produk
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => ProdukPage())
    );
  } else {
    // Tampilkan PopUp jika login gagal
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const WarningDialog(
        description: "Login gagal, silahkan coba lagi",
      ),
    );
  }
}, onError: (error) {
  // Tampilkan PopUp untuk error jaringan atau server
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const WarningDialog(
      description: "Terjadi kesalahan, silahkan coba lagi",
    ),
  );
});

```
***Tidak Berhasil***

<img src="https://github.com/user-attachments/assets/ea3b3b80-1d76-46e7-90c0-55a7923d0fb3" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pada proses login, Jika gagal, PopUp akan menampilkan pesan bahwa login gagal.

**Kode**:
```dart
showDialog(
  context: context,
  barrierDismissible: false,  // PopUp tidak bisa ditutup dengan klik di luar
  builder: (BuildContext context) => const WarningDialog(
    description: "Login gagal, silahkan coba lagi",
  ),
);

```

## 2. Proses Tambah Data Produk (Create)

<img src="https://github.com/user-attachments/assets/22edb072-8c68-4810-a3cb-e58aabc7a7ce" alt="Screenshot" width="200"/>
<img src="https://github.com/user-attachments/assets/e60f4c5a-1d36-42af-a9d6-353c46010765" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pada tahap ini, pengguna dapat menambahkan data produk baru melalui form yang tersedia. Form ini biasanya berisi informasi seperti kode produk, nama produk, dan harga produk. Setelah menekan tombol Simpan, data produk tersebut dikirim ke server untuk disimpan di dalam database.

**Kode**:
```dart
ProdukBloc.addProduk(
  produk: Produk(
    kodeProduk: _kodeProdukTextboxController.text,
    namaProduk: _namaProdukTextboxController.text,
    hargaProduk: int.parse(_hargaProdukTextboxController.text),
  ),
)
```
## 3. Proses Tampil Data Produk (Read)

<img src="https://github.com/user-attachments/assets/083ba925-fcae-4388-96fa-73ab8f2d9510" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pada tahap ini, aplikasi akan mengambil daftar produk yang sudah tersimpan di server dan menampilkannya di halaman produk dalam bentuk list. Proses ini dilakukan dengan mengirim permintaan GET ke API dan mengambil data produk dalam format JSON, kemudian ditampilkan di UI.

**Kode**:
```dart
FutureBuilder<List<Produk>>(
  future: ProdukBloc.getProduks(),  // Mengambil data produk dari server
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,  // Menampilkan produk sebanyak jumlah data yang diterima
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(snapshot.data![index].namaProduk!),  // Menampilkan nama produk
            subtitle: Text(snapshot.data![index].hargaProduk.toString()),  // Menampilkan harga produk
          );
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());  // Menampilkan indikator loading saat data belum tersedia
    }
  },
);
```
## 4. Proses Update Data Produk (Update)
<img src="https://github.com/user-attachments/assets/83c1d0ef-07fa-4fce-842e-04cb9e24c176" alt="Screenshot" width="200"/>

<img src="https://github.com/user-attachments/assets/ecda1286-0094-4d43-a790-691d6db82703" alt="Screenshot" width="200"/>

<img src="https://github.com/user-attachments/assets/79ca5de5-e6e8-4e0d-b516-a5cf67a592f2" alt="Screenshot" width="200"/>

<img src="https://github.com/user-attachments/assets/68939752-0fcc-41aa-8b36-4be4a820944c" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pengguna dapat mengedit informasi produk yang sudah ada. Setelah pengguna mengubah informasi di form dan menekan tombol Simpan, data produk yang telah diperbarui dikirim ke server melalui API. Server akan memperbarui data tersebut di database.

**Kode**:
```dart
ProdukBloc.updateProduk(
  produk: Produk(
    id: widget.produk!.id!,
    kodeProduk: _kodeProdukTextboxController.text,
    namaProduk: _namaProdukTextboxController.text,
    hargaProduk: int.parse(_hargaProdukTextboxController.text),
  ),
)
```
## 5. Proses Hapus Data Produk (Delete)

<img src="https://github.com/user-attachments/assets/275992a0-726e-435d-b3ad-86d863469011" alt="Screenshot" width="200"/>

<img src="https://github.com/user-attachments/assets/af8ebc99-27be-4451-8e64-c79d7421d720" alt="Screenshot" width="200"/>

<img src="https://github.com/user-attachments/assets/88101cee-983e-4679-ae0e-aaa5c5ee3c21" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pengguna dapat menghapus produk yang tidak diperlukan lagi. Saat pengguna menekan tombol Hapus, aplikasi akan meminta konfirmasi. Jika dikonfirmasi, data produk akan dikirim ke API untuk dihapus dari database.

**Kode**:
```dart
ProdukBloc.deleteProduk(
  id: widget.produk!.id!,  // Mengambil ID produk yang akan dihapus
).then((value) {
  Navigator.pushReplacement(
    context, 
    MaterialPageRoute(builder: (context) => ProdukPage()),  // Arahkan kembali ke halaman produk setelah menghapus
  );
});
```
## 5. Proses Logout

<img src="https://github.com/user-attachments/assets/f2cd572f-efb7-4b52-b886-c76e931ccabe" alt="Screenshot" width="200"/>

**Penjelasan**:  
Pada proses logout, aplikasi akan menghapus token dan user ID yang disimpan di local storage (dalam hal ini menggunakan SharedPreferences). Setelah token dihapus, pengguna akan diarahkan kembali ke halaman Login. Proses ini bertujuan untuk mengakhiri sesi pengguna yang sedang aktif.

**Kode**:
```dart
LogoutBloc.logout().then((value) {
  // Hapus token dan ID pengguna dari local storage
  UserInfo().logout().then((_) {
    // Arahkan ke halaman login setelah logout berhasil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  });
});
```



