//
//  PopularFilmsViewController.swift
//  moviesAPP
//
//  Created by NOELIA ZARZOSO on 09/09/2021.
//

import UIKit

class PopularFilmsViewController: UIViewController {
    var presenter = PopularFilmsPresenter()
    var popularFilmsArray: [FilmResult] = []
    var favFilmsArray: [FilmResult] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FilmCell",bundle:nil), forCellReuseIdentifier: "FilmCell")
        tableView.dataSource = self
        tableView.delegate = self
        presenter.delegate = self
        searchBar.delegate = self
        presenter.getFilms()
    }
}

//MARK: - TableViewDataSource
extension PopularFilmsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularFilmsArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell       
        cell.titleLabel.text = popularFilmsArray[indexPath.row].title
        cell.averageLabel.text = String(format: "%.1f", popularFilmsArray[indexPath.row].vote_average!) 
        cell.dateLabel.text = popularFilmsArray[indexPath.row].release_date
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.yellow
        UITableViewCell.appearance().selectedBackgroundView = backgroundColorView
        
        return cell
    }
}

extension PopularFilmsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFilm = popularFilmsArray[indexPath.row]
        var counts = 0
        for (index,film) in favFilmsArray.enumerated() {
            if film.title == selectedFilm.title {
                counts+=1
                favFilmsArray.remove(at: index)
            }
        }
        if counts == 0 {
            favFilmsArray.append(selectedFilm)
        }
        
    }
}


//MARK: - ManagerDelegate
extension PopularFilmsViewController: PopularFilmsManagerDelegate{

 
    func didUpdateFilms(_ popularFilmsManager: PopularFilmsPresenter, films: [FilmResult]){
        DispatchQueue.main.async{
            self.popularFilmsArray = films
            self.tableView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
         print(error)
     }
}

//MARK: - SearchResult
extension PopularFilmsViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count >= 3){
            let searchTextQuery = searchText.replacingOccurrences(of: " ", with: "+")
            presenter.getSearchFilms(title: searchTextQuery)
        }
        if (searchText.count == 0){
            presenter.getFilms()
        }
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
}


 





