//
//  MenuStruct.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 18/05/25.
//

struct MenuResponse: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable {
    let name: String
    let price: Double
    let description: String
    let image: String
}
