//
//  ChannelTableViewController.swift
//  TempoHeadset
//
//  Created by Soltis, Matthew on 1/14/19.
//  Copyright © 2019 Soltis, Matthew. All rights reserved.
//

import UIKit

class ChannelTableViewController: UITableViewController {
    // Model state variable
    var channels = [Channel]()
    var currentChannel:Int = -1 //no channel yet
    //data eventually comeing from administration
    var numChannels = 4
    var channelNames = ["Offense 1", "Offense 2", "Defense 1", "Defense 2"]
    //OpenTokController
    var opentok = OpenTokController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //populate channel models manually for now
        for i in 0...(numChannels - 1) {
            let channel = Channel()
            channel.rowInTableView = i
            channel.name = channelNames[i]
            self.channels.append(channel)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return numChannels
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = channels[indexPath.row].name
        cell.detailTextLabel?.text = "Not Connected"
        //cell.imageView?.image = UIImage(named: channel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Channels:"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentChannel != indexPath.row {  //nothing needed if selected same channel
            print(NSDate().timeIntervalSince1970)
            print("Did Select channel: " + self.channels[indexPath.row].name)
            let uniqueName = self.channels[indexPath.row].name + String(indexPath.row)
            let URLFriendlyName = uniqueName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            currentChannel = indexPath.row
            opentok.switchRooms(channelChosen: currentChannel, name: URLFriendlyName)
        }
    }
}
