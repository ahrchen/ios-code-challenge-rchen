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
        lineChartView.Bottom == prevButton.Top - 50
        prevButton.bottom(0).left(0).height(100)
        nextButton.bottom(0).right(0).height(100)
        prevButton.Width == nextButton.Width
        prevButton.Right == nextButton.Left
    }

    @objc func prevButtonPressed() {
    }

    @objc func nextButtonPressed() {
    }
}
