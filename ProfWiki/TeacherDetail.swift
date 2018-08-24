//
//  TeacherDetail.swift
//  ProfWiki
//
//  Created by Youssef Elabd on 8/23/18.
//  Copyright © 2018 Youssef Elabd. All rights reserved.
//

import Foundation

struct TeacherDetail: Codable {
    let imageurl: String
    let firstname: String
    let id: Int
    let lastname: String
    let email: String
    let office: String
    let phone: String?
    let ratemyprofessorscore: Double?
    let difficulty: Double?
    let education: String?
}
