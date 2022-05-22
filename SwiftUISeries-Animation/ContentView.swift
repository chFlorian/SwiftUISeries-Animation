// Created by Florian Schweizer on 22.05.22

import SwiftUI

struct ContentView: View {
    @State private var playHeartAnimation: Bool = false
    @State private var playClapAnimation: [Bool] = [false, false]
    
    var body: some View {
        VStack {
            // Twitter Heart Animation
            ZStack {
                Image(systemName: "suit.heart")
                
                Image(systemName: "suit.heart.fill")
                    .foregroundColor(.blue)
                    .scaleEffect(playHeartAnimation ? 1 : 0)
                    .animation(.easeInOut, value: playHeartAnimation)
                
                ForEach(0...15, id: \.self) { _ in
                    let offsets = getRandomOffsets()
                    
                    Circle()
                        .fill(getRandomColor())
                        .frame(width: 3, height: 3)
                        .offset(x: playHeartAnimation ? offsets.0 : 0, y: playHeartAnimation ? offsets.1 : 0)
                        .opacity(playHeartAnimation ? 1 : 0)
                        .animation(.spring().delay(0.25 + .random(in: 0...(0.1))), value: playHeartAnimation)
                }
            }
            .padding(64)
            .border(Color.secondary)
            .contentShape(Rectangle())
            .onTapGesture {
                playHeartAnimation.toggle()
            }
            
            // Clap Animation
            ZStack {
                Image(systemName: "hands.clap.fill")
                
                Image(systemName: "hands.clap.fill")
                    .offset(x: 0, y: playClapAnimation[0] ? -30 : 0)
                    .opacity(playClapAnimation[1] ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: playClapAnimation[0])
                    .animation(.easeInOut(duration: 0.4), value: playClapAnimation[1])
            }
            .padding(64)
            .border(Color.secondary)
            .contentShape(Rectangle())
            .onTapGesture {
                playClapAnimation[0].toggle()
                playClapAnimation[1].toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    playClapAnimation[1].toggle()
                }
            }
        }
    }
    
    private func getRandomColor() -> Color {
        let r = Int.random(in: 0...4)
        switch r {
            case 0:
                return .red
            case 1:
                return .orange
            case 2:
                return .yellow
            case 3:
                return .green
            default:
                return .blue
        }
    }
    
    private func getRandomOffsets() -> (CGFloat, CGFloat) {
        let possibilities: [CGFloat] = [-12, -11, -10, -9, -8, 8, 9, 10, 11, 12]
        return (possibilities.randomElement()!, possibilities.randomElement()!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
