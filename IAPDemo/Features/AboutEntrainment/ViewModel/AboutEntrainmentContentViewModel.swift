//
//  AboutEntrainmentContentViewModel.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 25/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

/**
 This view model manages the logic to get the after and before page indexes
 */
struct AboutEntrainmentContentViewModel {

    /**
     set the value of model object based on the page index
     - Parameter index: The current index received
     - Return AboutEntrainmentModel: Model object
     */
    func getAboutEntrainmentModel(at index: Int) -> AboutEntrainmentModel {
        let entertainmentWalkthrough = AboutEntrainmentModel(title: NSLocalizedString("AboutEntrainment.Introduction_title_page\(index)", comment: "What is entrainment"), description: NSLocalizedString("AboutEntrainment.Introduction_details_page\(index)", comment: "About Entrainment description details"), imageName: "education_page\(index)")

        return entertainmentWalkthrough
    }

    /**
     Purpose: This method will check the whether the index is the last page index
     - Parameter index: The page index reveived
     - Return: Bool
    */
    func isLastPage(index: Int) -> Bool {
        return index != Constants.AboutEntrainment.lastPage
    }
}
