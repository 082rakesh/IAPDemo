//
//  RatingView.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 17/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class RatingView: UIView {
    static let identifier = "RatingView"

    static let fullBlackStarImage =  UIImage(named: Constants.RatingView.fullBlackStarImage)
    static let emptyBlackStarImage = UIImage(named: Constants.RatingView.emptyBlackStarImage)
    static let fullWhiteStarImage =  UIImage(named: Constants.RatingView.fullWhiteStarImage)
    static let emptyWhiteStarImage = UIImage(named: Constants.RatingView.emptyWhiteStarImage)

    @IBOutlet weak var ratingImageViewOne: UIImageView!
    @IBOutlet weak var ratingImageViewTwo: UIImageView!
    @IBOutlet weak var ratingImageViewThree: UIImageView!
    @IBOutlet weak var ratingImageViewFour: UIImageView!
    @IBOutlet weak var ratingImageViewFive: UIImageView!

    var fullStarImage: UIImage?
    var emptyStarImage: UIImage?
    var model = RatingViewModel()

    /// Rating value to be shown
    var rating = 0 {
        didSet {
            updateUI(for: rating)
        }
    }

    var useBlackOutline = true {
        didSet {
            if useBlackOutline {
                fullStarImage = RatingView.fullBlackStarImage
                emptyStarImage = RatingView.emptyBlackStarImage
            } else {
                fullStarImage = RatingView.fullWhiteStarImage
                emptyStarImage = RatingView.emptyWhiteStarImage
            }
        }
    }

    /**
     Updates the UI corresponding to the rating value received
     - Parameter rating: Rating value
     */
    private func updateUI(for rating: Int) {
        ratingImageViewOne.image = ratingImage(at: Constants.RatingView.indexOne, for: rating)
        ratingImageViewTwo.image = ratingImage(at: Constants.RatingView.indexTwo, for: rating)
        ratingImageViewThree.image = ratingImage(at: Constants.RatingView.indexThree, for: rating)
        ratingImageViewFour.image = ratingImage(at: Constants.RatingView.indexFour, for: rating)
        ratingImageViewFive.image = ratingImage(at: Constants.RatingView.indexFive, for: rating)
    }

    /**
     Returns the rating image based on the rating value at a given position
     */
    private func ratingImage(at index: Int, for rating: Int) -> UIImage? {
        let image: UIImage?
        let type = model.starImage(at: index, for: rating)
        switch type {
        case .fullStarImage:
            image = fullStarImage
        case .outlineImage:
            image = emptyStarImage
        }
        return image
    }
}
