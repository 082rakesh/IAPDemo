//
//  EntrainmentSound.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 17/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

/**
 A type representing the Entrainment Sound
 */
struct EntrainmentSound: Decodable {
    var id: String
    var title: String
    var subtitle: String
    var description: String
    var price: Double
    var rating: Int
    var reviewCount: String
    var previewURL: String?
    var thumbnailImgURL: String?
    var fullImgURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case description = "sound_description"
        case price = "price_usd"
        case rating
        case reviewCount = "review_count"
        case previewURL = "preview_url"
        case thumbnailImgURL = "thumbnail_img_url"
        case fullImgURL = "full_img_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        rating = try container.decodeIfPresent(Int.self, forKey: .rating) ?? 0
        reviewCount = try container.decodeIfPresent(String.self, forKey: .reviewCount) ?? ""
        previewURL = try container.decodeIfPresent(String.self, forKey: .previewURL)
        thumbnailImgURL = try container.decodeIfPresent(String.self, forKey: .thumbnailImgURL)
        fullImgURL = try container.decodeIfPresent(String.self, forKey: .fullImgURL)
    }
}
