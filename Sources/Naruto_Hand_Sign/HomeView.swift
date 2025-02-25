import SwiftUI

struct Jutsu: Identifiable {
    let id = UUID()
    let name: String
    let thumbnail: String
    var isUnlocked: Bool = false
    let sequence: [String]
}

struct HomeView: View {
    @State private var jutsus: [Jutsu] = [
        Jutsu(name: "Water Dragon Jutsu", thumbnail: "water_dragon_thumb", isUnlocked: true, sequence: ["Tiger", "Ox", "Monkey", "Hare", "Dragon", "Rat", "Bird", "Ox", "Horse", "Monkey"]),
        Jutsu(name: "Dragon Fire Jutsu", thumbnail: "dragon_fire_thumb", isUnlocked: true, sequence: ["Snake", "Dragon", "Hare", "Tiger"]),
        Jutsu(name: "Sandstorm Jutsu", thumbnail: "sandstorm_thumb", isUnlocked: true, sequence: ["Ram", "Monkey", "Dragon", "Bird"]),
        Jutsu(name: "Chidori", thumbnail: "chidori_thumb", isUnlocked: true, sequence: ["Ox", "Hare", "Monkey"]),
        Jutsu(name: "Summoning Jutsu", thumbnail: "summoning_thumb", isUnlocked: true, sequence: ["Boar", "Dog", "Bird", "Monkey", "Ram"]),
        Jutsu(name: "Reanimation Jutsu", thumbnail: "reanimation_thumb", isUnlocked: true, sequence: ["Tiger", "Snake", "Dog"]),
        Jutsu(name: "Phoenix Fire Jutsu", thumbnail: "phoenix_fire_thumb", isUnlocked: false, sequence: ["Rat", "Tiger", "Dog", "Ox", "Hare", "Tiger"]),
        Jutsu(name: "Meteor Strike Jutsu", thumbnail: "meteor_strike_thumb", isUnlocked: false, sequence: ["Snake", "Ox", "Ram", "Dog", "Monkey"]),
        Jutsu(name: "Storm Breaker Jutsu", thumbnail: "storm_breaker_thumb", isUnlocked: false, sequence: ["Tiger", "Ram", "Horse", "Dog"])
    ]

    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 64),
        GridItem(.flexible(), spacing: 64),
        GridItem(.flexible(), spacing: 64)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.7),
                        Color.orange.opacity(0.6),
                        Color.yellow.opacity(0.6),
                        Color.green.opacity(0.6),
                        Color.blue.opacity(0.6),
                        Color.purple.opacity(0.7)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 40) {
                        HStack {
                            HomeHeader()
                            Spacer()
                        }
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(jutsus.indices, id: \.self) { index in
                                let jutsu = jutsus[index]
                                NavigationLink(destination: DetailView(jutsu: jutsu)) {
                                    JutsuCard(jutsu: jutsu)
                                        .overlay(
                                            Group {
                                                if !jutsu.isUnlocked {
                                                    Color.black.opacity(0.5)
                                                    Image(systemName: "lock.fill")
                                                        .font(.largeTitle)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(!jutsu.isUnlocked)
                            }
                        }
                        .padding(.horizontal, 50)
                        
                        if jutsus.contains(where: { !$0.isUnlocked }) {
                            Button(action: unlockNext) {
                                Text("Unlock Next Jutsu")
                                    .font(.headline)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                    )
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 20)
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HandSignGallery4View()) {
                        HStack {
                            
                            Image(systemName: "square.grid.4x3.fill")
                                .foregroundStyle(.blue)
                                .font(.system(size: 30))
                            Spacer(minLength: 27)
                        }
                        
                    }
                }
                
            }
        }
    }
    
    private func unlockNext() {
        if let index = jutsus.firstIndex(where: { !$0.isUnlocked }) {
            jutsus[index].isUnlocked = true
        }
    }
}

struct HomeHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Jutsu Library")
                .font(.custom("Chalkduster", size: 48))
                .foregroundColor(.black)
                .shadow(color: .white, radius: 2, x: 0, y: 2)
            
            Text("Choose your jutsu and master the art of hand signs!")
                .font(.custom("Chalkduster", size: 24))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading) 
        }
        .padding(.top, 50)
        .padding(.horizontal, 50)
    }
}


struct JutsuCard: View {
    let jutsu: Jutsu
    @State private var animate = false
    
    var cardGradient: LinearGradient {
        switch jutsu.name {
        case "Dragon Fire Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Sandstorm Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.brown]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Chidori":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Summoning Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Water Dragon Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Reanimation Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Phoenix Fire Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Meteor Strike Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        case "Storm Breaker Jutsu":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
        default:
            return LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    var body: some View {
        VStack {
            Image(jutsu.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)
            
            Text(jutsu.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
        .background(cardGradient)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 4)
        .scaleEffect(animate ? 1.0 : 0.95)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                animate = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
