//
//  CommonUtil.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 3/5/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import Foundation

func getURL(with name: String) -> URL? {
    if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) .first {
        let pathComponents = [basePath, name]
        if let url = NSURL.fileURL(withPathComponents: pathComponents) {
            return url
        }
    }
    
    return nil
}
