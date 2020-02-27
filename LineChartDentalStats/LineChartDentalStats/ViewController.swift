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

    private let apiInteractor = APIInteractor()

    private let lineChartView: LineChartView = {
        let lineChartView = LineChartView()
        lineChartView.accessibilityIdentifier = "Line Chart View"
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.legend.enabled = false
        return lineChartView
    }()

    private let loadingView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "Loading..."
        view.sv(label)
        label.centerVertically().centerHorizontally()
        view.isHidden = false
        return view
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = "Time Label"
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of People Brushing Teeth Between"
        label.accessibilityLabel = "Title Label"
        return label
    }()

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
                titleLabel,
                timeLabel,
                prevButton,
                nextButton)
        lineChartView.left(0).right(0).top(0)
        lineChartView.Bottom == prevButton.Top
        loadingView.left(0).right(0).top(0)
        loadingView.Bottom == titleLabel.Top - 20
        titleLabel.centerHorizontally()
        titleLabel.Bottom == timeLabel.Top - 5
        timeLabel.centerHorizontally()
        timeLabel.Bottom == prevButton.Top
        prevButton.bottom(0).left(0).height(100)
        nextButton.bottom(0).right(0).height(100)
        prevButton.Width == nextButton.Width
        prevButton.Right == nextButton.Left
    }

    private func configureLineChartView(page: Int) {
        apiInteractor.fetchLineChartData(page: page) { dentalDataPoints in
            if let dentalDataPoints = dentalDataPoints {
                if !dentalDataPoints.isEmpty {
                    let startTime = self.populateTimeLabel(date: dentalDataPoints[0].time)
                    let endTime = self.populateTimeLabel(date: dentalDataPoints[dentalDataPoints.count - 1].time)
                    self.timeLabel.text = "\(startTime) -> \(endTime)"
                }
                self.populateLineChartView(page: page, dentalDataPoints: dentalDataPoints)
                self.page = page
                self.displayloadingView(false)
            }
        }
    }

    private func populateLineChartView(page: Int, dentalDataPoints: Array<DentalDataPoint>) {
        if let data = DentalDataPointCache.shared.processedDataCache[page] {
            lineChartView.data = data
            return
        }


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
        DentalDataPointCache.shared.processedDataCache[page] = data
        lineChartView.data = data
    }

    private func populateTimeLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }

    private func displayloadingView(_ isLoading: Bool) {
        loadingView.isHidden = !isLoading
        timeLabel.isHidden = isLoading
        titleLabel.isHidden = isLoading
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
