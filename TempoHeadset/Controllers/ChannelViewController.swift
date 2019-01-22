//
//  ChannelViewController.swift
//  TempoHeadset
//
//  Created by Soltis, Matthew on 1/18/19.
//  Copyright © 2019 Soltis, Matthew. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    // Model state variable
    var currentChannel:Int = -1 //no channel yet
    var disconnectedButtonColor = UIColor(red:102/255, green:102/255, blue:255/255, alpha:1.0)
    var connectedButtonColor = UIColor.green
    //data eventually comeing from administration
    var numChannels = 4
    var channelNames = ["Offense 1", "Offense 2", "Defense 1", "Defense 2"]
    //OpenTokController
    var opentok = OpenTokController()
    //Table View
    //var usersController = UsersTableViewController()
    //Interface button array
    @IBOutlet var channelButtons: [UIButton]!
    @IBOutlet weak var allButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in channelButtons {
            button.backgroundColor = disconnectedButtonColor
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            button.setTitle(channelNames[button.tag], for: .normal)
        }
        allButton.layer.cornerRadius = allButton.frame.height / 2
        allButton.clipsToBounds = true
    }
    @IBAction func selectAllButton(_ sender: Any) {
        print("Did Select channel: All")
    }
    
    @IBAction func selectChannel(_ sender: UIButton) {
        let index = sender.tag
        if currentChannel != -1 {
            channelButtons[currentChannel].backgroundColor = disconnectedButtonColor
        }
        if index != currentChannel {
            print("Did Select channel: " + channelNames[index])
            let uniqueName = channelNames[index] + String(index)
            let URLFriendlyName = uniqueName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            currentChannel = index
            opentok.switchRooms(channelChosen: currentChannel, name: URLFriendlyName)
            channelButtons[currentChannel].backgroundColor = connectedButtonColor

        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
