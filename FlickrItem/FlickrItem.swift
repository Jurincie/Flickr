//
//  FlickrItem.swift
//  FlickrItem
//
//  Created by Ron Jurincie on 7/6/24.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

// MARK: - Welcome
struct Welcome: Codable, Sendable {
    let title: String
    let link: String
    let description: String
    let modified: Date
    let generator: String
    let items: [Item]
}

// MARK: Welcome convenience initializers and mutators

extension Welcome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Welcome.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        title: String? = nil,
        link: String? = nil,
        description: String? = nil,
        modified: Date? = nil,
        generator: String? = nil,
        items: [Item]? = nil
    ) -> Welcome {
        return Welcome(
            title: title ?? self.title,
            link: link ?? self.link,
            description: description ?? self.description,
            modified: modified ?? self.modified,
            generator: generator ?? self.generator,
            items: items ?? self.items
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Item
struct Item: Codable, Sendable, Equatable, Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.link == rhs.link && lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(link)
    }
    
    let title: String
    let link: String
    let media: Media
    let dateTaken: Date
    let description: String
    let published: Date
    let author, authorID, tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case description, published, author
        case authorID = "author_id"
        case tags
    }
}

// MARK: Item convenience initializers and mutators

extension Item {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Item.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        title: String? = nil,
        link: String? = nil,
        media: Media? = nil,
        dateTaken: Date? = nil,
        description: String? = nil,
        published: Date? = nil,
        author: String? = nil,
        authorID: String? = nil,
        tags: String? = nil
    ) -> Item {
        return Item(
            title: title ?? self.title,
            link: link ?? self.link,
            media: media ?? self.media,
            dateTaken: dateTaken ?? self.dateTaken,
            description: description ?? self.description,
            published: published ?? self.published,
            author: author ?? self.author,
            authorID: authorID ?? self.authorID,
            tags: tags ?? self.tags
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Media
struct Media: Codable, Sendable {
    let m: String
}

// MARK: Media convenience initializers and mutators

extension Media {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Media.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        m: String? = nil
    ) -> Media {
        return Media(
            m: m ?? self.m
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
