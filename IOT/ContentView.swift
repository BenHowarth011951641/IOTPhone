//
//  ContentView.swift
//  IOT
//
//  Created by Benjamin Howarth on 11/27/20.
//

import SwiftUI

struct LEDColor {
    private var color: Int = -1

    func getColorText() -> String {
        if self.color <= 0 {
            return "OFF"
        } else {
            return "ON"
        }
    }
    
    mutating func setColor(c: Int) {
        self.color = c
    }

    init() {
        self.color = -1
    }
}

struct ContentView: View {
    
    @State var color = LEDColor()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("LED Light Controller ")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(Color.white)
                            .padding()
                    Text(self.color.getColorText())
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(Color.white)
                            .padding()
                }
                HStack {
                    Button(action: {
                        print("ON Button Pressed!")
                        self.color.setColor(c: 255)
                    }) {
                        Text("ON")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)
                    .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        print("OFF Button Pressed!")
                        self.color.setColor(c: -1)
                    }) {
                        Text("OFF")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)
                    .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            .preferredColorScheme(.dark)        }
    }
}
}
