//
//  BoredApi.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-04-20.
//

import Foundation
struct Weather : Codable{
    var activity : String
    
    init(){
        self.activity = ""
    }
    
    enum CodingKeys : String, CodingKey{
        case activity = "activity"
       
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.activity = try response.decodeIfPresent(String.self, forKey: .activity) ?? "Unavailable"
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
}

