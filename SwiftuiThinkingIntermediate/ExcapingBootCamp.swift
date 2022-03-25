//
//  ExcapingBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/26.
//

import SwiftUI

// MARK: -  MODEL
struct DownloadResult {
	let data: String
}

// typealias create shortcut DownloadResult return Void
typealias DownloadCompletion = (DownloadResult) -> ()

// MARK: -  VIEWMODEL
class EscapingViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var text: String = "Hello"
	// MARK: -  INIT
	// MARK: -  FUNCTION
	func getData() {
		// text = downloadData()
		// downloadData2 { returnedData in
		// 	text = returnedData
		// }
		
		// downloadData3(forData: "Someting")
		
		// downloadData4 { [weak self] returnedData in
		// 	self?.text = returnedData
		
		// downloadData5 {[weak self] retrurnResult in
		// 	self?.text = retrurnResult.data
		// }
		
		downloadData6 {[weak self] retrurnResult in
			self?.text = retrurnResult.data
		}
		
	}
	// if we had a whole bunch of logic in this function it would run immediately line by line
	// But there are times when this is not going to work
	func downloadData() -> String {
		return "New data!"
	}
	
	
	// completionHandler which is then a function that we can call by calling completion handler
	// and then padding in our new data2
	func downloadData2(completionHandler: (_ data: String) -> Void) {
		
		completionHandler("New data2!")
		// Add Delay
		// DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
		//
		// }
	}
	
	// -> () equal : return anything same as  -> Void
	func downloadData3(forData data: String) -> () {
		print(data)
	}
	
	// when we add this @escaping it makes our code asynchronous which means it's not going to
	// immediately execute and return 
	func downloadData4(completionHandler: @escaping (_ data: String) -> ()) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			completionHandler("New Data 4!")
		}
	}
	
	// short version of downloadData4 to use MODEL
	func downloadData5(completionHandler: @escaping (DownloadResult) -> ()) {
		let result = DownloadResult(data: "New Data5!")
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			completionHandler(result)
		}
	}
	
	// short version of downloadData5 to use typealias
	func downloadData6(completionHandler: @escaping DownloadCompletion) {
		let result = DownloadResult(data: "New Data5!")
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			completionHandler(result)
		}
	}
}


struct ExcapingBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = EscapingViewModel()
	// MARK: -  BODY
	var body: some View {
		Text(vm.text)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.foregroundColor(.blue)
			.onTapGesture {
				vm.getData()
			}
	}
}

// MARK: -  PREVIEW
struct ExcapingBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ExcapingBootCamp()
	}
}
