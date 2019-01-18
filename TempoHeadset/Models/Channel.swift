//
//  Channel.swift
//  tempohs
//
//  Created by Soltis, Matthew on 1/8/19.
//  Copyright © 2019 Soltis, Matthew. All rights reserved.
//

import UIKit

class Channel {
    //MARK: Properties
    var name:String //User-given name for channel.  may have character restrictions for roomName
    var rowInTableView:Int //unique identifer amongst channels since tableview is indexed
    
    //MARK: Initialization
    init(name:String, rowInTableView:Int) {
        //Initialize stored propoerties
        self.name = name
        self.rowInTableView = rowInTableView
    }
    
    convenience init() {
        self.init(name: "", rowInTableView: -1)
    }
}
