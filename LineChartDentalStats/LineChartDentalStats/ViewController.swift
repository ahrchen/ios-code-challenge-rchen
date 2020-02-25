//
//  ViewController.swift
//  LineChartDentalStats
//
//  Created by Raymond Chen on 2/23/20.
//  Copyright © 2020 Raymond Chen. All rights reserved.
//

import UIKit
import Stevia
import Charts
import Alamofire

class ViewController: UIViewController {

    var page: Int = 1

    var lineChartViewUpdated : Bool = false

    let prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.addTarget(self, action: #selector(prevButtonPressed), for: .touchUpInside)
        button.accessibilityLabel = "Previous Button"
        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.accessibilityLabel = "Next Button"
        return button
    }()

    let lineChartView: LineChartView = {
        let lineChartView = LineChartView()
        lineChartView.accessibilityIdentifier = "Line Chart View"
        return lineChartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        _ = configureLineChartView(page: page)
    }

    private func configureView() {
        title = "Dental Statistics"
        view.accessibilityIdentifier = "Dental Statistics"
        view.backgroundColor = .white
        layoutView()
    }

    private func layoutView() {
        view.sv(lineChartView,
                prevButton,
                nextButton)
        lineChartView.left(0).right(0).top(0)
        lineChartView.Bottom == prevButton.Top 
        prevButton.bottom(0).left(0).height(100)
        nextButton.bottom(0).right(0).height(100)
        prevButton.Width == nextButton.Width
        prevButton.Right == nextButton.Left
    }

    private func configureLineChartView(page: Int) {
        guard let gitURL = URL(string: "https://raw.githubusercontent.com/rune-labs/ios-code-challenge-rchen/master/api/\(page).json") else { return }
        AF.request(gitURL).validate().responseDecodable(of: Array<DentalDataPoint>.self) { (response) in
            guard let dentalDataPoints = response.value else {
                self.lineChartViewUpdated = false
                return }
            var lineChartEntries = [ChartDataEntry]()

            for dentalDataPoint in dentalDataPoints {
                let value = ChartDataEntry(x: Double(dentalDataPoint.time.timeIntervalSince1970), y: Double(dentalDataPoint.numberOfPeopleBrushingTeeth))
                lineChartEntries.append(value)
            }

            let line = LineChartDataSet(entries: lineChartEntries)
            line.colors = [NSUIColor.blue]
            let data = LineChartData()
            data.addDataSet(line)
            self.lineChartView.data = data
            self.page = page
        }
    }


    @objc func prevButtonPressed() {
        guard page > 1 else { return }
        configureLineChartView(page: page - 1)
    }

    @objc func nextButtonPressed() {
        configureLineChartView(page: page + 1)
    }
}
