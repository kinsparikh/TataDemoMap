//
//  Employee.swift
//  TataMapDemo
//
//  Created by Kayaan Parikh on 03/06/20.
//  Copyright © 2021 Kayaan Parikh. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Employees: Decodable {
    let status: String
    let message: String
    let data: [EmployeeData]
}

// MARK: - Datum
struct EmployeeData: Decodable {
    let id,employeeAge,employeeSalary : Int
    let employeeName,profileImage : String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
