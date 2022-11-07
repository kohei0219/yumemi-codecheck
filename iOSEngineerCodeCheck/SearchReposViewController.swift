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
    
    var repo: [[String: Any]] = []
    var idx: Int!
    private var searchRepo: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Detail", let dtl = segue.destination as? RepoDetailViewController else { return }
        dtl.vc1 = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時にセルのindexを保存しておく
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

extension SearchReposViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepo?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text, searchWord.count != 0 else { return }
        let url = "https://api.github.com/search/repositories?q=\(searchWord)"
        searchRepo = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any], let items = obj["items"] as? [[String: Any]] {
                self.repo = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        // リストを更新する
        searchRepo?.resume()
    }
}
