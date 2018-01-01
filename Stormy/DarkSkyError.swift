//
//  DarkSkyError.swift
//  Stormy
//
//  Created by Addison Francisco on 12/30/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case invalidURL
    case jsonParsingFailure
}
