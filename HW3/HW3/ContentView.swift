//
//  ContentView.swift
//  HW3
//
//  Created by İsmail Can Durak on 30.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            // Static gradient background
            LinearGradient(
                colors: [
                    Color.blue,
                    Color.purple,
                    Color.pink,
                    Color.orange,
                    Color.yellow,
                    Color.green,
                    Color.blue
                ],
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 1, y: 1)
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Counter display
                Text("\(counter)")
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                
                // Buttons
                HStack(spacing: 30) {
                    // Decrement button
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            counter -= 1
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    
                    // Increment button
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            counter += 1
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                }
                
                // Reset button
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        counter = 0
                    }
                }) {
                    Text("Reset")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.black.opacity(0.3))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )
                        )
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
