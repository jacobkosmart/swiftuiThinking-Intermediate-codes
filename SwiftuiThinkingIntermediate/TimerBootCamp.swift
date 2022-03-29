//
//  TimerBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/29.
//

import SwiftUI

struct TimerBootCamp: View {
	// MARK: -  PROPERTY
	let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
	
	// Current Time
	// @State var currentDate: Date = Date()
	// var dateFormatter: DateFormatter {
	// 	let formatter = DateFormatter()
	// 	// formatter.dateStyle = .medium
	// 	formatter.timeStyle = .medium
	// 	return formatter
	// }
	
	// Countdown
	// @State var count: Int = 10
	// @State var finishedText: String? = nil
	
	// Countdown to date
	// @State var timeRemaining: String = ""
	// let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
	
	// Animation counter
	@State var count: Int = 1
	
	// MARK: -  BODY
	var body: some View {
		ZStack {
			// background
			RadialGradient(
				gradient: Gradient(colors: [Color.purple, Color.blue]),
				center: .center,
				startRadius: 5,
				endRadius: 500)
				.ignoresSafeArea()
			
			// Foreground
			TabView(selection: $count) {
				Rectangle()
					.foregroundColor(.red)
					.tag(1)
				Rectangle()
					.foregroundColor(.blue)
					.tag(2)
				Rectangle()
					.foregroundColor(.green)
					.tag(3)
				Rectangle()
					.foregroundColor(.orange)
					.tag(4)
				Rectangle()
					.foregroundColor(.pink)
					.tag(5)
			} //: TAB
			.frame(height: 200)
			.tabViewStyle(PageTabViewStyle())
		} //: ZSTACK
		.onReceive(timer) { _ in
			withAnimation(.spring()) {
				count = count == 5 ? 1 : count + 1
			}
		}
	}
}

// MARK: -  PREVIEW
struct TimerBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		TimerBootCamp()
	}
}
