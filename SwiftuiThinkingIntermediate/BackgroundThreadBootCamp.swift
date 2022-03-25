//
//  BackgroundThreadBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/25.
//

import SwiftUI

// MARK: -  VIEWMODEL
class BackgroundThreadViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var dataArray: [String] = []
	
	// MARK: -  INIT
	// MARK: -  FUNCTION
	func fetchData() {
		
		// we can use the regular global completion here you can use the global and specity a quality of
		// service
		// qos: the period on this quality of service there are a couple of different background queue that we can use
		DispatchQueue.global(qos: .background).async {
			let newData = self.downloadData()
			
			print("Chcke 1: \(Thread.isMainThread)")
			print("Chcke 1: \(Thread.current)")
			
			// anytime we update this data array it neeeds to be done on the main thread not on the background
			// UI updated will be proccesed on the main thread
			DispatchQueue.main.async {
				self.dataArray = newData
				print("Chcke 2: \(Thread.isMainThread)")
				print("Chcke 2: \(Thread.current)")

			}
		}
	}
	
	// Create fake data as to download data from Internet
	private func downloadData()-> [String] {
		var data: [String] = []
		
		for x in 0..<100 {
			data.append("\(x)")
			print(data)
		}
		return data
	}
}

struct BackgroundThreadBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = BackgroundThreadViewModel()
	
	// MARK: -  BODY
	var body: some View {
		ScrollView {
			LazyVStack (spacing: 10) {
				Text("LOAD DATA")
					.font(.largeTitle)
					.fontWeight(.semibold)
					.foregroundColor(.white)
					.padding(10)
					.frame(height: 55)
					.frame(maxWidth: .infinity)
					.background(Color.blue.cornerRadius(10))
					.onTapGesture {
						vm.fetchData()
					}
				
				ForEach(vm.dataArray, id: \.self) {
					Text($0)
						.font(.headline)
						.foregroundColor(.red)
				} //: LOOP
			} //: VSTACK
			.padding()
		} //: SCROLL
	}
}

// MARK: -  PREVIEW
struct BackgroundThreadBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		BackgroundThreadBootCamp()
	}
}
