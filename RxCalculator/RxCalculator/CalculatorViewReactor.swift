//
//  CalculatorViewReactor.swift
//  RxCalculator
//
//  Created by Soohan Lee on 2020/04/09.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import ReactorKit

final class CalculatorViewReactor: Reactor {
  enum Action {
    case lhs
    case rhs
  }
  
  struct State {
    var value: Int
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(
      value: 0
    )
  }
}
