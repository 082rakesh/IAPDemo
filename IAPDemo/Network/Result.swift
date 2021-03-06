//
//  Result.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 16/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

public enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    public var isSuccess: Bool {
        guard case .success(_) = self else { return false }
        return true
    }

    public var isFailure: Bool {
        guard case .failure(_) = self else { return false }
        return true
    }
}

extension Result {
    public var value: T? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    public var error: Error? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}

extension Result {
    public func extract() throws -> T {
        switch self {
        case .success(let val):
            return val
        case .failure(let err):
            throw err
        }
    }
}
