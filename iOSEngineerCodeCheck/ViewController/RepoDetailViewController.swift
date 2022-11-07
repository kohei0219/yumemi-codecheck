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
            self.ProfileBackgroundView.backgroundColor = .mainBlue
            // 下部を角丸に
            self.ProfileBackgroundView.layer.cornerRadius = 32
            self.ProfileBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            //　影をつける
            self.ProfileBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.ProfileBackgroundView.layer.shadowColor = UIColor.black.cgColor
            self.ProfileBackgroundView.layer.shadowOpacity = 0.6
            self.ProfileBackgroundView.layer.shadowRadius = 4
        }
    }
    @IBOutlet weak var TtlLbl: UILabel!
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    @IBOutlet weak var VisitButton: UIButton! {
        didSet {
            self.VisitButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.VisitButton.layer.shadowColor = UIColor.black.cgColor
            self.VisitButton.layer.shadowOpacity = 0.6
            self.VisitButton.layer.shadowRadius = 4
        }
    }
    
    private var presenter: RepoDetailPresenter!
    
    func assemble(repo: RepoData) {
        presenter = .init(model: RepoDetailModel(), view: self, repo: repo)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .mainBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(didTapBookmark))
        setRepoData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 画面が小さすぎたらボタンを消す
        self.VisitButton.isHidden = self.view.frame.width <= 320
        // グラデーションをつけるが下に余白を作る（角丸のために）
        self.ProfileBackgroundView.profileGradation(
            startColor: UIColor.white.cgColor,
            endColor: UIColor.mainBlue.cgColor
        )
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
    
    @objc private func didTapBookmark() {
        showError(message: "この機能は実装していません！")
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
    
    func fetchFailed(message: String) {
        showError(message: message)
    }
}
