//
//  Constants.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 11/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

/// Define static String constants used in the app here as static let variables
enum Constants {
    enum EntrainmentSoundViewModel {
        static let invalidURLErrorCode = 401
    }

    enum RatingView {
        static let fullBlackStarImage = "StarBlack"
        static let emptyBlackStarImage = "StarOutlineBlack"
        static let fullWhiteStarImage = "StarWhite"
        static let emptyWhiteStarImage = "StarOutlineWhite"
        static let indexOne = 1
        static let indexTwo = 2
        static let indexThree = 3
        static let indexFour = 4
        static let indexFive = 5
    }

    enum Shared {
        static let leftBarButton = "LeftChevron"
    }

    enum EntrainmentLibrary {
//        static let entrainmentSoundsFilePath = "https://s3.amazonaws.com/bktdemo/entrainmentlist.json"
        static let entrainmentSoundsFilePath = "https://bktiapdemo.s3.us-east-2.amazonaws.com/entrainment_sounds.json"
        static let entrainmentSoundsFileName = "entrainment_sounds.json"
        static let error = "Error"
        static let actionOk = "OK"
    }

    enum AboutEntrainment {
        static let pageCount = 3
        static let firstPage = 0
        static let lastPage = 2
        static let aboutEntrainmentStoryboard = "AboutEntrainment"
        static let aboutContentViewControllerIdentifier = "ContentViewController"
        static let aboutPageViewControllerIdentifier = "AboutEntrainmentPageViewController"
    }
}
