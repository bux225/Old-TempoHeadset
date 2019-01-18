//
//  OpenTokController.swift
//  TempoHeadset
//
//  Created by Soltis, Matthew on 1/14/19.
//  Copyright © 2019 Soltis, Matthew. All rights reserved.
//

import UIKit
import OpenTok
import Alamofire

class OpenTokController: NSObject, OTSessionDelegate, OTPublisherDelegate, OTSubscriberDelegate {
    var rooms = [Room]()
    var serverURL:String = "http://pure-coast-92727.herokuapp.com"
    //var serverURL:String = "http://10.121.14.251:8080"
    var currentRoom:Int = 0

    func switchRooms(channelChosen: Int, name: String) {
        //Main use case long-term is both current and new rooms exist, so disconnect from
        //current and connect to new
        if rooms.count > 0 { //not first room so current room exists
            //disconnect from current room
            var error: OTError?
            rooms[currentRoom].session!.disconnect(&error)
            if error != nil {
                print(error!)
            }
            // See if new room exists
            if let tempRoomFound = rooms.index(where: {$0.channelIndex == channelChosen}) {
                currentRoom = tempRoomFound
                connectSession()
            } else {  //create new room
                rooms.append(Room())
                currentRoom = rooms.count - 1
                rooms[currentRoom].channelIndex = channelChosen
                rooms[currentRoom].roomName = name
                createAndConnectSession(URLName: name)
            }
        } else { // first room
            rooms.append(Room())
            rooms[currentRoom].channelIndex = channelChosen
            rooms[currentRoom].roomName = name
            createAndConnectSession(URLName: name)
        }
    }
    
    
    func createAndConnectSession(URLName: String) {
        Alamofire.request(serverURL + "/room/:" + URLName)
            .responseJSON { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags: \(String(describing: response.result.error))")
                        return
                }
                //create session
                let JSON = value as! [String:String]
                self.rooms[self.currentRoom].session = OTSession(apiKey: JSON["apiKey"]!, sessionId: JSON["sessionId"]!, delegate: self)
                //print("Session Created")
                //assign keys to model
                self.rooms[self.currentRoom].sessionId = JSON["sessionId"]!
                self.rooms[self.currentRoom].token = JSON["token"]!
                self.connectSession()
        }
    }
    
    func connectSession() {
        // called when you re-enter a room
        var error: OTError?
        self.rooms[self.currentRoom].session!.connect(withToken: self.rooms[self.currentRoom].token, error: &error)
        if error != nil {
            print(error!)
        }
        //print("Session Connected")
    }
    
    //MARK: Session Delegate
    func sessionDidConnect(_ session: OTSession) {
        let settings = OTPublisherSettings()
        settings.videoTrack = false
        settings.name = UIDevice.current.name
        guard let publisher = OTPublisher(delegate: self, settings: settings) else {
            return
        }
        
        var error: OTError?
        session.publish(publisher, error: &error)
        guard error == nil else {
            print(error!)
            return
        }
        print("The client connected to the OpenTok session.")
        print(NSDate().timeIntervalSince1970)
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        print("The client disconnected from the OpenTok session.")
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("The client failed to connect to the OpenTok session: \(error).")
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        let aSubscriber = OTSubscriber(stream: stream, delegate: self)
        
        var error: OTError?
        session.subscribe(aSubscriber!, error: &error)
        guard error == nil else {
            print(error!)
            return
        }
    }
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
        print("A stream was destroyed in the session.")
    }
    
    //MARK: PUblisher Delegate
    func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        print("The publisher failed: \(error)")
    }
    
    //MARK: Subscriber Delegate
    public func subscriberDidConnect(toStream subscriber: OTSubscriberKit) {
        print("The subscriber did connect to the stream.")
    }
    
    public func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        print("The subscriber failed to connect to the stream.")
    }
}
