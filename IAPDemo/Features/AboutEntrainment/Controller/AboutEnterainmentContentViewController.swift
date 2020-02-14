//
//  AboutEnterainmentContentViewController.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 22/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

/**
 A ViewController representing About Enterainment details and responsible to set and update the all required user interface for each pages.
 */
class AboutEnterainmentContentViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var gotItButton: UIButton!

    private var walkthroughContentViewModel = AboutEntrainmentContentViewModel()

    /**
     Set property to update the UI for respective page
  */
    var pageIndex = 0 {
        didSet {
            setUpUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAboutEntrainmentControls()
        gotItButton.isHidden = true
        setUpUI()
    }

    /**
     Sets up the initial UI for the About Entrainment screen and updating content for the UI based on the current page Index
     */
        private func setUpUI() {
            if isViewLoaded {
                let entrainmentModel =  walkthroughContentViewModel.getAboutEntrainmentModel(at: pageIndex)
                titleLabel.text = entrainmentModel.title
                detailsLabel.text = entrainmentModel.description
                headerImageView.image = UIImage(named: entrainmentModel.imageName)
                headerImageView.clipsToBounds = true
                gotItButton.isHidden = walkthroughContentViewModel.isLastPage(index: pageIndex)
            }
        }

        override func viewDidLayoutSubviews() {
            detailsLabel.sizeToFit()
        }

    /**
     Sets up appearance for title and radius of GotIt button
     */
        private func setUpAboutEntrainmentControls() {
            gotItButton.layer.cornerRadius = gotItButton.frame.height/2.0
            gotItButton.setTitle(NSLocalizedString(
                "AboutEntrainment.gotit",
                comment: "Got It"), for: .normal)
        }

    /**
     Got it button action method
     */
    @IBAction func didTapGotItButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
