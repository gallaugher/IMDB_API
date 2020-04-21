//
//  ViewController.swift
//  IMDB_API
//
//  Created by John Gallaugher on 4/20/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieNameField: UITextField!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let title = searchBar.text!
        searchBar.resignFirstResponder()
        movie.getData (title: title) {
            DispatchQueue.main.async {
                self.movieTitleLabel.text = self.movie.title
                self.movieLengthLabel.text = self.movie.length
                self.movieYearLabel.text = self.movie.year
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Actor: \(movie.cast[indexPath.row].actor)"
        cell.detailTextLabel?.text = "Role: \(movie.cast[indexPath.row].character)"
        return cell
    }
}
