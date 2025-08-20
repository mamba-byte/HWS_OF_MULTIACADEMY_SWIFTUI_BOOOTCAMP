//
//  main.swift
//  HW1
//
//  Created by İsmail Can Durak on 20.08.2025.
//


import Foundation

func printHeader(_ text: String) {
    let line = String(repeating: "=", count: text.count + 4)
    print("\n\(line)")
    print("| \(text) |")
    print("\(line)\n")
}

func showMenu() {
    printHeader("SWIFT HOMEWORK MENU")
    print("1: Ödev 1.1 – Değişkenler ve Veri Tipleri")
    print("2: Ödev 1.2 – Fonksiyonlar ve Closure'lar")
    print(" 0 Çıkış")
    print("\nSeçiminiz: ", terminator: "")
}

// Homework 1.1
func personalInfoCard() {
    printHeader("KİŞİSEL BİLGİ KARTI")
    
    let name: String = "İsmail Can Durak"
    let age: Int = 25
    let height: Double = 1.95
    let isStudent: Bool = true
    let graduationYear: Int? = 2026
    let phoneNumber: String? = "****434314***"
    
    print("İsim: \(name)")
    print(" Yaş: \(age)")
    print("Boy: \(height) m")
    
    if(isStudent==true) {
        print(" Öğrenci mi:  Evet")
    }
    else {
        print(" Öğrenci mi:  Hayır")
    }
    
    if let graduation = graduationYear {
        print("Mezuniyet Yılı: \(graduation)")
    } else {
        print(" Mezuniyet Yılı: Belirtilmemiş")
    }
    
    print("Telefon: \(phoneNumber ?? "Belirtilmemiş")")
}

func calculator() {
    printHeader("HESAP MAKİNESİ")
    
    func calculate(_ a: Double, _ b: Double, operation: String) -> Double {
        switch operation {
        case "+": return a + b
        case "-": return a - b
        case "*": return a * b
        case "/": return b != 0 ? a / b : Double.nan
        default: return 0
        }
    }
    
    print("İşlem: 10 + 5 = \(calculate(10, 5, operation: "+"))")
    print("İşlem: 10 - 5 = \(calculate(10, 5, operation: "-"))")
    print("İşlem: 10 * 5 = \(calculate(10, 5, operation: "*"))")
    print("İşlem: 10 / 5 = \(calculate(10, 5, operation: "/"))")
    print("İşlem: 10 / 0 = \(calculate(10, 0, operation: "/"))")
    
    let numbers = [23, 12, 55, 7, 88, 42, 9, 16]
    
    let filteredAndSorted = numbers
        .filter { $0 > 15 }
        .sorted { $0 < $1 }
    
    print("\nDİZİ İŞLEMLERİ")
    print("Orijinal dizi: \(numbers)")
    print("15'ten büyük sayılar (küçükten büyüğe): \(filteredAndSorted)")
}

func main() {
    var running = true
    
    while running {
        showMenu()
        if let choice = readLine() {
            switch choice {
            case "1":
                personalInfoCard()
            case "2":
                calculator()
            case "0":
                running = false
                print("Programdan çıkılıyor...")
            default:
                print("Geçersiz seçim, lütfen tekrar deneyin.")
            }
            
            if running && choice != "0" {
                print("\nDevam etmek için Enter tuşuna basın...")
                _ = readLine()
            }
        }
    }
}

main()


