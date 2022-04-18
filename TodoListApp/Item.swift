//
//  Item.swift
//  TodoListApp
//
//  Created by Miguel Segovia Gil on 18/4/22.
//

import Foundation

class Item: Codable {
    var name: String
    
    static var supportsSecureCoding: Bool {
        return true
        
    }
    
    init(name: String) {
        self.name = name
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let decodedLabel = aDecoder.decodeObject(forKey: "name") as? String else {
            print("Unable to decode the name for an object.")
            return nil
            
        }
        
        self.init(name: decodedLabel) }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        
    }
    
}
