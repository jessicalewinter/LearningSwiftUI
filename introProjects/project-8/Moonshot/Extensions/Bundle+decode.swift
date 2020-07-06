//
//  Bundle+decode.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 02/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import Foundation

enum DecodeErrors: Error {
    case invalidURL
    case failedLoad
    case failedDecode
    
    var info: String {
        switch self {
        case .invalidURL:
            return "Failed to locate in bundle."
        case .failedLoad:
            return "Failed to load from bundle."
        case .failedDecode:
            return "Failed to decode from bundle."
        }
    }
}

protocol Decodable {
    func decode<Model: Codable>(_ file: String) throws -> Model
}


extension Bundle: Decodable {
    func decode<Model: Codable>(_ file: String) throws -> Model  {
        guard let url = url(forResource: file, withExtension: nil) else {
            throw DecodeErrors.invalidURL
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw DecodeErrors.failedLoad
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loadedFile = try? decoder.decode(Model.self, from: data) else {
            throw DecodeErrors.failedDecode
        }
        
        return loadedFile
    }
}
