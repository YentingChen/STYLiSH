//
//  HotsCodable.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import Foundation
// MARK: - Hots
struct Hots: Codable {
    let data: [HotsItem]
}

// MARK: - Datum
struct HotsItem: Codable {
    let title: String
    let products: [ProductItem]
}

// MARK: - Product
struct ProductItem: Codable {
    let id: Int
    let category, title, productDescription: String
    let price: Int
    let texture, wash, place, note: String
    let story: String
    let colors: [ColorItem]
    let sizes: [Size]
    let variants: [VariantItem]
    let mainImage: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, category, title
        case productDescription = "description"
        case price, texture, wash, place, note, story, colors, sizes, variants
        case mainImage = "main_image"
        case images
    }
}

// MARK: - Color
struct ColorItem: Codable {
    let code, name: String
}

enum Size: String, Codable {
    case f = "F"
    case l = "L"
    case m = "M"
    case s = "S"
    case xl = "XL"
}

// MARK: - Variant
struct VariantItem: Codable {
    let colorCode: String
    let size: Size
    let stock: Int

    enum CodingKeys: String, CodingKey {
        case colorCode = "color_code"
        case size, stock
    }
}
