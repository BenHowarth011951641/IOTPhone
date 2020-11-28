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
    
    private func sendRequest() {
        // Create URL
        let url = URL(string: "http://192.168.248.35:8000/" + String(self.color))
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            
        }
        task.resume()    }
    
    mutating func setColor(c: Int) {
        self.color = c
        
        sendRequest()
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
