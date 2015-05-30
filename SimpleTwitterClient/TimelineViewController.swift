//
//  TimelineViewController.swift
//  SimpleTwitterClient
//
//  Created by laishin on 2015/05/30.
//  Copyright (c) 2015年 Re.Ra.Ku co., ltd. All rights reserved.
//

import UIKit
import Social
import Accounts

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    var tweets = NSArray()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onChangeRefreshControlValue:", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.updateTimeline()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    func updateTimeline() {
        NSLog("update!")
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        let accessHandler: ACAccountStoreRequestAccessCompletionHandler = { (granted: Bool, error: NSError!) in
            if !granted {
                NSLog("アクセス拒否")
                self.refreshControl.endRefreshing()
                return
            }
            
            let accounts = accountStore.accountsWithAccountType(accountType) as NSArray
            
            if accounts.count == 0 {
                NSLog("Twitter アカウント未登録")
                self.refreshControl.endRefreshing()
                return
            }
            
            let account = accounts.lastObject as! ACAccount
            let url = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
            let params = ["count": "100", "include_entities": "0"]
            let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: url, parameters: params)
            request.account = account
            
            let requestHandler: SLRequestHandler = { (response: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) in
                if error != nil {
                    NSLog("リクエスト失敗: \(error.localizedDescription)")
                    self.refreshControl.endRefreshing()
                    return
                }
                
                var parseError: NSError?
                let results = NSJSONSerialization.JSONObjectWithData(response, options: .AllowFragments, error: &parseError) as? NSArray // TODO: エラー時の型を要チェック
                
                if parseError != nil {
                    NSLog("パース失敗: \(parseError!.localizedDescription)")
                    self.refreshControl.endRefreshing()
                    return
                }
                
                if results == nil {
                    // TODO: API アクセス数上限到達時のエラーハンドリング
                    NSLog("レスポンス無し？")
                    self.refreshControl.endRefreshing()
                    return
                }
                
                NSLog(results!.description)
                
                self.tweets = results!
                
                dispatch_async(dispatch_get_main_queue(), { () in
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                })
            }
            
            request.performRequestWithHandler(requestHandler)
        }
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: accessHandler)
    }
    
    // MARK: - Delegate
    
    // MARK: - Handler
    
    @IBAction func onPressTweetButton(sender: UIBarButtonItem) {
        let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        self.presentViewController(tweetVC, animated: true, completion: nil)
    }
    
    func onChangeRefreshControlValue(sender: UIRefreshControl) {
        self.updateTimeline()
    }
}
