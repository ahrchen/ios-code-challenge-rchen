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

    private var page: Int = 1

    private let prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.addTarget(self, action: #selector(prevButtonPressed), for: .touchUpInside)
        button.accessibilityLabel = "Previous Button"
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.accessibilityLabel = "Next Button"
        return button
    }()

    private let lineChartView: LineChartView = {
        let lineChartView = LineChartView()
        lineChartView.accessibilityIdentifier = "Line Chart View"
        return lineChartView
    }()

    private let loadingView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "Loading..."
        view.sv(label)
        label.centerVertically().centerHorizontally()
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "Dental Statistics"
        view.backgroundColor = .white
        layoutView()
        displayloadingView(true)
        configureLineChartView(page: page)
    }

    private func layoutView() {
        view.sv(lineChartView,
                loadingView,
                prevButton,
                nextButton)
        lineChartView.left(0).right(0).top(0)
        lineChartView.Bottom == prevButton.Top
        loadingView.left(0).right(0).top(0)
        loadingView.Bottom == prevButton.Top
        prevButton.bottom(0).left(0).height(100)
        nextButton.bottom(0).right(0).height(100)
        prevButton.Width == nextButton.Width
        prevButton.Right == nextButton.Left
    }

    private func configureLineChartView(page: Int) {
        let urlString = "https://raw.githubusercontent.com/rune-labs/ios-code-challenge-rchen/master/api/\(page).json"
        guard let gitURL = URL(string: urlString) else { return }
        AF.request(gitURL).validate().responseDecodable(of: Array<DentalDataPoint>.self) { (response) in
            guard let dentalDataPoints = response.value else { self.displayloadingView(false); return }
            var entries = [ChartDataEntry]()

            for point in dentalDataPoints {
                let entry = ChartDataEntry(x: Double(point.time.timeIntervalSince1970),
                                           y: Double(point.numberOfPeopleBrushingTeeth))
                entries.append(entry)
            }

            let line = LineChartDataSet(entries: entries)
            line.colors = [NSUIColor.blue]
            let data = LineChartData()
            data.addDataSet(line)
            self.lineChartView.data = data
            self.page = page
            self.displayloadingView(false)
        }
    }

    private func displayloadingView(_ isLoading: Bool) {
        loadingView.isHidden = !isLoading
        lineChartView.isHidden = isLoading
    }

    @objc private func prevButtonPressed() {
        guard page > 1 else { return }
        displayloadingView(true)
        configureLineChartView(page: page - 1)
    }

    @objc private func nextButtonPressed() {
        displayloadingView(true)
        configureLineChartView(page: page + 1)
    }
}
