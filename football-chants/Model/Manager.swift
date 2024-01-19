//
//  Manager.swift
//  football-chants
//
//  Created by Andrés Rechimon on 19/01/2024.
//

import Foundation

enum JobType: String {
    case manager = "Manager"
    case headCoach = "Head Coach"
}

struct Manager {
    let name: String
    let job: JobType
}
