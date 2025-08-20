# Swift Ödev 1 - Temel Kavramlar ve Örnekler

## Genel Bakış
Bu proje, değişkenler, veri tipleri, fonksiyonlar, closure'lar, kontrol akışı ve temel program yapısı dahil olmak üzere temel Swift programlama kavramlarını göstermektedir.

## Proje Yapısı

### Ana Bileşenler
- **main.swift**: Tüm fonksiyonları ve program mantığını içeren ana program dosyası
- **Etkileşimli Menü Sistemi**: Kullanıcı odaklı program yürütme
- **İki Ana Ödev Bölümü**: Kişisel Bilgi Kartı ve Hesap Makinesi

---

## 1. Temel Swift Kavramları

### Import İfadesi
```swift
import Foundation
```
- **Foundation**: Temel işlevsellik sağlayan ana Swift framework'ü
- **Import**: Dış modülleri/framework'leri kodunuza dahil eder

### Fonksiyon Tanımlama
```swift
func fonksiyonAdi(parametreler) -> DönüşTipi {
    // fonksiyon gövdesi
}
```

---

## 2. Yardımcı Fonksiyonlar

### printHeader Fonksiyonu
```swift
func printHeader(_ text: String) {
    let line = String(repeating: "=", count: text.count + 4)
    print("\n\(line)")
    print("| \(text) |")
    print("\(line)\n")
}
```

**Anahtar Kavramlar:**
- **String Interpolation**: `\(değişken)` değerleri string'lere gömme sözdizimi
- **String Metodları**: `repeating:count:` tekrarlanan karakterler oluşturur
- **Parametre Etiketleri**: `_` harici parametre adı gerekmediği anlamına gelir

### showMenu Fonksiyonu
```swift
func showMenu() {
    printHeader("SWIFT HOMEWORK MENU")
    print("1: Ödev 1.1 – Değişkenler ve Veri Tipleri")
    print("2: Ödev 1.2 – Fonksiyonlar ve Closure'lar")
    print(" 0 Çıkış")
    print("\nSeçiminiz: ", terminator: "")
}
```

**Anahtar Kavramlar:**
- **print with terminator**: `terminator: ""` otomatik satır sonunu engeller
- **Menü Odaklı Arayüz**: Kullanıcı numaralı menüden seçim yapar

---

## 3. Ödev 1.1: Değişkenler ve Veri Tipleri

### personalInfoCard Fonksiyonu
```swift
func personalInfoCard() {
    let name: String = "İsmail Can Durak"
    let age: Int = 25
    let height: Double = 1.95
    let isStudent: Bool = true
    let graduationYear: Int? = 2026
    let phoneNumber: String? = "****434314***"
}
```

**Veri Tipleri Açıklaması:**
- **String**: Metin verisi (örn. isimler, adresler)
- **Int**: Tam sayılar (pozitif, negatif veya sıfır)
- **Double**: Ondalıklı sayılar (kayan nokta hassasiyeti ile)
- **Bool**: Boolean değerler (true/false)
- **Optional Tipler (Int?, String?)**: Bir değer içerebilir veya nil (değer yok) olabilir

**Değişken Tanımlama:**
- **let**: Sabitler (değişmez - değiştirilemez)
- **var**: Değişkenler (değişebilir - değiştirilebilir)

### Koşullu İfadeler
```swift
if(isStudent==true) {
    print(" Öğrenci mi:  Evet")
} else {
    print(" Öğrenci mi:  Hayır")
}
```

**Anahtar Kavramlar:**
- **if-else**: Boolean ifadelere dayalı koşullu yürütme
- **Karşılaştırma Operatörleri**: `==` eşitlik karşılaştırması için
- **Boolean Mantığı**: Doğrudan boolean kontrolleri

### Optional İşleme
```swift
if let graduation = graduationYear {
    print("Mezuniyet Yılı: \(graduation)")
} else {
    print(" Mezuniyet Yılı: Belirtilmemiş")
}

print("Telefon: \(phoneNumber ?? "Belirtilmemiş")")
```

**Optional Kavramları:**
- **Optional Binding**: `if let` optional değerleri güvenli şekilde açar
- **Nil Coalescing**: `??` optional nil ise varsayılan değer sağlar

---

## 4. Ödev 1.2: Fonksiyonlar ve Closure'lar

### calculator Fonksiyonu
```swift
func calculator() {
    func calculate(_ a: Double, _ b: Double, operation: String) -> Double {
        switch operation {
        case "+": return a + b
        case "-": return a - b
        case "*": return a * b
        case "/": return b != 0 ? a / b : Double.nan
        default: return 0
        }
    }
}
```

**İç İçe Fonksiyonlar:**
- **Yerel Fonksiyon**: Başka bir fonksiyon içinde tanımlanan fonksiyon
- **Kapsam**: Sadece üst fonksiyon içinde erişilebilir

### Switch İfadesi
```swift
switch operation {
case "+": return a + b
case "-": return a - b
case "*": return a * b
case "/": return b != 0 ? a / b : Double.nan
default: return 0
}
```

**Switch Kavramları:**
- **Desen Eşleştirme**: Değeri birden fazla durumla karşılaştırır
- **Varsayılan Durum**: Eşleşmeyen değerleri işler
- **Erken Dönüş**: Fonksiyonlar return çağrıldığında hemen çıkar

### Üçlü Operatör
```swift
return b != 0 ? a / b : Double.nan
```

**Üçlü Sözdizimi:**
- **Format**: `koşul ? doğruysaDeğer : yanlışsaDeğer`
- **Sıfıra Bölme**: Güvenlik için `Double.nan` (Sayı Değil) döndürür

### Closure'larla Dizi İşlemleri
```swift
let numbers = [23, 12, 55, 7, 88, 42, 9, 16]

let filteredAndSorted = numbers
    .filter { $0 > 15 }
    .sorted { $0 < $1 }
```

**Closure Kavramları:**
- **Dizi Metodları**: `filter` ve `sorted` yüksek dereceli fonksiyonlardır
- **Closure Sözdizimi**: `{ $0 > 15 }` `{ number in number > 15 }` için kısa yoldur
- **$0, $1**: Closure parametreleri için kısa argüman adları
- **Metod Zincirleme**: Birden fazla işlem zincirlenebilir

**Adım Adım Süreç:**
1. **Filtreleme**: `{ $0 > 15 }` sadece 15'ten büyük sayıları tutar
2. **Sıralama**: `{ $0 < $1 }` artan sırada sıralar
3. **Sonuç**: `[16, 23, 42, 55, 88]`

---

## 5. Ana Program Yapısı

### Main Fonksiyonu
```swift
func main() {
    var running = true
    
    while running {
        showMenu()
        if let choice = readLine() {
            switch choice {
            case "1": personalInfoCard()
            case "2": calculator()
            case "0": running = false
            default: print("Geçersiz seçim, lütfen tekrar deneyin.")
            }
        }
    }
}
```

**Program Akışı:**
1. **Sonsuz Döngü**: `while running` kullanıcı çıkmayı seçene kadar devam eder
2. **Kullanıcı Girişi**: `readLine()` klavye girişini yakalar
3. **Switch İfadesi**: Kullanıcı seçimini uygun fonksiyona yönlendirir
4. **Çıkış Koşulu**: `running = false` yapmak döngüyü kırar

### Giriş İşleme
```swift
if let choice = readLine() {
    // seçimi işle
}
```

**Anahtar Kavramlar:**
- **readLine()**: Standart girişten bir satır metin okur
- **Optional Binding**: Giriş string'ini güvenli şekilde açar
- **Kullanıcı Etkileşimi**: Program kullanıcı girişini bekler

---

## 6. Swift En İyi Uygulamaları

### Kod Organizasyonu
- **Tek Sorumluluk**: Her fonksiyonun tek net amacı vardır
- **Modüler Tasarım**: Fonksiyonlar bağımsız olarak test edilebilir ve değiştirilebilir
- **Net İsimlendirme**: Fonksiyon adları ne yaptıklarını açıklar

### Hata İşleme
- **Güvenli Bölme**: Sıfıra bölmeyi engeller
- **Optional Güvenliği**: Nil değerleri zarif şekilde işler
- **Giriş Doğrulama**: Kullanıcı girişini kontrol eder

### Performans Hususları
- **Verimli Döngüler**: Net çıkış koşulu ile while döngüsü
- **Bellek Yönetimi**: Swift belleği otomatik olarak yönetir
- **String İşlemleri**: Verimli string interpolation

---

## 7. Programı Çalıştırma

### Yürütme
```swift
main()
```
- **Giriş Noktası**: Program main() fonksiyonundan yürütmeye başlar
- **Etkileşimli Mod**: Kullanıcı menüden seçenek seçer
- **Zarif Çıkış**: Temiz program sonlandırma

### Kullanıcı Deneyimi
- **Net Menü**: Kolay seçim için numaralı seçenekler
- **Görsel Geri Bildirim**: Başlıklar ve formatlanmış çıktı
- **İşlemler Arası Duraklama**: Kullanıcının sonuçları okumasına izin verir

---

## 8. Öğrenme Çıktıları

Bu proje şunları kapsar:
- ✅ **Temel Swift Sözdizimi**: Fonksiyonlar, değişkenler, sabitler
- ✅ **Veri Tipleri**: String, Int, Double, Bool, Optionals
- ✅ **Kontrol Akışı**: if-else, switch, while döngüleri
- ✅ **Fonksiyonlar**: Tanımlama, parametreler, dönüş değerleri
- ✅ **Closure'lar**: Temel closure sözdizimi ve kullanımı
- ✅ **Diziler**: Oluşturma, filtreleme, sıralama
- ✅ **Kullanıcı Girişi**: Okuma ve işleme
- ✅ **Program Yapısı**: Ana fonksiyon, menü sistemi
- ✅ **Hata İşleme**: Güvenli işlemler ve giriş doğrulama

---

## 9. Öğrenme İçin Sonraki Adımlar

Bu kodu anladıktan sonra şunları keşfetmeyi düşünün:
- **Sınıflar ve Yapılar**: Nesne yönelimli programlama
- **Protokoller**: Arayüz tanımları ve uyumluluk
- **Hata İşleme**: Try-catch mekanizmaları
- **Generics**: Tip bağımsız kod
- **Bellek Yönetimi**: ARC ve referans döngüleri
- **iOS Geliştirme**: UIKit ve SwiftUI framework'leri

---

*Bu dokümantasyon, pratik örnekler aracılığıyla Swift programlama kavramlarını anlamak için bir temel sağlar.*
