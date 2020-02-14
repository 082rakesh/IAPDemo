//
//  SoundDetailViewController.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 18/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class SoundDetailViewController: UIViewController {
    static let identifier = "SoundDetailViewController"

    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingBgView: UIView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var decsriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    /// Entrainment sound whose detail to be shown in the UI
    var sound: EntrainmentSound? {
        didSet {
            showSoundDetails(for: sound)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        showSoundDetails(for: sound)
    }

    /**
     Sets up the initial UI for the screen
     */
    private func setUpUI() {
        title = NSLocalizedString("SoundDetails.title", comment: "Sound Details")
        buyButton.layer.cornerRadius = buyButton.frame.height/2.0
        setUpLeftBarButtonItem()
        setUpPriceButton()
        loadRatingView()
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
     Takes the user back to Entrainment Library screen
     */
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

    /**
     Sets up the price button title based on current sound status
     */
    private func setUpPriceButton() {
        priceButton.layer.cornerRadius = priceButton.frame.height/2.0
        priceButton.layer.borderColor = UIColor.white.cgColor
        priceButton.layer.borderWidth = 1.0
    }

    /**
     Updates the screen UI with relevant data from entrainment sound object
     - Parameter sound: Entrainment sound
     */
    private func updateUI(for sound: EntrainmentSound) {
        priceButton.setTitle(String(format: "$%.2f", sound.price), for: .normal)
        buyButton.setTitle(
            String.localizedStringWithFormat(NSLocalizedString("SoundDetails.buyFor", comment: "Buy for {amount}"), sound.price),
            for: .normal)

        titleLabel.text = sound.title
        ratingView.rating = sound.rating
        reviewCountLabel.text = sound.reviewCount
        decsriptionLabel.text = sound.description

        if let fullImageURL = sound.fullImgURL {
            imageView.cacheImage(urlString: fullImageURL)
        } else {
            imageView.image = nil
        }
    }

    /**
     Triggers the screen refresh for the selected entrainment sound
     - Parameter sound: Entrainment sound
     */
    private func showSoundDetails(for sound: EntrainmentSound?) {
        guard let entrainmentSound = sound else { return }
        if isViewLoaded {
            updateUI(for: entrainmentSound)
        }
    }

    /**
     Loads the rating view to represent the user rating assciated with the entrainment sound
     */
    private func loadRatingView() {
        guard let soundRatingView = Bundle.main.loadNibNamed(RatingView.identifier,
                                                             owner: nil,
                                                             options: nil)?.first as? RatingView
            else { return }
        ratingView = soundRatingView
        ratingView.useBlackOutline = false
        ratingBgView.addSubview(soundRatingView)

    }

    @IBAction func buyButtonAction(_ sender: Any) {
        showMessage()
    }
    
    /**
     Displays the error details for the received error
     - Parameter error: The error received
     */
    private func showMessage() {
        let localisedMessageString = String.localizedStringWithFormat(NSLocalizedString("buyButtonActionMessage", comment: "buy Action"))
        let localisedTitleString = String.localizedStringWithFormat(NSLocalizedString("buyButtonActionMessageTitle", comment: "buy Action"))

        let alertController = UIAlertController(title: localisedTitleString,
                                                message: localisedMessageString,
                                                preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: Constants.EntrainmentLibrary.actionOk, style: .default, handler: nil)
        alertController.addAction(alertActionOk)
        present(alertController, animated: true, completion: nil)
    }
}
