//
//  CalculatingModel.swift
//  RxCalculator
//
//  Created by Soohan Lee on 2020/04/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import Foundation
import Then

final class OperationModel {
  var lhs: Int?
  var rhs: Int?
  
  var result$: Int? {
    guard
      let lhs = lhs,
      let rhs = rhs
    else { return nil }
    
    return lhs + rhs
  }
  
  private func isBetweenMinMax(_ number: Int) {
    
  }
}

extension OperationModel: Then {}
