//
//  ImageCarousel.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI
import Combine

struct ImageCarousel: View {
    let urls: [String]
    let placeholder: String
    var interval: TimeInterval = 4

    @State private var index = 0
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>

    init(urls: [String], placeholder: String, interval: TimeInterval = 4) {
        self.urls = urls
        self.placeholder = placeholder
        self.interval = interval
        _timer = State(initialValue: Timer.publish(every: interval, on: .main, in: .common).autoconnect())
    }

    var body: some View {
        TabView(selection: $index) {
            ForEach(urls.indices, id: \.self) { i in
                AsyncImage(url: URL(string: "http://localhost:4000/images/" + urls[i])) { phase in
                    switch phase {
                    case .success(let img): img.resizable().scaledToFill()
                    default: Image(placeholder).resizable().scaledToFill()
                    }
                }
                .tag(i)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .onReceive(timer) { _ in
            withAnimation(.easeInOut) {
                index = (index + 1) % urls.count
            }
        }
    }
}
