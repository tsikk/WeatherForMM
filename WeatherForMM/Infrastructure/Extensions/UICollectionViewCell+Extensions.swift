//
//  UICollectionViewCell+Extensions.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
