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
    case lhsChanged(String?)
    case rhsChanged(String?)
  }
  
  enum Mutation {
    case lhsValue(Int?)
    case rhsValue(Int?)
  }
  
  struct State {
    var lhsValue: Int?
    var rhsValue: Int?
    var sum: Int? {
      guard
        let lhs = lhsValue,
        let rhs = rhsValue
      else { return nil }
      
      return lhs + rhs
    }
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(
      lhsValue: nil,
      rhsValue: nil
    )
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .lhsChanged(let lhs):
      guard let lhs = lhs else { return Observable.empty() }
      
      return Observable.just(.lhsValue(Int(lhs)))
    case .rhsChanged(let rhs):
      guard let rhs = rhs else { return Observable.empty() }
      
      return Observable.just(.rhsValue(Int(rhs)))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .lhsValue(let lhs):
      state.lhsValue = lhs
    case .rhsValue(let rhs):
      state.rhsValue = rhs
    }
    
    return state
  }
}
