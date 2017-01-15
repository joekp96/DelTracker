//
//  PickerViewColor.swift
//  DelTracker2
//
//  Created by Joel Payne on 1/14/17.
//  Copyright © 2017 Joel Payne. All rights reserved.
//

import UIKit

private var selectorColorAssociationKey: UInt8 = 0

extension UIPickerView {
	@IBInspectable var selectorColor: UIColor? {
		get {
			return objc_getAssociatedObject(self, &selectorColorAssociationKey) as? UIColor
		}
		set(newValue) {
			objc_setAssociatedObject(self, &selectorColorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	open override func didAddSubview(_ subview: UIView) {
		super.didAddSubview(subview)
		if let color = selectorColor {
			if subview.bounds.height < 1.0 {
				subview.backgroundColor = color
			}
		}
	}
}
extension UIDatePicker {
	@IBInspectable var selectorColor: UIColor? {
		get {
			return objc_getAssociatedObject(self, &selectorColorAssociationKey) as? UIColor
		}
		set(newValue) {
			objc_setAssociatedObject(self, &selectorColorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	open override func didAddSubview(_ subview: UIView) {
		super.didAddSubview(subview)
		if let color = selectorColor {
			if subview.bounds.height < 1.0 {
				subview.backgroundColor = color
			}
		}
	}
}
