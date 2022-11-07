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
    
    private lazy var tableBackgroudLable: UILabel = {
        let label = UILabel()
        label.text = "検索結果がありません"
        label.textAlignment = .center
        return label
    }()
        
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
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
            if self.presenter.numberOfRows() == 0 {
                self.tableView.backgroundView = self.tableBackgroudLable
            } else {
                self.tableView.backgroundView = nil
            }
            self.tableView.reloadData()
        }
    }
    
    func goDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailRepoVC = storyboard.instantiateViewController(identifier: VCIdentifiers.detailRepo.getId()) as? RepoDetailViewController,
              let repo = presenter.selectedRepo else {
            showError(message: "画面の移動に失敗しました")
            return
        }
        detailRepoVC.assemble(repo: repo)
        navigationController?.pushViewController(detailRepoVC, animated: true)
    }
    
    func fetchFailed(message: String) {
        showError(message: message)
    }
}
