//
//  DentalDataPoints.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/24/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import Foundation
struct DentalDataPoints: Decodable {
  let count: Int
  let all: [DentalDataPoint]

  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
