//
//  CalculatorView.swift
//  RxCalculator
//
//  Created by Soohan Lee on 2020/04/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import RxCocoa
import ReactorKit
import UIKit
import Then
import SnapKit

final class CalculatorView: UIView, View {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  private lazy var lhsTextField = UITextField().then {
    setupTextFieldStyle($0)
  }
  
  private let operatorImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(systemName: "plus")
  }
  
  private lazy var rhsTextField = UITextField().then {
    setupTextFieldStyle($0)
  }
  
  private let equalsSignImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(systemName: "equal")
  }
  
  private let resultLabel = UILabel().then {
    $0.textAlignment = .center
    $0.font = UIFont(name: "Menlo", size: 50)
    $0.numberOfLines = 0
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllView()
    setupAutoLayout()
    lhsTextField.becomeFirstResponder()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(reactor: CalculatorViewReactor) {
    lhsTextField.rx.controlEvent(.editingChanged)
      .map { Reactor.Action.lhsChanged(self.lhsTextField.text) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    rhsTextField.rx.controlEvent(.editingChanged)
      .map { Reactor.Action.rhsChanged(self.rhsTextField.text) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.sum }
      .filterNil()
      .distinctUntilChanged()
      .map { "\($0)" }
      .bind(to: resultLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  // MARK: - Setup UI
  
  private func setupTextFieldStyle(_ textField: UITextField) {
    textField.borderStyle = .none
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.orange.cgColor
    textField.keyboardType = .numberPad
    textField.font = UIFont(name: "Menlo", size: 50)
    textField.textAlignment = .center
  }
  
  private func addAllView() {
    self.addSubviews([
      lhsTextField,
      operatorImageView,
      rhsTextField,
      equalsSignImageView,
      resultLabel
    ])
  }
  
  private func setupAutoLayout() {
    let safeArea = safeAreaLayoutGuide
    
    lhsTextField.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeArea).inset(16)
    }
    
    operatorImageView.snp.makeConstraints {
      $0.top.equalTo(lhsTextField.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(lhsTextField)
    }
    
    rhsTextField.snp.makeConstraints {
      $0.top.equalTo(operatorImageView.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(operatorImageView)
    }
    
    equalsSignImageView.snp.makeConstraints {
      $0.top.equalTo(rhsTextField.snp.bottom).offset(16)
      $0.leading.trailing.equalTo(rhsTextField)
    }
    
    resultLabel.snp.makeConstraints {
      $0.top.equalTo(equalsSignImageView.snp.bottom).inset(-16)
      $0.leading.trailing.equalTo(rhsTextField)
    }
  }
}
