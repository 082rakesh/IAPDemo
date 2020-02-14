//
//  AbtEntrainmentViewModel.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 23/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

/**
 This view model loads and manages the learn about entrainment details
 */
struct AboutEntrainmentViewModel {

    /**
     Purpose: This method will retun next index of the page

     - Parameter currentIndex: The current page index received
     - Return: The next page
     */
    func index(after currentIndex: Int) -> Int? {
        var currentIndex = currentIndex
        currentIndex += 1
        if currentIndex > Constants.AboutEntrainment.pageCount - 1 {
            return nil
        }
        return currentIndex
    }

    /**
     This method will retun the previous index of the page

     - Parameter currentIndex: The current page index received
     - Return: The previous page
     */
    func index(before currentIndex: Int) -> Int? {
        var currentIndex = currentIndex

        if currentIndex == Constants.AboutEntrainment.firstPage {
            return nil
        }
        currentIndex -= 1
        return currentIndex
    }
}
