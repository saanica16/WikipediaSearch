//
//  ViewController.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 27/02/24.
//

import UIKit

final class SearchViewController: UIViewController, SearchViewProtocol {
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = SearchViewModel(useCase: NetworkManager.shared)
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        viewModel.onLoad()
    }
    
    func setupView(){
        self.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString(
            string: "Search anything...",
            attributes: [NSAttributedString.Key.foregroundColor:UIColor.black])
        viewModel.view = self
        searchBar.delegate = self
    }
    
    func updateData() {
        DispatchQueue.main.async { [weak self] in
            self?.resultTableView.setContentOffset(.zero, animated: true)
            self?.resultTableView.reloadData()
        }
    }
    
    func updateViewWithError(errorString: String) {
        let alert = UIAlertController(title: "Failure",
                                      message: errorString,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func toggleLoader(show: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.resultTableView.isUserInteractionEnabled = !show
            if show {
                showLoader()
            } else {
               hideLoader()
            }
        }
    }
    
    func showLoader(){
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideLoader(){
        activityView.stopAnimating()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchData(searchString: searchText)
    }
}

