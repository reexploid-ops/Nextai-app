# 📱 Panduan Build APK via GitHub Actions

Panduan langkah-demi-langkah membangun APK Android **gratis di cloud** tanpa perlu install apapun di komputer Anda.

---

## 🎯 Apa yang Akan Anda Dapatkan

Setelah selesai mengikuti panduan ini:
- ✅ APK Android (`.apk`) yang siap di-install di HP
- ✅ Otomatis build setiap kali Anda push code (CI/CD)
- ✅ Bisa trigger manual lewat tombol di GitHub
- ✅ Bisa auto-release dengan tag versi (v1.0.0, v1.0.1, dst.)

---

## ⏱ Estimasi Waktu

| Tahap | Waktu |
|---|---|
| Buat akun GitHub (jika belum) | 2 menit |
| Buat repo & upload code | 5 menit |
| Build APK pertama (auto) | ~6-8 menit |
| Download APK | 30 detik |
| **Total** | **~15 menit** |

---

## 📋 Prasyarat

- ✅ Akun GitHub (gratis): https://github.com/signup
- ✅ Browser (Chrome/Firefox/Safari/Edge)
- ❌ **TIDAK perlu** install Git, Flutter, Android Studio, Java, dll. di komputer

---

## 🚀 Langkah 1: Buat Repository Baru di GitHub

1. Login ke https://github.com
2. Klik tombol hijau **"New"** atau buka https://github.com/new
3. Isi form:
   - **Repository name**: `nextai-app` (atau nama lain)
   - **Description**: `Next AI - Premium AI Assistant App`
   - **Visibility**: Pilih **Public** (private juga bisa, tapi public = unlimited Actions minutes)
   - ❌ JANGAN centang "Add a README file", "Add .gitignore", atau "Choose a license" (kita akan upload sendiri)
4. Klik **"Create repository"**

---

## 📤 Langkah 2: Upload Project Files

### Cara A: Lewat Browser (Paling Mudah, No Git Needed)

1. Di halaman repo baru, klik link **"uploading an existing file"**
2. **Drag & drop SELURUH isi folder `nextai_flutter/`** ke area upload
   - ⚠️ **PENTING**: Drag isi folder, BUKAN folder-nya sendiri
   - Pastikan folder tersembunyi `.github/` juga ikut ter-upload
3. Scroll ke bawah, isi **commit message**: `Initial commit`
4. Klik **"Commit changes"**

### Cara B: Lewat Git CLI (Jika Anda Tahu Git)

```bash
cd nextai_flutter
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/USERNAME/nextai-app.git
git push -u origin main
```

---

## ⚙️ Langkah 3: Tunggu Build Otomatis Berjalan

1. Setelah commit, klik tab **"Actions"** di atas halaman repo
2. Anda akan melihat workflow **"Build Android APK"** sedang berjalan (titik kuning 🟡)
3. Klik nama workflow untuk melihat progress real-time
4. Tunggu sekitar **6-8 menit** untuk build pertama
   - Build berikutnya lebih cepat (~3 menit) karena cache

### Tampilan Progress:

```
✓ Checkout code               (5s)
✓ Set up JDK 17               (15s)
✓ Set up Flutter              (60s)  ← Download Flutter SDK
✓ Cache Gradle                (5s)
✓ Cache Pub                   (5s)
✓ Flutter doctor              (10s)
✓ Generate Android folder     (10s)
✓ Install dependencies        (30s)
✓ Analyze code                (15s)
✓ Build debug APK             (180s) ← Yang paling lama
✓ Build release APK           (120s)
✓ Upload debug APK            (5s)
✓ Upload release APK          (5s)
```

---

## 📥 Langkah 4: Download APK

Setelah workflow selesai (centang hijau ✅):

1. Klik workflow run yang sudah selesai
2. Scroll ke bawah ke section **"Artifacts"**
3. Klik **"nextai-debug-apk"** untuk download
4. File akan terdownload sebagai `.zip` — extract untuk dapatkan `app-debug.apk`

---

## 📱 Langkah 5: Install APK di HP

1. Transfer `app-debug.apk` ke HP Android Anda (lewat USB, Google Drive, atau email)
2. Di HP, buka **Settings → Security → Unknown Sources** (aktifkan)
   - Atau Android 8+: saat tap file APK, akan diminta izin "Install unknown apps" untuk app file manager
3. Tap file APK, ikuti instruksi install
4. App **"Next AI"** akan muncul di app drawer dengan icon Flutter

---

## 🔄 Update / Rebuild APK

Setiap kali Anda mengubah code:

1. Edit file lewat web GitHub atau push lokal
2. Commit → workflow auto-trigger
3. Tunggu build selesai → download APK baru

### Manual Trigger (Tanpa Push):

1. Buka tab **Actions**
2. Pilih workflow **"Build Android APK"** di sidebar kiri
3. Klik tombol **"Run workflow"** di kanan atas
4. Pilih branch → klik **"Run workflow"**

---

## 🏷 Auto-Release dengan Tag Versi

Untuk membuat release resmi dengan changelog:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Atau lewat web:
1. Buka repo → klik **"Releases"** di sidebar kanan
2. Klik **"Create a new release"**
3. Isi tag `v1.0.0`, klik **"Publish release"**

Workflow `release.yml` akan otomatis:
- Build APK release dengan split per ABI (lebih kecil ukurannya)
- Upload sebagai release asset
- User bisa download dari halaman Releases

---

## 🔐 (Opsional) Setup Signing Key untuk Play Store

APK debug **TIDAK bisa di-upload ke Play Store**. Untuk release production:

### 1. Generate Keystore (di komputer lokal, sekali saja)

```bash
keytool -genkey -v -keystore nextai-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias nextai
```

### 2. Convert ke Base64

```bash
base64 -i nextai-release.jks | tr -d '\n' > keystore.base64.txt
```

### 3. Tambahkan ke GitHub Secrets

Di repo → **Settings → Secrets and variables → Actions → New repository secret**:

| Secret Name | Value |
|---|---|
| `KEYSTORE_BASE64` | Isi dari `keystore.base64.txt` |
| `KEYSTORE_PASSWORD` | Password keystore Anda |
| `KEY_ALIAS` | `nextai` |
| `KEY_PASSWORD` | Password key Anda |

### 4. Update workflow untuk gunakan signing (advanced)

Edit `.github/workflows/build-apk.yml`, tambahkan sebelum build:

```yaml
- name: Decode keystore
  run: |
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/nextai-release.jks

- name: Create key.properties
  run: |
    cat > android/key.properties <<EOF
    storePassword=${{ secrets.KEYSTORE_PASSWORD }}
    keyPassword=${{ secrets.KEY_PASSWORD }}
    keyAlias=${{ secrets.KEY_ALIAS }}
    storeFile=nextai-release.jks
    EOF
```

Lalu tambahkan signing config ke `android/app/build.gradle`. Saya bisa bantu kalau Anda sudah sampai tahap ini.

---

## 🐛 Troubleshooting

### ❌ "Workflow failed" di step "Build debug APK"

**Solusi:** Klik step yang gagal untuk lihat error log. Biasanya karena:
- Dependency conflict → update `pubspec.yaml`
- Code error → cek `flutter analyze` output

### ❌ APK ter-install tapi crash saat dibuka

**Solusi:** APK debug butuh `armeabi-v7a` atau `arm64-v8a`. Untuk HP lama, build dengan:
```yaml
- run: flutter build apk --debug --target-platform android-arm,android-arm64
```

### ❌ "Permission denied" saat install APK

**Solusi:** Aktifkan **"Install from unknown sources"** di Settings → Security.

### ❌ Build di-cancel karena timeout

**Solusi:** Naikkan timeout di workflow:
```yaml
timeout-minutes: 60  # dari 30
```

---

## 💰 Biaya GitHub Actions

**Public repo: 100% GRATIS, unlimited minutes** 🎉

Private repo (free tier):
- 2,000 menit/bulan gratis (Ubuntu runner = 1x rate)
- 1 build APK = ~8 menit → bisa ~250 build/bulan gratis

Untuk hobby project, **Public + Unlimited** lebih dari cukup.

---

## 📚 Resources Lanjutan

- 📖 [Flutter Build Documentation](https://docs.flutter.dev/deployment/android)
- 🎬 [Video: GitHub Actions for Flutter](https://www.youtube.com/results?search_query=github+actions+flutter+apk)
- 🛠 [Subosito Flutter Action (yang dipakai workflow)](https://github.com/subosito/flutter-action)
- 🔑 [Signing Android Apps](https://docs.flutter.dev/deployment/android#signing-the-app)

---

## ✅ Checklist Cepat

- [ ] Akun GitHub sudah ada
- [ ] Buat repo baru (Public direkomendasikan)
- [ ] Upload semua file `nextai_flutter/` (termasuk folder `.github/`)
- [ ] Tunggu workflow di tab Actions selesai (~8 menit)
- [ ] Download `nextai-debug-apk` dari Artifacts
- [ ] Extract ZIP → install APK di HP
- [ ] 🎉 **Done!** App "Next AI" sudah running di HP Anda

---

**Pertanyaan?** Saat ada masalah, screenshot error log dari GitHub Actions dan tanya saya — saya akan bantu debug! 🚀
