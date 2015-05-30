//
//  TimelineViewTweetCell.swift
//  SimpleTwitterClient
//
//  Created by laishin on 2015/05/30.
//  Copyright (c) 2015年 Re.Ra.Ku co., ltd. All rights reserved.
//

import UIKit

class TimelineViewTweetCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCell(tweet rawTweet: NSDictionary?) {
        // TODO: tweetエンティティとパーサを作成し、不正なツイートを予め除く。
        
        let tweetDateFormatter = NSDateFormatter()
        tweetDateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        
        if let
            tweet = rawTweet,
            user = tweet["user"] as? NSDictionary,
            createdAtString = tweet["created_at"] as? String,
            createdAt = tweetDateFormatter.dateFromString(createdAtString) {
                
                self.nameLabel.text = user["name"] as? String
                self.bodyLabel.text = tweet["text"] as? String
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = .ShortStyle
                dateFormatter.timeStyle = .ShortStyle
                self.dateLabel.text = dateFormatter.stringFromDate(createdAt)
        } else {
            self.nameLabel.text = "-"
            self.dateLabel.text = "-"
            self.bodyLabel.text = "-"
        }
    }
}
