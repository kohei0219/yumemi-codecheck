//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchReposViewController: UITableViewController {

    @IBOutlet weak var SchBr: UISearchBar!
    
    private var repos: [RepoData] = []
    private var selectedIdx: Int?
    private var searchRepos: URLSessionTask?
    private let repoDetailIdentifier = "showRepoDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == repoDetailIdentifier,
              let repoDetailVC = segue.destination as? RepoDetailViewController,
              let selectedIdx = selectedIdx
        else { return }
        repoDetailVC.repo = repos[selectedIdx]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repos[indexPath.row]
        cell.textLabel?.text = rp.fullName
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時にセルのindexを保存しておく
        selectedIdx = indexPath.row
        performSegue(withIdentifier: repoDetailIdentifier, sender: self)
    }
}

extension SearchReposViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepos?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text, searchWord.count != 0 else { return }
        let url = "https://api.github.com/search/repositories?q=\(searchWord)"
        searchRepos = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                self.repos = RepoData.mapData(obj)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        // リストを更新する
        searchRepos?.resume()
    }
}
