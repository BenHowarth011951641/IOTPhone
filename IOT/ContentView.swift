//
//  ContentView.swift
//  IOT
//
//  Created by Benjamin Howarth on 11/27/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text("LED Light Control")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(Color.white)
                            .padding()
                }
                HStack {
                    Button(action: {}) {
                        Text("On")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                    }
                    .padding(.all)
                    .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    Button(action: {}) {
                        Text("Off")
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
                .preferredColorScheme(.dark)
        }
    }
}
}
