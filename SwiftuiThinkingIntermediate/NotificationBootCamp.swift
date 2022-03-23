//
//  NotificationBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/22.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
	static let instance = NotificationManager() // Singleton
	
	func requestAuthorization() {
		let options: UNAuthorizationOptions = [.alert, .sound, .badge]
		
		UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error)  in
			if let error = error {
				print("ERROR: \(error)")
			} else {
				print("SUCCESS")
			}
		}
	}
	
	func scheduleNotification() {
		let content = UNMutableNotificationContent()
		content.title = "This is my first notification"
		content.subtitle = "This is sooo easy!"
		content.sound = .default
		content.badge = 1
		
		// 3 trigger type
		
		// time
		// let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
		
		// calendar
		// var datecomponents = DateComponents()
		// datecomponents.hour = 20
		// datecomponents.minute = 26
		// datecomponents.weekday = 1 // 1은 일요일, 6은 금요일일 됨
		// let trigger = UNCalendarNotificationTrigger(dateMatching: datecomponents, repeats: true)
		
		// location
		let cordinates = CLLocationCoordinate2D(
			latitude: 40.00,
			longitude: 50.00)
		
		let region = CLCircularRegion(
			center: cordinates,
			radius: 100,
			identifier: UUID().uuidString)
		
		region.notifyOnEntry = true // 현재 위치에서 cordinate 지정한 위치로 들어올때 region 활성화
		region.notifyOnExit = true // 현재 위치에서 cordinate 지정한 위치로 나갈때 region 활성화
		
		let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
		
		let request = UNNotificationRequest(
			identifier: UUID().uuidString,
			content: content,
			trigger: trigger)
		UNUserNotificationCenter.current().add(request)
	}
	
	func cancelNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
		UNUserNotificationCenter.current().removeAllDeliveredNotifications()
	}
}

struct NotificationBootCamp: View {
	var body: some View {
		VStack (spacing: 40) {
			Button("Request Permission") {
				NotificationManager.instance.requestAuthorization()
			}
			Button("Schedile notification") {
				NotificationManager.instance.scheduleNotification()
			}
			
			Button("Cancel notification") {
				NotificationManager.instance.cancelNotification()
			}
		} //: VSTACK
		.onAppear {
			// App 이 열리면 badge number 를 0으로 해줌
			UIApplication.shared.applicationIconBadgeNumber = 0
		}
	}
}

struct NotificationBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		NotificationBootCamp()
	}
}
