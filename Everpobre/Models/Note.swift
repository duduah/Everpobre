//
//  Note.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 12/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import Foundation
import CoreData

extension Note {
    convenience init(title: String, expirationDate: Date? = nil, noteText: String, notebook: Notebook, Context context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.creationDate = Date()
        if let expirationD = expirationDate {
            self.expirationDate = expirationD
        }
        self.noteText = noteText
        self.notebook = notebook
    }
}
////    @NSManaged public var photo: PhotoContainer?

