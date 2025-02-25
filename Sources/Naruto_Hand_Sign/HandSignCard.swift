//
//  HandSignCard.swift
//  Naruto_Hand_Sign
//
//  Created by Muhammadjon on 23/02/25.
//

import SwiftUI

// Data model for a hand sign.
struct HandSign: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

// Reusable card view for a hand sign.
struct HandSignCard: View {
    let sign: HandSign
    
    var body: some View {
        VStack {
            Image(sign.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.top, 10)
            Text(sign.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.green,Color.orange]),
                           startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct HandSignGallery4View: View {
    let handSigns: [HandSign] = [
        HandSign(name: "Bird", imageName: "bird"),
        HandSign(name: "Monkey", imageName: "monkey"),
        HandSign(name: "Boar", imageName: "boar"),
        HandSign(name: "OX", imageName: "ox"),
        HandSign(name: "Dog", imageName: "dog"),
        HandSign(name: "Ram", imageName: "ram"),
        HandSign(name: "Dragon", imageName: "dragon"),
        HandSign(name: "Rat", imageName: "rat"),
        HandSign(name: "Hare", imageName: "hare"),
        HandSign(name: "Snake", imageName: "snake"),
        HandSign(name: "Horse", imageName: "horse"),
        HandSign(name: "Tiger", imageName: "tiger"),
        HandSign(name: "Zero", imageName: "zero")
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Image("background_cards")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer().frame(height: 90) 
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(handSigns) { sign in
                            HandSignCard(sign: sign)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Hand Signs")
                    .font(.custom("HelveticaNeue-Bold", size: 44))
                    .foregroundColor(.white)
            }
        }

        
    }

}

struct HandSignGallery4View_Previews: PreviewProvider {
    static var previews: some View {
        HandSignGallery4View()
    }
}
