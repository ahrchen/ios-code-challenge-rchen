//
//  APIInteractor.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/26/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import Foundation
import Alamofire


class APIInteractor {

    func fetchLineChartData(page: Int, completionHandler:@escaping ((Array<DentalDataPoint>?) -> Void)) {
        if let dentalDataPoints = DentalDataPointCache.shared.rawDataCache[page] {
            completionHandler(dentalDataPoints)
            return
        }
        let urlString = "https://raw.githubusercontent.com/rune-labs/ios-code-challenge-rchen/master/api/\(page).json"
        guard let gitURL = URL(string: urlString) else { return }
        AF.request(gitURL).validate().responseDecodable(of: Array<DentalDataPoint>.self) { (response) in
            guard let dentalDataPoints = response.value else { return }
            DentalDataPointCache.shared.rawDataCache[page] = (dentalDataPoints)
            completionHandler(dentalDataPoints)
        }
    }
}
