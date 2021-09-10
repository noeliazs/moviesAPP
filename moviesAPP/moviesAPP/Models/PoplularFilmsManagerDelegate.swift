//
//  PoplularFilmsManagerDelegate.swift
//  moviesAPP
//
//  Created by NOELIA ZARZOSO on 09/09/2021.
//

import Foundation
protocol PopularFilmsManagerDelegate {
    func didUpdateFilms(_ popularFilmsManager: PopularFilmsPresenter, films: [FilmResult])
    func didFailWithError(error: Error)
}
