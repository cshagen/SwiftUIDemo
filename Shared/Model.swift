//
//  Model.swift
//  SwiftUIDemo
//
//  Created by claus on 07.09.21.
//

import Foundation

struct Portfolio {
    var id=0;
    var name=""
    var positions : [Position] = []
}

struct Position {
    var ticker = ""
    var name = ""
    var count = 0
    var price = 0.0
    var value : Double {
        get { Double(count) * price }
    }
}
