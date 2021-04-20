//
//  order_model.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-02-17.
//

import Foundation

class order{
    var name : String
    init() {
       
        self.name = ""
    }
    
    init(name : String) {
        self.name = name
    }

}
extension order{
    public class func getInitialData() -> [order]{
        return [
            //order(name: "Table View", size: "Add Rows" , noOf: "19", instruction: "")
        ]
    }
}
