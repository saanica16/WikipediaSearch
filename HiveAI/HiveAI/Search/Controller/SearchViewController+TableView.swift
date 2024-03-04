//
//  SearchViewController+TableView.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 01/03/24.
//

import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView(){
        resultTableView.dataSource = self
        resultTableView.delegate = self
        let cellIdentifier = "SearchTableViewCell"
        resultTableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                                 forCellReuseIdentifier: cellIdentifier)
    }
    
    func getHeaderView() -> UIView {
        let headerView = UIView(
            frame: CGRect(x: 0, y: 0,
                          width: resultTableView.frame.width,
                          height: 50))
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 5,
                             width: headerView.frame.width-10,
                             height: headerView.frame.height-10)
        label.text = "Results"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getHeaderView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchTableViewCell"
        let cell = resultTableView.dequeueReusableCell(
            withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell
        if let cellData = viewModel.cellData(index: indexPath.row) {
            cell?.configureCell(data: cellData)
        }
        return cell ?? UITableViewCell()
    }
}
