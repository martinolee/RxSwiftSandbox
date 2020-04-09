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
  
  let disposeBag = DisposeBag()
  
  private lazy var calculatorView = CalculatorView().then {
    $0.delegate = self
  }
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = calculatorView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - Action Handler

extension CalculatorViewController: CalculatorViewDeleate {
  func lhsTextFieldEditingDidChange(_ textField: UITextField, _ text: String) {
    model.lhs = Int(text)
    
    calculate()
  }
  
  func rhsTextFieldEditingDidChange(_ textField: UITextField, _ text: String) {
    model.rhs = Int(text)
    
    calculate()
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var allowedCharacters = CharacterSet(charactersIn: "0123456789")
    if string.count <= 1 { allowedCharacters = CharacterSet(charactersIn: "-0123456789") }
    
    let characterSet = CharacterSet(charactersIn: string)
    
    return allowedCharacters.isSuperset(of: characterSet)
  }
}

// MARK: -

extension CalculatorViewController {
  private func calculate() {
    Observable<Int?>.combineLatest([
      Observable.just(model.lhs),
      Observable.just(model.rhs)
    ]).subscribe(onNext: { [weak self] in
      let sum = $0
        .compactMap { $0 }
        .reduce(0, +)
      
      print(sum)
      self?.calculatorView.setResultLabelText("\(sum)")
    }).disposed(by: disposeBag)
  }
}
