//
//  AnimatedBArs.swift
//  Kanto
//
//  Created by Antoine Borrelly on 01/07/2023.
//

import SwiftUI

struct AnimatedBArs: View {
    
         
            @State private var drawingHeight = false
         
            var animation: Animation {
                return .linear(duration: 0.5).repeatForever()
            }
         
            var body: some View {
                VStack(alignment: .leading) {
                    HStack(spacing:1) {
                        bar(low: 0.4)
                            .animation(animation.speed(1.5), value: drawingHeight)
                        bar(low: 0.3)
                            .animation(animation.speed(1.2), value: drawingHeight)
                        bar(low: 0.5)
                            .animation(animation.speed(1.0), value: drawingHeight)
                        bar(low: 0.3)
                            .animation(animation.speed(1.7), value: drawingHeight)
                        bar(low: 0.5)
                            .animation(animation.speed(1.0), value: drawingHeight)
                    }
                    .frame(width: 12)
                    .padding(.bottom,7)
                    .onAppear{
                        drawingHeight.toggle()
                    }
                }
                
            }
         
            func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(.lightGray))
                    .frame(height: (drawingHeight ? high : low) * 15)
                    .frame(height: 15, alignment: .bottom)
            }
        }
   


struct AnimatedBArs_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBArs()
    }
}
