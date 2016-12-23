//
//  DeliveryDayViewController.swift
//  DelTracker
//
//  Created by Joel Payne on 12/2/16.
//  Copyright © 2016 Joel Payne. All rights reserved.
//

import UIKit

class DeliveryDayViewController: UIViewController, UINavigationControllerDelegate {
	@IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
		setArchiveURLPath()
	}
	@IBAction func daySaveButton(_ sender: UIBarButtonItem) {
		setArchiveURLPath()
		performSegue(withIdentifier: "edit", sender: saveDayButton)
	}
	@IBAction func cancelButton(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
	@IBOutlet var deliveryDatePicker: UIDatePicker!
	@IBOutlet var addDayButton: UIBarButtonItem!
	@IBOutlet var saveDayButton: AnyObject?
	var deliveryTableViewController: DeliveryTableViewController? = nil
	var delivery: Delivery?
	var deliveryDay: DeliveryDay?
	var deliveryDays = [DeliveryDay]()
	var deliveryDateViewController = DeliveryDayViewController.self
	static var selectedDateGlobal: String = "010116"
	static var totalRecievedValue: String = "$0.00"
	static var whoMadeBankName: String = "None"
	static var whoClosedBankName: String = "None"
	static var manualStatus: Bool?
	var selectedDate: String = ""
	convenience required init(selectedDate: String) {
		self.init(selectedDate: DeliveryDayViewController.selectedDateGlobal)
		self.selectedDate = selectedDate
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		deliveryDatePicker.setValue(UIColor.white, forKey: "textColor")
	}
	override func viewDidAppear(_ animated: Bool) {
		if let deliveryDay = deliveryDay {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MMddyy"
			let date = dateFormatter.date(from: deliveryDay.deliveryDateValue)
			deliveryDatePicker.setDate(date!, animated: true)
			if let savedDeliveryDays = loadDeliveryDays() {
				deliveryDays += savedDeliveryDays
			}
		}
		setArchiveURLPath()
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if saveDayButton === sender as AnyObject? {
			if let savedDeliveryDays = loadDeliveryDays() {
				deliveryDays += savedDeliveryDays
				let deliveryDayDetailViewController = segue.destination as? DeliveryStatisticsTableViewController
				if DeliveryDayTableViewController.status != "adding" {
					let selectedDeliveryDayCell = Int(DeliveryDayTableViewController.status)
					let indexPath = selectedDeliveryDayCell
					let selectedDeliveryDay = deliveryDays[indexPath!]
					deliveryDayDetailViewController?.deliveryDay = selectedDeliveryDay
					let deliveryDateValue = deliveryDay?.deliveryDateValue
					let deliveryDayCountValue = deliveryDay?.deliveryDayCountValue
					let totalTipsValue = deliveryDay?.totalTipsValue
					let totalRecievedValue = deliveryDay?.totalRecievedValue
					DeliveryDayViewController.totalRecievedValue = (deliveryDay?.totalRecievedValue)!
					DeliveryDayViewController.whoMadeBankName = (deliveryDay?.whoMadeBankName)!
					DeliveryDayViewController.whoClosedBankName = (deliveryDay?.whoClosedBankName)!
					DeliveryDayViewController.manualStatus = selectedDeliveryDay.manual
					let whoMadeBankName = deliveryDay?.whoMadeBankName
					let whoClosedBankName = deliveryDay?.whoClosedBankName
					let manual = selectedDeliveryDay.manual
					deliveryDay = DeliveryDay(deliveryDateValue: deliveryDateValue!, deliveryDayCountValue: deliveryDayCountValue!, totalTipsValue: totalTipsValue!, totalRecievedValue: totalRecievedValue!, whoMadeBankName: whoMadeBankName!, whoClosedBankName: whoClosedBankName!, manual: manual)
				}
			}
		}
	}
	func setArchiveURLPath() {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMddyy"
		DeliveryDayViewController.selectedDateGlobal = dateFormatter.string(from: deliveryDatePicker.date)
		Delivery.ArchiveURL = Delivery.DocumentsDirectory.appendingPathComponent("\(DeliveryDayViewController.selectedDateGlobal)")
		Drop.ArchiveURL = Drop.DocumentsDirectory.appendingPathComponent("\(DeliveryDayViewController.selectedDateGlobal)")
	}
	func loadDeliveryDays() -> [DeliveryDay]? {
		return NSKeyedUnarchiver.unarchiveObject(withFile: DeliveryDay.ArchiveURL.path) as? [DeliveryDay]
	}
}
