//
//  ContentView.swift
//  Hw2
//
//  Created by İsmail Can Durak on 27.08.2025.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isFollowing: Bool = false
    @State private var showMessageSheet: Bool = false
    @State private var animateGradient: Bool = false
    @State private var isAboutExpanded: Bool = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                headerSection

                profileSection

                infoCardsSection

                aboutSection

                Divider()
                    .padding(.horizontal)

                buttonsSection

            }
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
    }

    private var headerSection: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple, Color.blue, Color.cyan],
                startPoint: animateGradient ? .topLeading : .bottomTrailing,
                endPoint: animateGradient ? .bottomTrailing : .topLeading
            )
            .frame(height: 180)
            .animation(.linear(duration: 6).repeatForever(autoreverses: true), value: animateGradient)
            .onAppear { animateGradient = true }
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .fill(.ultraThinMaterial)
                    .opacity(0.05)
            )

            VStack(spacing: 12) {
                Text("Mamba-Byte")
                    .font(.title2.bold())
                    .foregroundColor(.white.opacity(0.9))
                Text("HW2")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .offset(y: -15)
            }
            .padding(.top, 8)
        }
        .overlay(alignment: .bottom) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 132, height: 132)
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 8)

                Group {
                    if let uiImage = UIImage(named: "profile") {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(30)
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            }
            .offset(y: 60)
        }
        .padding(.bottom, 68)
    }

    private var profileSection: some View {
        VStack(spacing: 6) {
            Text("İsmail Can Durak")
                .font(.title2.weight(.semibold))
            Text("iOS Developer • SwiftUI • UIkit • Ceng Student")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }

    private var infoCardsSection: some View {
        HStack(spacing: 12) {
            InfoCard(value: "1.2K", title: "Takipçi")
            InfoCard(value: "348", title: "Takip")
            InfoCard(value: "9.8K", title: "Beğeni")
        }
        .padding(.horizontal)
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Hakkımda")
                    .font(.headline)
                Spacer()
                Button(action: { withAnimation(.easeInOut) { isAboutExpanded.toggle() } }) {
                    Label(isAboutExpanded ? "Daha Az" : "Daha Fazla", systemImage: isAboutExpanded ? "chevron.up" : "chevron.down")
                        .labelStyle(.titleAndIcon)
                        .font(.subheadline)
                }
                .buttonStyle(.bordered)
            }
            Group {
                Text(
                    "Bilgisayar Mühendisliği öğrencisiyim. Frontend (HTML, CSS, Bootstrap, JavaScript), mobil (Swift, SwiftUI) ve backend geliştirme (.NET, Python, C, C++, C#, Bash, Assembly) alanlarında deneyimliyim. MySQL, SQL, Firebase ve CoreData ile veritabanı yönetimi yapabiliyorum. Unreal Engine 5 ile oyun geliştirme ve Git, GitHub, GitLab, Docker gibi araçlarla versiyon kontrolü konusunda yetkinim. Agile, Scrum ve Kanban metodolojilerini ekip çalışmalarında uyguluyorum"
                )
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(isAboutExpanded ? nil : 4)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .padding(.horizontal)
    }

    private var buttonsSection: some View {
        VStack(spacing: 12) { actionButtons }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 24)
    }

    @ViewBuilder
    private var actionButtons: some View {
        Button(action: { showMessageSheet = true }) {
            Label("Mesaj Gönder", systemImage: "paperplane.fill")
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .sheet(isPresented: $showMessageSheet) {
            MessageSheetView()
        }

        Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                isFollowing.toggle()
            }
        }) {
            Label(isFollowing ? "Takiptesin" : "Takip Et", systemImage: isFollowing ? "checkmark.circle.fill" : "plus.circle.fill")
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
        .buttonStyle(.bordered)
        .tint(isFollowing ? .green : .purple)
        .scaleEffect(isFollowing ? 1.04 : 1.0)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isFollowing)
        .symbolEffect(.bounce, value: isFollowing)
    }


}

#Preview {
    ContentView()
}


struct InfoCard: View {
    let value: String
    let title: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.bold())
                .foregroundColor(.primary)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

struct MessageSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextEditor(text: $messageText)
                    .frame(minHeight: 180)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .padding(.horizontal)

                Button {
                    dismiss()
                } label: {
                    Label("Gönder", systemImage: "paperplane.fill")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .navigationTitle("Mesaj Gönder")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") { dismiss() }
                }
            }
        }
    }
}
