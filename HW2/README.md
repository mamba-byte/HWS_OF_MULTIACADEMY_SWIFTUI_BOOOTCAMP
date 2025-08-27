## HW2 – SwiftUI Profil Uygulaması (Ödev)

Bu proje, SwiftUI ile hazırlanmış basit bir profil ekranı örneğidir. Bir ödev kapsamında geliştirilmiştir.

### Özellikler
- Animasyonlu degrade başlık (gradient)
- Profil avatarı (varsa varlık, yoksa SF Symbol yedek)
- İstatistik kartları (Takipçi, Takip, Beğeni)
- Genişletilebilir “Hakkımda” bölümü (Daha Fazla/Daha Az)
- Mesaj gönderme sayfası ve animasyonlu Takip et/Takiptesin butonu

### Gereksinimler
- Xcode 15+ (iOS 17 SDK önerilir)
- iOS 16+
- Swift 5.9+

### Kurulum ve Çalıştırma
1. Projeyi açın:
   - `Hw2/Hw2.xcodeproj` dosyasına çift tıklayın
2. Bir simülatör (ör. iPhone 15) veya bağlı cihaz seçin
3. Derleyip çalıştırın:
   - `Cmd + R`

### Proje Yapısı
- `Hw2/Hw2/ContentView.swift`: Ana ekran arayüzü
- `Hw2/Hw2/Hw2App.swift`: Uygulama başlangıç noktası
- `Hw2/Hw2/Assets.xcassets`: Uygulama varlıkları (özel avatar için `profile` görselini ekleyin)

### Özelleştirme
- Başlıktaki metinleri `headerSection` içinde güncelleyebilirsiniz
- `Assets.xcassets` içine `profile` görseli ekleyerek varsayılan avatarı değiştirebilirsiniz
- “Hakkımda” içeriğini `aboutSection` içerisinde düzenleyebilirsiniz

### Ekran Görüntüleri
Ekran görüntülerini şu yapıda ekleyebilirsiniz:
```
docs/
  screenshot-1.png
  screenshot-2.png
```

### Lisans
Bu proje eğitim amaçlıdır. Serbestçe kullanabilir ve değiştirebilirsiniz.


