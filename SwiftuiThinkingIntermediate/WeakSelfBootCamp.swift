//
//  WeakSelfBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/25.
//

import SwiftUI

struct WeakSelfBootCamp: View {
	// MARK: -  PROPERTY
	@AppStorage("count") var count: Int?
	
	init() {
		count = 0
	}
	
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			NavigationLink("Navigate", destination: WeakSelfSecondScreen())
				.navigationTitle("Scrren 1")
		} //: NAVIGATION
		.overlay(
			Text("\(count ?? 0)")
				.font(.largeTitle)
				.padding()
				.background(Color.green.cornerRadius(10))
			, alignment: .topTrailing
		)
	}
}

// MARK: -  SECOND SCREEN
struct WeakSelfSecondScreen: View {
		// MARK: -  PROPERTY
	@StateObject var vm = WeakSelfSecondScreenViewModel()

	var body: some View {
		VStack {
			Text("Second View")
				.font(.largeTitle)
			.foregroundColor(.red)
			
			if let data = vm.data {
				Text(data)
			}
		} //: VSTACK
	}
}

// MARK: -  SECOND SCREEN VIEWMODEL
class WeakSelfSecondScreenViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var data: String? = nil
	// MARK: -  INIT
	init() {
		print("INITIALZE NOW")
		let currentCount = UserDefaults.standard.integer(forKey: "count")
		UserDefaults.standard.set(currentCount + 1, forKey: "count")
		getData()
	}
	deinit {
		print("DE-INITIALZE NOW")
		let currentCount = UserDefaults.standard.integer(forKey: "count")
		UserDefaults.standard.set(currentCount - 1, forKey: "count")
	}
	
	// MARK: -  FUNCTION
	func getData() {
		
		// The solution here is basically instead of calling itself with this strong reference which means
		// absolutely need this class to stay alive to add weak self
		// weak self just makes this self instead of being a strong reference it turns into a weak reference
		// And self is now optional so we will have reference to this data that we can update
		// but we're telling the code here that we don't absolutely need this class to stay alive
		// if this class for whatever reason gets de-initalized it's okay and we can just ignore
		// whatever these calls are
		DispatchQueue.global().async {
			// Delay
			DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
				self?.data = "NEW DATA!!"
			}
		}
	}
}

// MARK: -  PREVIEW
struct WeakSelfBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		WeakSelfBootCamp()
	}
}
