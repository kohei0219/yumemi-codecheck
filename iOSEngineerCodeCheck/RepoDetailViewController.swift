//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepoDetailViewController: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var TtlLbl: UILabel!
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var repo: RepoData?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRepoData(repo)
    }
    
    private func setRepoData(_ repo: RepoData?) {
        guard let repo = repo else {
            return
        }
        LangLbl.text = "Written in \(repo.language)"
        StrsLbl.text = "\(repo.stargazersCount) stars"
        WchsLbl.text = "\(repo.wachersCount) watchers"
        FrksLbl.text = "\(repo.forksCount) forks"
        IsssLbl.text = "\(repo.openIssuesCount) open issues"
        TtlLbl.text = repo.fullName
        // 画像を取得する
        guard let imgURL = repo.owner["avatar_url"] as? String else { return }
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
            let img = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.ImgView.image = img
            }
        }
        .resume()
    }
}
