import SwiftUI

struct IntroScreenView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top Image
            Image("intro_banner")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height * 0.60)
                .clipped()
            
            // Bottom Overlay
            ZStack {
                Color.white                             .cornerRadius(60, corners: [.topLeft, .topRight])
                    .shadow(color: .gray.opacity(0.1), radius: 10, y: -5)

                // Content inside overlay
                VStack {
                    // Title
                    VStack(spacing: 0) {
                        Text("Swipe to make an")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)

                        Text("impact")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "#4CAF50"))

                        Text("One project at a time")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                    // Subtitle
                    Text("Discover and support global sustainability projects near you.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.horizontal, 30)

                    // Get Started Button
                    NavigationLink(destination: LoginView()) {
                        Text("Get Started")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#4CAF50"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 30)

                    Spacer()
                }
                .padding(.top, 50)
            }
            .frame(maxWidth: 404)
            .offset(y: -60)
            .frame(height: 440)
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    NavigationView {
        IntroScreenView()
    }
}
