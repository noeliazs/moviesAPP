//
//  PopularFilmsManager.swift
//  moviesAPP
//
//  Created by NOELIA ZARZOSO on 09/09/2021.
//

import Foundation

class PopularFilmsPresenter {
    
    let baseURL = "https://api.themoviedb.org/3/movie/popular?api_key=82faf716b2c44c0a6e444797f9a0bbf4&language=es-ES&page=1"
    
    var queryURL = "https://api.themoviedb.org/3/search/movie?api_key=82faf716b2c44c0a6e444797f9a0bbf4&language=es-ES&page=1&include_adult=false&query="
    var films = [FilmResult]()
    var searchFilms = [FilmResult]()
    var delegate: PopularFilmsManagerDelegate?
    
    func getFilms() {
         if let url = URL(string: baseURL){
             let session = URLSession(configuration: .default)
             let task = session.dataTask(with: url){(data,responde,error) in
                 if error != nil {
                     self.delegate?.didFailWithError(error: error!)
                     return
                 }
                 if let safeData = data{
                     if let decodedData = self.parseJSON(safeData){
                        for result in decodedData.results {
                            let film = FilmResult(release_date: result.release_date, title: result.title, vote_average: result.vote_average)
                                self.films.append(film)
                         }
                        self.delegate?.didUpdateFilms(self, films: self.films)
                     }
                 }
             }
             task.resume()
         }
     }
    
    func getSearchFilms(title: String){
        searchFilms = []
        let urlConcatenated = "\(queryURL)\(title)"
        print(urlConcatenated)
        if let url = URL(string: urlConcatenated){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data,responde,error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let decodedData = self.parseJSON(safeData){
                       for result in decodedData.results {
                           let film = FilmResult(release_date: result.release_date, title: result.title, vote_average: result.vote_average)
                               self.searchFilms.append(film)
                        }
                       self.delegate?.didUpdateFilms(self, films: self.searchFilms)
                    }
                }
            }
            task.resume()
        }
    }

        
    
    func parseJSON(_ data: Data) -> Film?{
        
        let decoder=JSONDecoder()
        do{
            let decodedData = try decoder.decode(Film.self, from: data)
            return decodedData
            
        } catch {
            print(error)
        }
        return nil
    }
}
