//
//  Warning.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import Foundation
import SwiftUI

struct Warning {
    var type: WarningType
    var color: Color
    var message: String
    var icon:Image = Image(systemName: "exclamationmark.triangle.fill")
}

enum WarningType {
    case warning, logging
}
