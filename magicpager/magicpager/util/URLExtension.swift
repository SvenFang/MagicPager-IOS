//
//  URLExtension.swift
//  magicpager
//
//  Created by Sven on 16/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

extension URL{    
    public static func initPercent(string:String) -> URL?
    {
        let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: urlwithPercentEscapes!)
        return url
    }
}
