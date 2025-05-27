//
//  MenuStruct.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 18/05/25.
//

struct MenuResponse: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable  {
    let id:Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
    

}
