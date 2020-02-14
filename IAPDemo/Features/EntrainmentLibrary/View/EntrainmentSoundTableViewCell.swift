//
//  EntrainmentSoundTableViewCell.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 16/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

/**
 A cell in the Entrainment Sound table view.
 - This class includes properties and methods for setting and managing cell content and their respectve state.
 */
class EntrainmentSoundTableViewCell: UITableViewCell {
    static let identifier = "EntrainmentSoundTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var soundImageView: UIImageView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var ratingBgView: UIView!

    /// Entrainment sound whose detail to be updated in the UI
    var model: EntrainmentSound? {
        didSet {
            guard let sound = model else { return }
            updateUI(with: sound)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        loadRatingView()
    }

    /**
     Loads the rating view to represent the user rating assciated with the entrainment sound
     */
    private func loadRatingView() {
        guard let soundRatingView = Bundle.main.loadNibNamed(
            RatingView.identifier,
            owner: nil,
            options: nil)?.first as? RatingView
            else { return }
        ratingView = soundRatingView
        ratingView.useBlackOutline = true
        ratingBgView.addSubview(soundRatingView)
    }

    /**
     Updates the cell UI with relevant data from entrainment sound model object
     - Parameter sound: Entrainment sound
     */
    private func updateUI(with sound: EntrainmentSound) {
        titleLabel.text = sound.title
        subTitleLabel.text = sound.subtitle
        reviewLabel.text = sound.reviewCount
        ratingView.rating = sound.rating
        if let thumbnailURL = sound.thumbnailImgURL {
            soundImageView.cacheImage(urlString: thumbnailURL)
        } else {
            soundImageView.image = nil
        }
    }
}
