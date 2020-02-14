//
//  EntrainmentLibraryViewController.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 14/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

/**
 A ViewController representing Entrainment Sounds that are available for purchase, download and trensfer to buds.
 */
class EntrainmentLibraryViewController: UIViewController {

    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var aboutEntrainmentButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    /// A view model that fetches and manages entrainment sounds
    private var soundViewModel = EntrainmentSoundViewModel() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadEntrainmentSounds()
    }

    /**
     Sets up the initial UI for the Entrainment Library screen
     */
    private func setUpUI() {
        title = NSLocalizedString("EntrainmentLibrary.title", comment: "Entrainment Library")
        introductionLabel.text = NSLocalizedString("EntrainmentLibrary.introduction",
                                                   comment: "Entrainment Introduction")
        setUpAboutEntrainmentButton()
        setUpTableView()
    }

    /**
     Downloads the Entrainment Sound json file and updates the UI with relevant data
     */
    private func loadEntrainmentSounds() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        soundViewModel.loadEntrainmentSounds(onSuccess: { [weak self] in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.tableView.reloadData()
            }
        }, onFailure: { [weak self] (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.showError(error)
            }
        })
    }

    /**
     Sets up the UI for the About EntrainmentEntrainment button
     */
    private func setUpAboutEntrainmentButton() {
        aboutEntrainmentButton.layer.cornerRadius = aboutEntrainmentButton.frame.height/2.0
        aboutEntrainmentButton.setTitle(NSLocalizedString(
            "EntrainmentLibrary.about",
            comment: "About Entrainment"), for: .normal)
    }

    /**
     Sets up the tableview used to display the Entrainment Sound files
     */
    private func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: EntrainmentSoundTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: EntrainmentSoundTableViewCell.identifier)
    }

    /**
     Displays the error details for the received error
     - Parameter error: The error received
     */
    private func showError(_ error: Error?) {
        guard let downloadError = error else { return }
        let alertController = UIAlertController(title: Constants.EntrainmentLibrary.error,
                                                message: downloadError.localizedDescription,
                                                preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: Constants.EntrainmentLibrary.actionOk, style: .default, handler: nil)
        alertController.addAction(alertActionOk)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Table View Data Source
extension EntrainmentLibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundViewModel.numberOfSounds()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EntrainmentSoundTableViewCell.identifier, for: indexPath) as? EntrainmentSoundTableViewCell
            else { return UITableViewCell() }
        cell.model = soundViewModel.sound(at: indexPath)
        return cell
    }
}

// MARK: - Table View Delegate
extension EntrainmentLibraryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let detailController = storyboard?.instantiateViewController(withIdentifier: SoundDetailViewController.identifier) as? SoundDetailViewController else { return }
        detailController.sound = soundViewModel.sound(at: indexPath)
        navigationController?.pushViewController(detailController, animated: true)
    }
}
