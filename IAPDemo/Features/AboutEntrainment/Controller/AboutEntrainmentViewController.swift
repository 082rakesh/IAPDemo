//
//  AboutEntrainmentViewController.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 22/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

/**
 A ViewController representing the About Enterainment Container that contains all the setup to show the multiple page for learn about entrainment feature
 */
class AboutEntrainmentViewController: UIViewController {

    private var walkthroughViewModel = AboutEntrainmentViewModel()
    var pageViewController: UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("AboutEntrainment.title", comment: "About Entrainment")
        setUpLeftBarButtonItem()
        setupPageController()
        setupPageControlAppearance()
    }

    /**
     Create and setup UIPageController ## class ## to hold the page content view controller.
    */
    func setupPageController() {

        if let pageViewController = UIStoryboard(name: Constants.AboutEntrainment.aboutEntrainmentStoryboard, bundle: nil) .
            instantiateViewController(withIdentifier: Constants.AboutEntrainment.aboutPageViewControllerIdentifier) as? UIPageViewController, let initialViewController = self.viewControllerAtIndex(0) {
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.view.frame = CGRect(x: 0,
                                                   y: 0,
                                                   width: self.view.frame.size.width,
                                                   height: self.view.frame.size.height - 21)

            pageViewController.setViewControllers([initialViewController],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)

            addChild(pageViewController)
            view.addSubview(pageViewController.view)
            pageViewController.didMove(toParent: self)
        }
    }

    /**
      Create a new view controller based on the current index and pass suitable data.
      - Parameter index: Receied index
      - Return: UIViewController
     */
    private func viewControllerAtIndex(_ index: Int) -> AboutEnterainmentContentViewController? {
        guard let aboutEntrainmentContentViewController = UIStoryboard(name: Constants.AboutEntrainment.aboutEntrainmentStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.AboutEntrainment.aboutContentViewControllerIdentifier) as? AboutEnterainmentContentViewController else {
                return nil
        }
        aboutEntrainmentContentViewController.pageIndex = index
        return aboutEntrainmentContentViewController
    }

    /**
     Creates a custom laft bar button item
     */
    private func setUpLeftBarButtonItem() {
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: Constants.Shared.leftBarButton), for: .normal)
        backbutton.addTarget(self, action:#selector(backAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }

     /**
     Sets up any page control appearance changes.
     */

    private func setupPageControlAppearance() {
        let pageControl = UIPageControl.appearance()
        pageControl.numberOfPages = Constants.AboutEntrainment.pageCount
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    /**
     Takes the user back to Entrainment Library screen
     */
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource
extension AboutEntrainmentViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let contentViewController = viewController as? AboutEnterainmentContentViewController else {
            return nil
        }

        if let index = walkthroughViewModel.index(before: contentViewController.pageIndex) {
            return self.viewControllerAtIndex(index)
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let contentViewController = viewController as? AboutEnterainmentContentViewController,
            let index = walkthroughViewModel.index(after: contentViewController.pageIndex)
        else { return nil }

        return self.viewControllerAtIndex(index)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return Constants.AboutEntrainment.pageCount
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return Constants.AboutEntrainment.firstPage
    }
}
