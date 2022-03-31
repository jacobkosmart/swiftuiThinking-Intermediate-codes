//
//  SubscriberBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/29.
//

import SwiftUI
import Combine

// MARK: -  VIEWMODEL
class SubscriberViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var count: Int = 0
	// canvellable : we can cancel it at any time
	var cancellables = Set<AnyCancellable>()
	
	@Published var textFieldText: String = ""
	@Published var textIsValid: Bool = false
	
	@Published var showButton: Bool = false
	
	// MARK: -  INIT
	init() {
		setUpTimer()
		addTextFieldSubscriber()
		addButtonSubscriber()
	}
	// MARK: -  FUNCTION
	func setUpTimer() {
		 Timer
			.publish(every: 1, on: .main, in: .common)
			.autoconnect()
		// listening to the published values and then doing somthing with it on screen
			.sink { [weak self] _ in
				guard let self = self else { return }
				self.count += 1
			}
			.store(in: &cancellables)
	}
	
	func addTextFieldSubscriber() {
		$textFieldText
			.map { (text) -> Bool in
				if text.count > 3 {
					return true
				}
				return false
			}
			// .assign(to: \.textIsValid, on: self)
			.sink(receiveValue: { [weak self] isValid in
				self?.textIsValid = isValid
			})
			.store(in: &cancellables)
	}
	
	func addButtonSubscriber() {
		$textIsValid
			.combineLatest($count)
			.sink { [weak self] isValid, count in
				guard let self = self else { return }
				if isValid && count >= 10 {
					self.showButton = true
				} else {
					self.showButton = false
				}
			}
			.store(in: &cancellables)
	}
}

struct SubscriberBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = SubscriberViewModel()
	// MARK: -  BODY
	var body: some View {
		VStack {
			Text("\(vm.count)")
				.font(.largeTitle)
			
			Text(vm.textIsValid.description)
			
			TextField("Type somthing here...", text: $vm.textFieldText)
				.padding(.leading)
				.frame(height: 55)
				.font(.headline)
				.background(Color.gray.opacity(0.2).cornerRadius(10))
				.overlay(
					ZStack {
						Image(systemName: "xmark")
							.foregroundColor(.red)
							.opacity(
								vm.textFieldText.count < 1 ? 0.0 :
								vm.textIsValid ? 0.0 : 1.0)
						
						Image(systemName: "checkmark")
							.foregroundColor(.green)
							.opacity(vm.textIsValid ? 1.0 : 0.0)
					} //: ZSTACK
						.font(.title)
						.padding(.trailing)
					, alignment: .trailing
				)
			
			Button {
				
			} label: {
				Text("submit".uppercased())
					.font(.headline)
					.foregroundColor(.white)
					.frame(height: 55)
					.frame(maxWidth: .infinity)
					.background(Color.blue.cornerRadius(10))
					.opacity(vm.showButton ? 1.0 : 0.5)
			}
			.disabled(!vm.showButton)

		} //: VSTACK
		.padding()
	}
}

// MARK: -  PREVIEW
struct SubscriberBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		SubscriberBootCamp()
	}
}
