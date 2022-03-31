//
//  AdvancedCombineBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/29.
//

import SwiftUI
import Combine

// MARK: -  FETCHDATA
class AdvancedCombineDataService {
	// MARK: -  PROPERTY
	// @Published var basicPublisher: String = "first publish"
	let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
	let passThroughPublisher = PassthroughSubject<Int, Error>()
	let boolPublisher = PassthroughSubject<Bool, Error>()
	let intPublisher = PassthroughSubject<Int, Error>()
	// MARK: -  INIT
	init() {
		publishFakeData()
	}
	// MARK: -  FUNCTION
	private func publishFakeData() {
		let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 10]
		
		for x in items.indices {
			DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
				// self.currentValuePublisher.send(items[x])
				self.passThroughPublisher.send(items[x])
				
				// Add boolPublisher
				if (x > 4 && x < 8) {
					self.boolPublisher.send(true)
					self.intPublisher.send(999) // intPublisher runs only after 5 index
				} else {
					self.boolPublisher.send(false)
				}
				
				// add completion to show last()
				if x == items.indices.last {
					self.passThroughPublisher.send(completion: .finished)
				}
			}
		}
	}
}


// MARK: -  VIEWMODEL

class AdvancedComineViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var data: [String] = []
	@Published var dataBools: [Bool] = []
	@Published var error: String = ""
	let dataService = AdvancedCombineDataService() // singleton
	
	var cancellables = Set<AnyCancellable>()
	// MARK: -  INIT
	init() {
		addSubscribers()
	}
	// MARK: -  FUNCTION
	private func addSubscribers() {
		// dataService.currentValuePublisher
		
		
		// MARK: - Add publisher pipeline
		// Sequnce Operations
		/*
		 // .first()
		 // .first(where: { $0 > 4 })
		 // .tryFirst(where: {
		 // 	if $0 == 3 {
		 // 		throw URLError(.badServerResponse)
		 // 	}
		 // 	return $0 > 4
		 // })
		 // .last()
		 // .last(where: { $0 < 4 })
		 // . tryLast(where: {
		 // 	if $0 == 3 {
		 // 		throw URLError(.badServerResponse)
		 // 	}
		 // 	return $0 > 1
		 // })
		 // .dropFirst()
		 // .dropFirst(3) // drop 0,1,2 publish -> Start from 3 to 10
		 // .drop(while: { $0 < 5}) // while it's less than five we're going to continue to drop these values
		 // .tryDrop(while: {
		 // 	if $0 == 5 {
		 // 		throw URLError(.badServerResponse)
		 // 	}
		 // 	return $0 < 6
		 // })
		 // .prefix(4) // first 4 published show
		 // .prefix(while: { $0 < 5 })
		 // .output(at: 5) // publish at 5 index
		 // .output(in: 2..<4) // index between 2 and 3
		 */
		
		// Mathematic Operation
		/*
		 // .max()
		 // .max(by: { int1, int2 in
		 // 	return int1 < int2
		 // })
		 // .min()
		 // .min(by: <#T##(Int, Int) -> Bool#>)
		 // .tryMin(by: <#T##(Int, Int) throws -> Bool#>)
		 */
		
		// Filter / Reducing Operation
		/*
		 // .map({ String($0) })
		 // .tryMap({ int in
		 // 	if int == 5 {
		 // 		throw URLError(.badServerResponse)
		 // 	}
		 // 	return String(int)
		 // })
		 // .compactMap({ int in
		 // 	if int == 5 {
		 // 		return nil
		 // 	}
		 // 	return String(int)
		 // })
		 // .tryCompactMap(<#T##transform: (Int) throws -> T?##(Int) throws -> T?#>)
		 // .filter({ ($0 > 3) && ($0 < 7)}) // show greater than 3 and less than 7
		 // .tryFilter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
		 // .removeDuplicates()
		 // .removeDuplicates(by: { int1, int2 in
		 // 	return int1 == int2
		 // })
		 // .tryRemoveDuplicates(by: <#T##(Int, Int) throws -> Bool#>)
		 // .replaceNil(with: 5)
		 // .replaceEmpty(with: <#T##Int#>)
		 // .replaceError(with: <#T##Int#>)
		 
		 // .scan(1, { $0 + $1 })
		 // .tryScan(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int) throws -> T##(T, Int) throws -> T#>)
		 // .reduce(0, { $0  + $1 })
		 // .collect() // collect all of published value in one array
		 //.collect(3) // collect 3 publishes then show display
		 // .allSatisfy({ $0 == 5 })
		 */
		
		// Timing Operations
		/*
			// .debounce(for: 0.75, scheduler: DispatchQueue.main)
			// .delay(for: 2, scheduler: DispatchQueue.main)
			// .measureInterval(using: DispatchQueue.main)
			// .map({ stride in
			// 	return "\(stride.timeInterval)"
			// })
			// .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
			// .retry(3)
			// .timeout(0.75, scheduler: DispatchQueue.main)
		 */
		
		// Multiple Publishers / Subscribers
		/*
			// .combineLatest(dataService.boolPublisher, dataService.intPublisher)
			// .compactMap({ (int1, bool, int2) in
			// 	if bool {
			// 		return String(int1)
			// 	}
			// 	return "n/a"
			// })
			// .compactMap({ $1 ? String($0) : nil }) // short version above compactMap
			// .removeDuplicates() // passThroughPublisher, boolPublisher run pipleline twice so delte duplicated
			// .merge(with: dataService.intPublisher)
			// .zip(dataService.boolPublisher, dataService.intPublisher)
			// .map({ tuple in
			// 	return String(tuple.0) + tuple.1.description + String(tuple.2)
			// })
			.tryMap({ int in
				if int == 3 {
					throw URLError(.badServerResponse)
				}
				return int
			})
			.catch({ error in
				return self.dataService.intPublisher
			})
		 */
		
		let sharePublisher = dataService.passThroughPublisher
			.dropFirst(3)
			.share()
			.multicast {
				PassthroughSubject<Int, Error>()
			}
		
		sharePublisher
			.map({ String($0) })
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					self.error = "ERROR: \(error)"
				}
			} receiveValue: { [weak self] returnedValue in
				self?.data.append(returnedValue)
			}
			.store(in: &cancellables)
		
		sharePublisher
			.map({ $0 > 5 ? true : false })
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					self.error = "ERROR: \(error)"
				}
			} receiveValue: { [weak self] returnedValue in
				self?.dataBools.append(returnedValue)
			}
			.store(in: &cancellables)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
			sharePublisher
				.connect()
				.store(in: &self.cancellables)
		}
	}
}

// MARK: -  VIEW
struct AdvancedCombineBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject private var vm = AdvancedComineViewModel()
	
	// MARK: -  BODY
	var body: some View {
		ScrollView {
			HStack {
				VStack {
					ForEach(vm.data, id: \.self) {
						Text($0)
							.font(.largeTitle)
							.foregroundColor(.primary)
							.fontWeight(.black)
					} //: LOOP
					if !vm.error.isEmpty {
						Text(vm.error)
					}
				} //: VSTACK
				
				VStack {
					ForEach(vm.dataBools, id: \.self) {
						Text($0.description)
							.font(.largeTitle)
							.foregroundColor(.primary)
							.fontWeight(.black)
					} //: LOOP
					if !vm.error.isEmpty {
						Text(vm.error)
					}
				} //: VSTACK
			} //: HSTACK
		} //: SCROLL
	}
}

// MARK: -  PREVIEW
struct AdvancedCombineBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		AdvancedCombineBootCamp()
			.preferredColorScheme(.dark)
	}
}
