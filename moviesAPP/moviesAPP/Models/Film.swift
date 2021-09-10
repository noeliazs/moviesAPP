//
//  Film.swift
//  moviesAPP
//
//  Created by NOELIA ZARZOSO on 09/09/2021.
//

import Foundation

// MARK: - Welcome
struct Film: Codable {
    let page: Int?
    let results: [FilmResult]
}

// MARK: - Result
struct FilmResult: Codable {
    let release_date: String?
    let title: String?
    let vote_average: Double?
}


