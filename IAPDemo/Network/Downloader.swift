//
//  Downloader.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 16/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import UIKit

public final class Downloader: NSObject {

    public enum State {
        case began
        case inProgress(CGFloat)
        case completed(Result<URL>)
    }

    public enum DownloaderError: Error {
        case httpRequestFailed
    }

    public let url: URL

    private var updater: ((State) -> Void)?

    private lazy var session: URLSession =
    URLSession(
        configuration: URLSessionConfiguration.default,
        delegate: self,
        delegateQueue: OperationQueue.current
    )

    public init(url: URL) {
        self.url = url
    }

    public func start(_ updater: @escaping (State) -> Void) {
        self.updater = updater
        self.updater?(.began)
        downloadFileFromRemoteUrl(url)
    }

    private func downloadFileFromRemoteUrl(_ url: URL) {
        let task = session.downloadTask(with: url)
        task.resume()
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else { return }
        updater?(.completed(.failure(error)))
        updater = nil
    }
}

extension URLSessionTask {
    public var percentageDownloaded: CGFloat {
        let received = CGFloat(countOfBytesReceived)
        let expected = CGFloat(countOfBytesExpectedToReceive)
        let percentage = received / expected
        return min(percentage, 1)
    }
}

// MARK: NSURLSessionDownloadDelegate

extension Downloader: URLSessionDownloadDelegate {

    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let httpResponse = downloadTask.response as? HTTPURLResponse, !httpResponse.isSuccess {
            updater?(.completed(.failure(DownloaderError.httpRequestFailed)))
        } else {
            updater?(.completed(.success(location)))
        }
        updater = nil
    }

    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        updater?(.inProgress(downloadTask.percentageDownloaded))
    }

    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        updater?(.began)
        updater?(.inProgress(downloadTask.percentageDownloaded))
    }
}

extension HTTPURLResponse {
    public var isSuccess: Bool {
        return 200...299 ~= statusCode
    }
}
