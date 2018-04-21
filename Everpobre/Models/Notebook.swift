//
//  Notebook.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 21/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import Foundation
import CoreData

extension Notebook {
    
    convenience init(name: String, inContext context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.creationDate = Date()
    }
    
}
