//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 29.05.2023.
//

import UIKit
struct RMSettingsCellViewModel:Identifiable{
    let id=UUID()
    public let type:RMSettingsOption
    public let onTapHandler:(RMSettingsOption)->Void
    //MARK: - Init
    init(type:RMSettingsOption,onTapHandler:@escaping(RMSettingsOption)->Void){
        self.type=type
        self.onTapHandler=onTapHandler
    }
    //MARK: - Public
    // image | title
    public var image:UIImage?{
        return type.iconImage
    }
    public var tltle:String{
        return type.displayTitle
    }
    public var iconContainerColor:UIColor{
        return type.iconContainerColor
    }
}
