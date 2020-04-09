//
//  UIViewExtension.swift
//  RxCalculator
//
//  Created by Soohan Lee on 2020/04/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach { self.addSubview($0) }
  }
}
