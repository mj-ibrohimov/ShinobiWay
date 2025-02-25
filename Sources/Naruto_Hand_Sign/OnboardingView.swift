import SwiftUI

struct OnboardingSlide: Identifiable {
    let id = UUID()
    let systemImageName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    private let slides: [OnboardingSlide] = [
        OnboardingSlide(
            systemImageName: "hand.wave",
            title: "Master the Hand Signs",
            description: "Learn the iconic hand signs from Naruto and begin your journey to mastering jutsu."
        ),
        OnboardingSlide(
            systemImageName: "hand.thumbsup.fill",
            title: "Real-Time Feedback",
            description: "Our CoreML-powered system analyzes your hand signs in real time, guiding you step by step."
        ),
        OnboardingSlide(
            systemImageName: "music.note.list",
            title: "Practice with Music",
            description: "Sync your movements with interactive music to boost your flow and precision."
        )
    ]
    
    var body: some View {
        ZStack {
            Image("Onboarding_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        GeometryReader { geometry in
                            VStack(spacing: 20) {
                                Image(systemName: slides[index].systemImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .padding()
                                    .background(Circle().fill(Color.white.opacity(0.3)).frame(width: 180, height: 180).shadow(radius: 10))
                                    .scaleEffect(geometry.frame(in: .global).minY < 400 ? 1.1 : 1.0)
                                    .animation(.spring(), value: geometry.frame(in: .global).minY)
                                Text(slides[index].title)
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.yellow)
                                Text(slides[index].description)
                                    .font(.system(size: 24))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.yellow)
                                    .padding(.horizontal)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .animation(.easeInOut, value: currentPage)
                HStack {
                    Button(action: {
                        if currentPage > 0 { currentPage -= 1 }
                    }) {
                        Text("Back")
                            .foregroundColor(currentPage == 0 ? .gray : .black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color.white.opacity(0.5)))
                    }
                    .disabled(currentPage == 0)
                    Spacer()
                    Button(action: { hasSeenOnboarding = true }) {
                        Text("Skip")
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color.white.opacity(0.5)))
                    }
                    Spacer()
                    if currentPage == slides.count - 1 {
                        Button(action: { hasSeenOnboarding = true }) {
                            Text("Get Started")
                                .bold()
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Capsule().fill(Color.white.opacity(0.5)))
                        }
                    } else {
                        Button(action: { currentPage += 1 }) {
                            Text("Next")
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Capsule().fill(Color.white.opacity(0.5)))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
