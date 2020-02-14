//
//  EntrainmentSoundViewModel.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 17/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

/**
 This view model loads and manages the entrainment sounds read from the jason file URL
 */
class EntrainmentSoundViewModel {
    /// Array that holds the list of entrainment sounds that are read from the json file
    private var sounds = [EntrainmentSound]()
    private var success: (() -> Void)?
    private var failure: ((Error) -> Void)?
    /**
     Downloads the entrainment sounds json file, constructs the model objects and sends out the callback to indicate success or failure
     */
    func loadEntrainmentSounds(onSuccess success: @escaping () -> Void,
                               onFailure failure: @escaping (_ error: Error?) -> Void) {
        self.success = success
        self.failure = failure
        guard let url = URL(string: Constants.EntrainmentLibrary.entrainmentSoundsFilePath)
            else {
                let error = NSError(
                    domain: "",
                    code: Constants.EntrainmentSoundViewModel.invalidURLErrorCode,
                    userInfo: [ NSLocalizedDescriptionKey: "Invaild URL!"])
                failure(error)
                return
        }
        let downloader = Downloader(url: url)
        downloader.start { [weak self] (state) in
            switch state {
            case .completed(let result):
                if result.isSuccess, let url = result.value {
                    self?.readEntrainmentSounds(at: url)
                } else if result.isFailure {
                    failure(result.error)
                }
            default:
                break
            }
        }
    }

    /**
     Reads the entrainment sound data from the downloaded json file URL
     */
    private func readEntrainmentSounds(at location: URL) {
        do {
            let data = try Data(contentsOf: location, options: .mappedIfSafe)
            sounds = try JSONDecoder().decode([EntrainmentSound].self, from: data)
            success?()
        } catch {
            failure?(error)
        }
    }
}

extension EntrainmentSoundViewModel {
    /**
     Returns number of entrainment sound files available for display
     */
    func numberOfSounds() -> Int {
        return sounds.count
    }

    /**
     Returns a specific entrainment sound at a given index
     - Parameter indexPath: the index from where model object to be fetched
     - Returns: Entrainment sound at the given index
     */
    func sound(at indexPath: IndexPath) -> EntrainmentSound {
        return sounds[indexPath.row]
    }
}
