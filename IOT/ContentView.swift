//
//  ContentView.swift
//  IOT
//
//  Created by Benjamin Howarth on 11/27/20.
//

import SwiftUI

struct LEDColor {
    private var color: Color = Color.white
    private var enabled: Bool = true

    func getEnableText() -> String {
        if self.enabled {
            return "ON"
        } else {
            return "OFF"
        }
    }
    
    func getColorText() -> String {
        if self.enabled {
            let colorString = "\(color)"
            let colorArray: [String] = colorString.components(separatedBy: " ")

            if colorArray.count > 1 {
                var r: CGFloat = CGFloat((Float(colorArray[1]) ?? 1))
                var g: CGFloat = CGFloat((Float(colorArray[2]) ?? 1))
                var b: CGFloat = CGFloat((Float(colorArray[3]) ?? 1))

                if (r < 0.0) {r = 0.0}
                if (g < 0.0) {g = 0.0}
                if (b < 0.0) {b = 0.0}

                if (r > 1.0) {r = 1.0}
                if (g > 1.0) {g = 1.0}
                if (b > 1.0) {b = 1.0}

                // Update UIColor
                // Update hex
                let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
                return String(format: "%06X", rgb)
            } else {
                return "FFFFFF"
            }
        } else {
            return "000000"
        }
    }
    
    private func sendRequest() {
        // Create URL
        let url = URL(string: "http://192.168.248.169:8080/" + String(self.getColorText()))
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
    
    mutating func setEnabled(e: Bool) {
        self.enabled = e
        
        sendRequest()
    }

    mutating func setColor(c: Color) {
        self.color = c
        
        print(self.color)
        
        sendRequest()
    }

    init() {
        self.color = Color.white
        self.enabled = true
    }
}

struct ContentView: View {
    
    @State private var color = LEDColor()
    @State private var selectedColor = Color.white
    
    var body: some View {
        VStack {
            ColorPicker("Select Color", selection: $selectedColor)
                .padding([.leading, .bottom, .trailing], 25.0)
                .onChange(of: selectedColor) { newValue in
                    self.color.setColor(c: newValue)}
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                .scaleEffect(CGSize(width: 10, height: 10))
                .labelsHidden()
            VStack {
                VStack {
                    HStack {
                        Text("LED Light Controller ")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                                .padding()
                        Text(self.color.getEnableText())
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                                .padding()
                    }
                    HStack {
                        Button(action: {
                            print("ON Button Pressed!")
                            self.color.setEnabled(e: true)
                        }) {
                            Text("ON")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                        }
                        .padding(.all)
                        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        Button(action: {
                            print("OFF Button Pressed!")
                            self.color.setEnabled(e: false)
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
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            .preferredColorScheme(.dark)        }
    }
}
}
