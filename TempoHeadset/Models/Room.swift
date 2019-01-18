//
//  Room.swift
//  TempoHeadset
//
//  Created by Soltis, Matthew on 1/16/19.
//  Copyright © 2019 Soltis, Matthew. All rights reserved.
//

import UIKit
import OpenTok

class Room {
    //MARK: Properties
    var roomName:String //unique (for team) URL-friendly room name
    var session:OTSession? //OpenTok Session object
    var channelIndex:Int //mapping of OpenTok session to UI channel
    var sessionId:String //associated sessionId for that session
    var token:String //associated token for that session
    
    //MARK: Initialization
    init(roomName:String, session:OTSession?, channelIndex:Int, sessionId:String, token:String) {
        //Initialize stored propoerties
        self.roomName = roomName
        self.session = session
        self.channelIndex = channelIndex
        self.sessionId = sessionId
        self.token = token
    }
    
    convenience init() {
        self.init(roomName: "", session: nil, channelIndex: 0, sessionId: "", token: "")
    }
}
