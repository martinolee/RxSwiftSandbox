//
//  CalculatorViewController.swift
//  RxCalculator
//
//  Created by Soohan Lee on 2020/04/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import UIKit
import Then

final class CalculatorViewController: UIViewController {
  // MARK: - Properties
  
  let model = OperationModel()
  
  private lazy var calculatorView = CalculatorView()
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = calculatorView
    
    calculatorView.reactor = CalculatorViewReactor()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
