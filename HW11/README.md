## HW11 – Rick and Morty Tarayıcı (SwiftUI + MVVM)

Küçük ve anlaşılır bir SwiftUI uygulaması. Rick and Morty karakterlerini listeler, arama yapmanıza izin verir, aşağı indikçe yeni sayfaları getirir ve detay ekranında büyük görseller gösterir. Arkada MVVM, async/await ağ istekleri ve basit bir favoriler saklama (UserDefaults) yapısı var.

### Neden var?
Gerçek bir API ile Swift Concurrency pratik yapmak için hafif, aç–çalıştır bir örnek istedim. Açın, çalıştırın, isterseniz genişletin.

---

### Öğrenme hedefleri
- Gerçek bir REST API’den veri çekmek (GET, sorgu parametreleri, sayfalama)
- Swift Concurrency (async/await) ile ağ istekleri yazmak
- JSON → Codable model dönüşümü
- SwiftUI ile liste, detay, hata/boş durum ve yükleme göstergesi
- Resim yükleme, basit önbellekleme, pull‑to‑refresh ve lokal favoriler
- Basit bir network katmanı ve temiz MVVM kurgusu

### Özellikler
- **Karakter listesi**: İsim, küçük görsel ve kısa bilgilerle kartlar
- **Sayfalama**: Aşağı indikçe yeni sayfalar otomatik yüklenir
- **Arama**: İsimle sunucu taraflı filtreleme
- **Detay ekranı**: Büyük görsel ve ek bilgiler
- **Pull‑to‑refresh**: Aşağı çekerek yenileme
- **Favoriler**: Beğendiklerinizi işaretleyip yerelde saklayın
- **Basit resim önbelleği**: `AsyncImage` + `URLCache`
- **Hata / boş durum**: Anlaşılır mesajlar

---

### Teknoloji
- **iOS**: 16+
- **UI**: SwiftUI
- **Mimari**: MVVM (View, ViewModel, Network, Model)
- **Network**: `URLSession` + `async/await`
- **Modeller**: `Codable`
- **Saklama**: Basit favoriler (UserDefaults)
- **Görseller**: `AsyncImage` + `URLCache`

---

### API
- **Temel adres**: Rick and Morty API — `https://rickandmortyapi.com/api`
- Karakterler: `GET /character`
  - Parametreler: `page`, `name`
  - Örnek: `https://rickandmortyapi.com/api/character?page=2&name=rick`
- Kimlik doğrulama gerekmez.

Docs: [`https://rickandmortyapi.com/documentation`](https://rickandmortyapi.com/documentation)

---

### Gereksinimler
- Xcode 15+
- iOS 16+ simülatör veya cihaz

---

### Başlangıç
1. Xcode’da `HW11.xcodeproj` dosyasını açın.
2. iOS 16+ bir simülatör (veya cihaz) seçin.
3. Build & Run.

İpucu: İlk yükleme boş görünürse “rick” yazarak aramayı deneyin ya da aşağı çekip yenileyin.

---

### Proje yapısı (kısaca)
- `HW11App.swift` — Uygulama girişi
- `ContentView.swift` — Kök görünüm
- `Persistence.swift` — Template’ten gelen Core Data iskeleti
- `Models.swift` — `RMCharacter`, `APIPage<T>`
- `NetworkService.swift` — API çağrıları ve decode
- `CharactersViewModel.swift` — Durum, arama, sayfalama
- `Views.swift` — Liste, satır, detay ve diğer UI parçaları

(Note: Some folders may be created by you during iteration.)

---

### Nasıl çalışır?
- Liste, ViewModel’e (`characters`, `isLoading`, `error`, `query`) bağlıdır.
- Ara alanına yazınca `GET /character?name=...&page=1` çağrılır.
- Listenin sonlarına yaklaşınca bir sonraki sayfa yüklenir.
- Bir karta dokununca detay ekranı açılır; büyük görsel ve bilgiler gösterilir.
- Favoriler id bazında yerelde tutulur; listede kalp simgesiyle görünür.

---

### Genişletme fikirleri
- Filtreler ekleyin (durum/tür)
- Detay ekranına bölümler (episodes) ekleyin
- Görseller için Kingfisher/SDWebImage’a geçin

---

### Lisans
Bu proje öğrenme amaçlıdır.


