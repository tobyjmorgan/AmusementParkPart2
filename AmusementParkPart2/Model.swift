//
//  Model.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/22/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// nice simple model!
struct Model {
    
    var activeEntrantType = EntrantType(masterType: .Guest, subType: .Child)
    var currenPass: Pass?
}
