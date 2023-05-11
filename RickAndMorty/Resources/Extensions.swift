//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 10.05.2023.
//

import UIKit
extension UIView{
    func addSubviews(_ views:UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
