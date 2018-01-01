//
//  Coordinate.swift
//  Stormy
//
//  Created by Addison Francisco on 12/31/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

// When constructing our URL though, we need to take these double values and
// make a string out of it. We could do that using string interpolation
// in our getWeather function or method and make a string there.
// But we can improve upon that by delegating that work to the type itself.

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
