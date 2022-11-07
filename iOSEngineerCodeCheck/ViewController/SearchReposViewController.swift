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
        
    private var presenter: SearchReposPresenter!
    
    private func assemble() {
        presenter = .init(model: SearchReposModel(), view: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assemble()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == presenter.repoDetailIdentifier,
              let repoDetailVC = segue.destination as? RepoDetailViewController,
              let repo = presenter.selectedRepo
        else { return }
        repoDetailVC.repo = repo
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = presenter.cellViewData(at: indexPath.row)
        cell.textLabel?.text = rp.fullName
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時にセルのindexを保存しておく
        presenter.didTapCell(at: indexPath.row)
    }
}

extension SearchReposViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.cacelFetchRepos()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text, searchWord.count != 0 else { return }
        presenter.fetchRepos(searchWord: searchWord)
    }
}

extension SearchReposViewController: SearchReposViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func goDetailVC() {
        performSegue(withIdentifier: presenter.repoDetailIdentifier, sender: self)
    }
}
