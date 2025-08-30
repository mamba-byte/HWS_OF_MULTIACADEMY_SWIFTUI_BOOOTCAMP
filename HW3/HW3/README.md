# HW3 - SwiftUI Sayaç Uygulaması ve Animasyonlu Gradient

## Proje Genel Bakış
SwiftUI ile geliştirilmiş, `@State` property wrapper kullanarak durum yönetimini ve animasyonlu gradient arka planları gösteren basit bir sayaç uygulaması.

## Özellikler

### Temel İşlevsellik
- **Sayaç Görüntüleme**: Büyük, belirgin sayaç değeri görüntüleme
- **Artırma Butonu**: Sayacı 1 artırır
- **Azaltma Butonu**: Sayacı 1 azaltır  
- **Sıfırlama Butonu**: Sayacı 0'a döndürür

### Görsel Öğeler
- **Animasyonlu Gradient Arka Plan**: 7 renkli dönen gradient (mavi, mor, pembe, turuncu, sarı, yeşil, mavi)
- **Yumuşak Animasyonlar**: Buton etkileşimleri için yay animasyonları
- **Modern Arayüz**: Gölgeler ve yuvarlatılmış köşeler ile temiz tasarım
- **Duyarlı Düzen**: Farklı cihazlar için uygun boşluk ve boyutlandırma

## Teknik Uygulama

### Durum Yönetimi
```swift
@State private var counter = 0
@State private var gradientRotation: Double = 0
```

### Ana Bileşenler
- **ZStack**: Arka plan ve içerik ile katmanlı düzen
- **LinearGradient**: Çok renkli gradient arka plan
- **VStack & HStack**: Dikey ve yatay içerik organizasyonu
- **Button**: Özel stillendirilmiş etkileşimli öğeler

### Animasyon Detayları
- **Gradient Döndürme**: 10 saniyede 360° döndürme, sonsuz tekrar
- **Buton Animasyonları**: Özel yanıt ve sönümleme ile yay animasyonları
- **Yumuşak Geçişler**: Tüm durum değişiklikleri animasyonlu

## Arayüz Bileşenleri

#### Sayaç Görüntüleme
- Büyük yuvarlatılmış font (80pt)
- Gölge efektleri ile beyaz metin
- Vurgu için kalın ağırlık

#### Aksiyon Butonları
- **Artı/Eksi**: SF Symbols ikonları (60pt)
- **Sıfırla**: Yuvarlatılmış arka plan ile özel stillendirilmiş buton
- Tüm butonlar gölge efektleri ve yumuşak animasyonlar içerir

#### Arka Plan
- Tam ekran gradient kaplama
- Sürekli döndürme animasyonu
- İmmersif deneyim için güvenli alanı yok sayar

## Kullanım

1. **Uygulamayı başlat** - Animasyonlu gradient arka planı görüntüle
2. **+ butonuna dokun** - Sayacı artır
3. **- butonuna dokun** - Sayacı azalt  
4. **Sıfırla'ya dokun** - Sayacı 0'a döndür
5. **Arka planı izle** - Sürekli dönen gradientin keyfini çıkar

## Gereksinimler

- **Platform**: iOS 14.0+
- **Framework**: SwiftUI
- **Dil**: Swift 5.0+
- **Xcode**: 12.0+

## Proje Yapısı

```
HW3/
├── ContentView.swift      # Ana uygulama arayüzü
├── HW3App.swift          # Uygulama giriş noktası
├── Assets.xcassets/      # Uygulama kaynakları
└── README.md            # Bu dokümantasyon
```

## Öğrenme Hedefleri

Bu proje şunları gösterir:
- **@State Property Wrapper**: SwiftUI'da yerel durum yönetimi
- **Animasyonlar**: Yumuşak, etkileyici kullanıcı deneyimleri oluşturma
- **Düzen**: Karmaşık düzenler için ZStack, VStack ve HStack kullanımı
- **Özel Stilleme**: Gölgeler, gradientler ve özel buton tasarımları uygulama
- **Kullanıcı Etkileşimi**: Buton dokunuşları ve durum güncellemelerini işleme

## Gelecek Geliştirmeler

Potansiyel iyileştirmeler şunları içerebilir:
- Buton etkileşimleri için ses efektleri
- Dokunsal geri bildirim
- Sayaç geçmişi/kayıt
- Özel renk temaları
- Erişilebilirlik iyileştirmeleri
- Birim testleri

---

**Oluşturan**: İsmail Can Durak  
**Tarih**: 30 Ağustos 2025  
**Kurs**: SwiftUI Bootcamp - MultiAcademy
