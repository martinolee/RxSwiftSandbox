//
//  CalculatorView.swift
//  RxCalculator
//
//  Created by Soohan Lee on 2020/04/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import Then
import SnapKit

protocol CalculatorViewDeleate: class {
  func lhsTextFieldEditingDidChange(_ textField: UITextField, _ text: String)
  
  func rhsTextFieldEditingDidChange(_ textField: UITextField, _ text: String)
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

final class CalculatorView: UIView {
  // MARK: - Properties
  
  weak var delegate: CalculatorViewDeleate?
  
  private let disposeBag = DisposeBag()
  
  private lazy var lhsTextField = UITextField().then {
    setupTextFieldStyle($0)
    
    $0.delegate = self
    
    $0.addTarget(self, action: #selector(lhsTextFieldEditingDidChange(_:)), for: .editingChanged)
  }
  
  private let operatorImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(systemName: "plus")
  }
  
  private lazy var rhsTextField = UITextField().then {
    setupTextFieldStyle($0)
    
    $0.delegate = self
    
    $0.addTarget(self, action: #selector(rhsTextFieldEditingDidChange(_:)), for: .editingChanged)
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

// MARK: - Action Handler

extension CalculatorView {
  @objc
  private func lhsTextFieldEditingDidChange(_ textField: UITextField) {
    delegate?.lhsTextFieldEditingDidChange(textField, textField.text ?? "")
  }
  
  @objc
  private func rhsTextFieldEditingDidChange(_ textField: UITextField) {
    delegate?.rhsTextFieldEditingDidChange(textField, textField.text ?? "")
  }
}

extension CalculatorView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let delegate = delegate else { fatalError() }
    return delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
  }
}

// MARK: - Element Control

extension CalculatorView {
  func setResultLabelText(_ text: String) { resultLabel.text = text }
}

