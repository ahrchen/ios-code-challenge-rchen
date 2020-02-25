//
//  DentalDataPoint.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/23/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import Foundation

struct DentalDataPoint: Decodable, Equatable {
    var time: Date
    var numberOfPeopleBrushingTeeth: Int

    init(_ time: Date, _ numberOfPeopleBrushingTeeth: Int){
        self.time = time
        self.numberOfPeopleBrushingTeeth = numberOfPeopleBrushingTeeth
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeInt = try container.decode(Double.self, forKey: .t)
        time = Date(timeIntervalSince1970: timeInt)
        numberOfPeopleBrushingTeeth = try container.decode(Int.self, forKey: .y)
    }

    private enum CodingKeys: String, CodingKey {
       case t
       case y
   }
}
