//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jessica Lewinter on 09/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

final class User: ObservableObject, Codable {
    @Published var name: String = "freddy"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results: [Result] = []
    @State var username: String = ""
    @State var email: String = ""
    
    func load() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=frank+ocean&entity=song") else {
            print("The url is invalid")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error fetching: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                } catch {
                    print("Could not decode data. Error: \(error.localizedDescription)")
                }
            }
        }
        
        dataTask.resume()
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }
                Section {
                    Button("Create account") {
                        print("account created")
                    }.disabled(username.isEmpty || email.isEmpty)
                }
            }
            
            List(results, id: \.trackId) { (result: Result) in
                VStack(alignment: .leading) {
                    Text(result.trackName)
                        .font(.headline)
                    Text(result.collectionName)
                }
            }.onAppear(perform: load)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
