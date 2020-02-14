//
//  RatingViewModel.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 18/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

/// The image type for rating
///
/// - fullStarImage: filled image
/// - outlineImage: outlined image
enum RatingImageType {
    case fullStarImage
    case outlineImage
}

/**
 This view model handles picking the right image name corresonding to a rating value
 */
struct RatingViewModel {
    /**
     Returns rating image type corresponding to the rating value
     */
    func starImage(at starIndex: Int, for rating: Int) -> RatingImageType {
        if rating >= starIndex {
            return .fullStarImage
        } else {
            return .outlineImage
        }
    }
}
