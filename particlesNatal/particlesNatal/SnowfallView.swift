//
//  SnowfallView.swift
//  particlesNatal
//
//  Created by Gustavo Cosme on 23/12/24.
//

import SwiftUI

struct SnowfallView: View {
    @State private var snowflakes: [Snowflake] = []
    private let snowflakeCount = 300

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(snowflakes) { snowflake in
                    Circle()
                        .fill(Color.white)
                        .frame(width: snowflake.size, height: snowflake.size)
                        .position(x: snowflake.x, y: snowflake.y)
                        .opacity(snowflake.opacity)
                        .animation(.linear(duration: snowflake.duration).repeatForever(autoreverses: false), value: snowflake.y)
                }
            }
            .onAppear {
                for _ in 0..<snowflakeCount {
                    let flake = Snowflake(
                        id: UUID(),
                        x: Double.random(in: 0...geometry.size.width),
                        y: Double.random(in: -geometry.size.height...0),
                        size: Double.random(in: 2...6),
                        opacity: Double.random(in: 0.5...1.0),
                        duration: Double.random(in: 3...10)
                    )
                    snowflakes.append(flake)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        snowflakes.indices.forEach { index in
                            snowflakes[index].y += geometry.size.height + 50
                        }
                    }
                }
            }
        }
        .background(Color.blue.opacity(0.8))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Snowflake: Identifiable {
    let id: UUID
    var x: Double
    var y: Double
    let size: Double
    let opacity: Double
    let duration: Double
}

struct SnowfallView_Previews: PreviewProvider {
    static var previews: some View {
        SnowfallView()
    }
}

