# DuitKu - Aplikasi Pencatat Keuangan

Aplikasi pencatat keuangan pribadi berbasis **Flutter** dan **Firebase**.

![Flutter](https://img.shields.io/badge/Flutter-3.27-blue) ![Firebase](https://img.shields.io/badge/Firebase-Firestore-orange)

## Fitur

- Catat **pemasukan** dan **pengeluaran** harian
- Kategori dengan emoji (Makanan, Transport, Gaji, dll)
- Ringkasan saldo, pemasukan, dan pengeluaran per bulan
- Filter berdasarkan bulan
- Login/Register dengan email & password
- Data tersimpan di **Firebase Firestore** (per-user)
- UI modern, Material 3, tema emerald hijau

## Persiapan

### 1. Install Flutter

Minimum Flutter **3.22**, direkomendasikan **3.27**. Install dari https://flutter.dev

```bash
flutter --version
```

### 2. Setup Firebase

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Buat project baru
3. Tambahkan **Android App** (package: `com.duitku.app`)
4. Aktifkan **Authentication** → Email/Password
5. Aktifkan **Firestore Database**
6. Jalankan setup CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Ini akan men-generate file `lib/firebase_options.dart` secara otomatis.

### 3. Setup Android Keystore (untuk upload ke Play Store)

Generate keystore untuk menandatangani AAB:

```bash
keytool -genkey -v -keystore keystore.jks \
  -alias upload -keyalg RSA -keysize 2048 -validity 10000 \
  -storetype JKS
```

Simpan keystore dan password-nya **AMAN** — hilang = tidak bisa update app di Play Store.

### 4. Install dependencies

```bash
flutter pub get
```

### 5. Run (debug)

```bash
flutter run
```

## Build APK / App Bundle

### Debug APK (testing)
```bash
flutter build apk --debug
```

### Release App Bundle (untuk Play Store)
```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Deploy ke Play Store

1. Buat akun [Google Play Console](https://play.google.com/console)
2. Buat app baru
3. Upload file `.aab` dari folder `build/app/outputs/bundle/release/`
4. Isi informasi app (deskripsi, screenshot, dll)
5. Submit untuk review

## GitHub Actions CI/CD

Repo ini sudah punya workflow CI yang otomatis build `.aab` setiap push ke `main`.

Setup:

1. Buat repo di GitHub, push kode ini
2. Di repo Settings → Secrets, tambah:
   - `KEYSTORE_B64` — keystore di-encode base64
     ```bash
     base64 keystore.jks | tr -d '\n'
     ```
   - `KEYSTORE_PASSWORD` — password keystore
   - `KEY_ALIAS` — alias (misal `upload`)
   - `KEY_PASSWORD` — password key
3. Push ke `main` → CI otomatis trigger
4. Download artifact `app-release.aab` dari Actions tab

## Struktur Project

```
duitku/
├── lib/
│   ├── main.dart              # Entry point
│   ├── firebase_options.dart   # Firebase config (setup manual)
│   ├── models/                # Data models
│   ├── services/              # Firebase auth & Firestore
│   ├── screens/               # UI screens
│   ├── theme/                 # App theme
│   ├── utils/                 # Utilities
│   └── widgets/               # Reusable widgets
├── android/                   # Android platform (auto-generate)
└── .github/workflows/         # CI/CD
```

## Lisensi

MIT License
