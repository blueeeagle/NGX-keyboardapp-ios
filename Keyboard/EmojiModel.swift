//
//  EmojiModel.swift
//  Keyboard
//
//  Created by Alex Appadurai on 07/04/22.
//

import Foundation

struct EmojiModel: Codable {
    var emoji:String?
    var category:String?
    
    static func getEmojiList()->[EmojiModel]{
        if  let path = Bundle.main.path(forResource: "emoji", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL.init(fileURLWithPath: path))
                   return try JSONDecoder().decode([EmojiModel].self, from: data)
               } catch {
                   print("Unable to load data: \(error)")
               }
        }
        return []
    }
}
