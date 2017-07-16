//
//  FeedViewController.swift
//  FungjaiTest
//
//  Created by Admin on 7/16/2560 BE.
//  Copyright © 2560 Admin. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FeedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var seeds:[SeedModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Funjai"
        
        self.tableView?.refreshController(action: { (refresh) in
            self.doHttpGetSeeds(refreshControl: refresh)
        })
        
        self.doHttpGetSeeds()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}


// MARK: - UITableView Delegate

extension FeedViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.seeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let seed =  self.seeds[safe:indexPath.row] else {
            return UITableViewCell()
        }
        
        switch seed.contentType {
        case .track:
            
            let cellIdentifier = "TrackCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TrackCell
            cell.ivCover.loadImage(withUrl: seed.cover)
            cell.lbName.text = seed.name
            
            return cell
            
        case .video:
            
            let cellIdentifier = "VideoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! VideoCell
            cell.ivCover.loadImage(withUrl: seed.cover)
            cell.lbName.text = seed.name
            
            return cell
            
        case .ads:
            
            let cellIdentifier = "AdsCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AdsCell
            cell.ivCover.loadImage(withUrl: seed.cover)
            cell.lbName.text = seed.name
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let seed =  self.seeds[safe:indexPath.row] else {
            return 0
        }
        
        switch seed.contentType {
        case .track:
            return 100
        case .video:
            return self.view.frame.width * (3/4)
        case .ads:
            return self.view.frame.width * (9/16)
            
        default:
            return 0
        }
    }
    
}

// MARK: - UITableView Delegate


extension FeedViewController {
    
    func doHttpGetSeeds(refreshControl:UIRefreshControl? = nil) {
        
        if refreshControl == nil {
            self.show(statusType: .loading)
        }
        Alamofire.request("http://www.anop72.info/api/seed.json").responseArray { (response: DataResponse<[SeedModel]>) in
            
            switch response.result {
                
            case .success(let model):
                
                if model.count > 0 {
                    
                    self.hide(statusType: StatusProviderType.loading)
                    self.seeds = model
                    
                }else{
                    self.show(statusType: StatusProviderType.error(error:"ไม่มีข้อมูล", retry: {
                        self.doHttpGetSeeds()
                    }))
                }
                
                refreshControl?.endRefreshing()
                
            case .failure(let error):
                
                self.show(statusType: StatusProviderType.error(error: error.errorMessage, retry: {
                    self.doHttpGetSeeds()
                }))
                
                refreshControl?.endRefreshing()
                
            }
        }
    }
}
