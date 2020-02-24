//
//  DentalDataPoint.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/23/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import Foundation

struct DentalDataPoint: Decodable {
    var time: Date
    var numberOfPeopleBrushingTeeth: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        time = try container.decode(Date.self, forKey: .t)
        numberOfPeopleBrushingTeeth = try container.decode(Int.self, forKey: .y)
    }

    private enum CodingKeys: String, CodingKey {
       case t
       case y
   }
}
