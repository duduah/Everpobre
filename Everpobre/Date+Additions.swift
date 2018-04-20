//
//  Date+Additions.swift
//  Everpobre
//
//  Created by Diego Gay Saez on 20/04/2018.
//  Copyright © 2018 Diego Gay Saez. All rights reserved.
//

import Foundation

let dateFormat = "dd/MM/yyyy"

extension Date {
    static func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: date)
    }
}
