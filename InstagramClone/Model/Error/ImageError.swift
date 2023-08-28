//
//  ImageError.swift
//  InstagramClone
//
//  Created by Elvis on 18/08/2023.
//

import Foundation

enum ImageError: Error, LocalizedError {
    case UrlEmpty, ConvertFail
    
    var errorDescription: String? {
        switch self {
        case .UrlEmpty:
            return "Url is empty"
        case .ConvertFail:
            return "Image convert to jpeg fail"
        }
    }
}
