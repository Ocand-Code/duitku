import 'package:firebase_core/firebase_core.dart';

// File ini WAJIB diisi dengan konfigurasi Firebase-mu.
// Cara termudah: install Flutter, lalu jalankan:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// Perintah itu akan menimpa file ini dengan nilai aslimu.
//
// Atau ganti placeholder di bawah dengan nilai dari
// Firebase Console > Project Settings > Your apps > Android app.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'GANTI_DENGAN_API_KEY',
      appId: 'GANTI_DENGAN_APP_ID',
      messagingSenderId: 'GANTI_DENGAN_SENDER_ID',
      projectId: 'GANTI_DENGAN_PROJECT_ID',
      storageBucket: 'GANTI_DENGAN_STORAGE_BUCKET.appspot.com',
      androidClientId: 'GANTI_DENGAN_ANDROID_CLIENT_ID',
    );
  }
}