//
//  DentalDataPointCache.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/26/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import Foundation
import Charts

class DentalDataPointCache{
    static let shared = DentalDataPointCache()
    var rawDataCache:[Int: Array<DentalDataPoint>] = [:]
    var processedDataCache: [Int : LineChartData] = [:]
}
