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
    @IBOutlet weak var ProfileBackgroundView: UIView! {
        didSet {
            // グラデーションをつけるが下に余白を作る（角丸のために）
            self.ProfileBackgroundView.backgroundColor = .mainBlue
            self.ProfileBackgroundView.profileGradation(
                startColor: UIColor.white.cgColor,
                endColor: UIColor.mainBlue.cgColor
            )
            // 下部を角丸に
            self.ProfileBackgroundView.layer.cornerRadius = 32
            self.ProfileBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    @IBOutlet weak var TtlLbl: UILabel!
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    private var presenter: RepoDetailPresenter!
    
    func assemble(repo: RepoData) {
        presenter = .init(model: RepoDetailModel(), view: self, repo: repo)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRepoData()
    }
    
    private func setRepoData() {
        LangLbl.text = presenter.language
        StrsLbl.text = presenter.starts
        WchsLbl.text = presenter.watchers
        FrksLbl.text = presenter.forks
        IsssLbl.text = presenter.issues
        TtlLbl.text = presenter.title
        presenter.fetchImage()
    }
    
    @IBAction func openGitLink(_ sender: Any) {
        guard let url = presenter.gitLink else {
            showError(message: "リンクのの取得に失敗しました")
            return
        }
        UIApplication.shared.open(url)
    }
}

extension RepoDetailViewController: RepoDetailViewDelegate {
    func setImage(data: Data) {
        guard let img = UIImage(data: data) else {
            showError(message: "画像の取得に失敗しました")
            return
        }
        DispatchQueue.main.async {
            self.ImgView.image = img.roundImage()
        }
    }
}
