//
//  FavFilmsViewController.swift
//  moviesAPP
//
//  Created by NOELIA ZARZOSO on 09/09/2021.
//

import UIKit

class FavFilmsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var favFilmsArray: [FilmResult]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FilmCell",bundle:nil), forCellReuseIdentifier: "FilmCell")
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

//MARK: - TableViewDataSource
extension FavFilmsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favFilmsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        cell.titleLabel.text = favFilmsArray[indexPath.row].title
        cell.averageLabel.text = String(format: "%.1f", favFilmsArray[indexPath.row].vote_average!)
        cell.dateLabel.text = favFilmsArray[indexPath.row].release_date
        cell.starImage.image = UIImage(systemName: "star.fill")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
