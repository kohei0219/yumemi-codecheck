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
        
        SchBr.text = Strings.searchPlaceHolder.getText()
        SchBr.delegate = self
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
        presenter.fetchRepos(searchWord: searchBar.text)
    }
}

extension SearchReposViewController: SearchReposViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func goDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailRepoVC = storyboard.instantiateViewController(identifier: VCIdentifiers.detailRepo.getId()) as? RepoDetailViewController,
              let repo = presenter.selectedRepo else {
            return
        }
        detailRepoVC.assemble(repo: repo)
        navigationController?.pushViewController(detailRepoVC, animated: true)
    }
}
