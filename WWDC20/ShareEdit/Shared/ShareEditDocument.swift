//
//  ShareEditDocument.swift
//  Shared
//
//  Created by Jessica Lewinter on 25/06/20.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var sharedEditDocument: UTType {
        UTType(importedAs: "com.example.SharedEdit.shapes")
    }
}

struct ShareEditDocument: FileDocument, Codable {
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.sharedEditDocument] }

    init(fileWrapper: FileWrapper, contentType: UTType) throws {
        guard let data = fileWrapper.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
        let data = try JSONEncoder().encode(self)
        fileWrapper = FileWrapper(regularFileWithContents: data)
    }
}
