//
//  ViewController.swift
//  LearnTV_API
//
//  Created by Sebastian Koo on 2/10/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var usersViewModel = UsersViewModel()
    var commentsViewModel = CommentsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        usersViewModel.getDataFromAPIhandler(postsURL: EndPoint.postsURL) { (_, _) in
            DispatchQueue.main.async { [weak self] in
                self?.postsTableView.reloadData()
            }
        }
        
        commentsViewModel.getDataFromAPIhandler(commentsURL: EndPoint.postsURL) { (_, _) in
            DispatchQueue.main.async { [weak self] in
                self?.commentsTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == postsTableView ?
            usersViewModel.getNumberOfRowsInSection() :
            commentsViewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var output = UITableViewCell()
        if tableView == postsTableView, let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") {
            cell.textLabel?.text = usersViewModel.getCellData(index: indexPath.row)
            cell.detailTextLabel?.text = usersViewModel.getDetailCellData(index: indexPath.row)
            output = cell
        } else if tableView == commentsTableView, let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") {
            cell.textLabel?.text = commentsViewModel.getCellData(index: indexPath.row)
            cell.detailTextLabel?.text = commentsViewModel.getDetailCellData(index: indexPath.row)
            output = cell
        }
        return output
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.05)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
}

