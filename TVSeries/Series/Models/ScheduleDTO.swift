//
//  ScheduleDTO.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//

struct ScheduleDTO: Decodable {
    let time: String
    let days: [String]
}

extension ScheduleDTO: Parsable {
    typealias ParsedType = Schedule

    func parse() -> ParsedType {
        Schedule(time: self.time, days: self.days)
    }
}
