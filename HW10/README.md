# HW10 - Pokemon App with PokeAPI

## Proje Açıklaması

Bu proje, SwiftUI kullanarak PokeAPI'den veri çeken modern bir iOS uygulamasıdır. Uygulama, Pokemon listesini görüntüler, arama özelliği sunar ve her Pokemon için detaylı bilgiler gösterir. Ödev gereksinimlerini karşılamak amacıyla geliştirilmiştir ve tüm bonus özellikler dahil edilmiştir.

## Kullanılan API

**PokeAPI**: https://pokeapi.co/api/v2/

Bu ücretsiz ve açık kaynak API, Pokemon verilerini sağlamaktadır. Uygulama aşağıdaki endpoint'leri kullanmaktadır:
- Pokemon listesi için: `/pokemon` endpoint'i
- Pokemon detayları için: `/pokemon/{name}` endpoint'i

## Uygulama Özellikleri

### Temel Özellikler
- **API Entegrasyonu**: PokeAPI'den Pokemon verilerini çekme
- **Model Katmanı**: Codable protokolü ile JSON decode işlemi
- **Networking**: URLSession ile modern async/await kullanımı
- **UI Katmanı**: SwiftUI List ile veri görüntüleme
- **Hata Yönetimi**: Network ve decode hataları için kullanıcı dostu mesajlar

### Ek Özellikler
- **Arama/Filter**: Pokemon isimlerine göre gerçek zamanlı arama
- **Detay Sayfası**: Her Pokemon için kapsamlı detay görünümü
- **Asenkron Görsel Yükleme**: AsyncImage ile Pokemon sprite'larını gösterme
- **Pull-to-Refresh**: Aşağı çekerek yenileme özelliği
- **Modern UI**: Renkli tip kartları ve progress bar'lar

## Proje Mimarisi

### Model Katmanı (PokemonModels.swift)
Uygulamanın veri modeli katmanını oluşturan dosyadır. API'den gelen JSON verilerini Swift struct'larına dönüştürmek için Codable protokolü kullanılmıştır.

- `PokemonListResponse`: API'den gelen liste yanıtı
- `PokemonDetail`: Pokemon detay verileri
- `PokemonSprites`: Pokemon görselleri
- `PokemonType`, `PokemonAbility`, `PokemonStat`: İlgili alt modeller

### Networking Katmanı (PokemonService.swift)
API isteklerini yöneten ve veri çekme işlemlerini gerçekleştiren servis katmanıdır.

- `PokemonService`: API istekleri için singleton service
- `PokemonAPIError`: Özel hata türleri
- `PokemonViewModel`: UI state yönetimi

### UI Katmanı
Kullanıcı arayüzünü oluşturan SwiftUI bileşenleridir.

- `ContentView`: Ana liste görünümü
- `PokemonRowView`: Liste satırı bileşeni
- `PokemonDetailView`: Pokemon detay sayfası

## Kullanım Kılavuzu

1. Uygulama açıldığında otomatik olarak Pokemon listesi yüklenir
2. Arama çubuğunu kullanarak Pokemon isimlerine göre filtreleme yapabilirsiniz
3. Herhangi bir Pokemon'a dokunarak detay sayfasını açabilirsiniz
4. Detay sayfasında Pokemon'un tüm özelliklerini görebilirsiniz

## Teknik Bilgiler

- **Platform**: iOS 15.0+
- **Framework**: SwiftUI
- **API**: PokeAPI v2
- **Networking**: URLSession + async/await
- **Image Loading**: AsyncImage
- **State Management**: @StateObject, @Published

## Gereksinimler Karşılanma Durumu

Ödev gereksinimlerinin tümü başarıyla karşılanmıştır:

- API seçimi (PokeAPI)
- Model katmanı (Codable struct'lar)
- Networking katmanı (URLSession)
- UI katmanı (List/ScrollView)
- Hata durumları yönetimi
- Arama/filter özelliği
- Detay sayfası
- Asenkron görsel yükleme

## Kullanıcı Arayüzü Özellikleri

Uygulama modern ve kullanıcı dostu bir arayüze sahiptir. Renkli Pokemon tip kartları, progress bar'larla stat gösterimi, loading ve error state'leri gibi özellikler kullanıcı deneyimini geliştirmektedir. Pull-to-refresh desteği ve responsive tasarım ile kullanım kolaylığı sağlanmıştır.

## Ekran Yapısı

Uygulama aşağıdaki ana ekranları içerir:

1. **Ana Liste**: Pokemon listesi ve arama çubuğu
2. **Detay Sayfası**: Pokemon görseli, temel bilgiler, tipler, yetenekler ve statlar
3. **Loading State**: Yükleme göstergesi
4. **Error State**: Hata mesajları ve tekrar deneme butonu
