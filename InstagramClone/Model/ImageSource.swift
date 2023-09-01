//
//  ImageSource.swift
//  InstagramClone
//
//  Created by Elvis on 18/08/2023.
//

import Foundation
import SwiftUI

enum ImageSource {
    case local(name: String)
    case remote(url: URL?)
    case image(image: Image)
}
