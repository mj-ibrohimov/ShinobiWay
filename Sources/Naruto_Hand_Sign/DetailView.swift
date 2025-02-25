import SwiftUI

struct DetailView: View {
    let jutsu: Jutsu
    @State private var currentStep = 0
    @State private var showPracticeView = false
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Image("background_detail")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Extra top spacing to push content down
                Spacer().frame(height: 40)
                
                // Jutsu Title
                Text(jutsu.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(jutsu.sequence.enumerated()), id: \.offset) { index, sign in
                        HStack(spacing: 5) {
                            ZStack(alignment: .topTrailing) {
                                HandSignCard(sign: HandSign(name: sign, imageName: sign.lowercased()))
                                    .opacity(currentStep >= index ? 1 : 0.3)
                                    .scaleEffect(currentStep == index ? 1.1 : 1.0)
                                    .padding(.bottom, currentStep == index ? 20 : 0)
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    )
                                    .offset(x: -5, y: 5)
                            }
                            
                            Spacer()
                            if index < jutsu.sequence.count - 1 {
                                Image(systemName: "arrow.right")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 50)
                
                Button(action: {
                    if currentStep < jutsu.sequence.count - 1 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            currentStep += 1
                        }
                    } else {
                        showPracticeView = true
                    }
                }) {
                    Text(currentStep < jutsu.sequence.count - 1 ? "Next Step" : "Try Yourself")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.gray]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: PracticeView(),
                               isActive: $showPracticeView) {
                    EmptyView()
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .tint(.white)
    }
}
