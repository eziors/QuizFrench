//
//  QFError.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 29/10/24.
//

import Foundation

enum QFError: String, Error {
    case urlError = "Failed to locate JSON File. Try again later."
    case dataError = "Failed to convert JSON into Data."
    case categoryError = "Failed to localize category in JSON file."
    case unableToSaveProgress = "There was an error trying to save quiz progress. Please try again later."
    case unableToFavorite = "There was an error favoriting. Please try again."
    case alreadyInFavorites = "You've already favorited it."
}
