//
//  ArraysBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/23.
//

import SwiftUI

// MARK: -  MODEL
struct UserModel: Identifiable {
	let id = UUID().uuidString
	let name: String?
	let points: Int
	let isVerified: Bool
}

// MARK: -  VIEWMODEL

class ArrayModificationViewModel: ObservableObject {
	// MARK: -  PROPERTY
	
	@Published var dataArray: [UserModel] = []
	@Published var filteredArray: [UserModel] = []
	@Published var mappedArray: [String] = []
	
	// MARK: -  INIT
	init() {
		getUsers()
		updateFilteredArray()
	}
	
	// MARK: -  FUNCTION
	func getUsers() {
		let user1 = UserModel(name: "Jacob", points: 90, isVerified: true)
		let user2 = UserModel(name: "Christ", points: 0, isVerified: false)
		let user3 = UserModel(name: "Joe", points: 20, isVerified: true)
		let user4 = UserModel(name: "Emily", points: 35, isVerified: false)
		let user5 = UserModel(name: "Samantha", points: 45, isVerified: true)
		let user6 = UserModel(name: "Sarah", points: 50, isVerified: true)
		let user7 = UserModel(name: "Jason", points: 76, isVerified: false)
		let user8 = UserModel(name: nil, points: 79, isVerified: true)
		let user9 = UserModel(name: nil, points: 80, isVerified: true)
		let user10 = UserModel(name: "Amanda", points: 100, isVerified: true)
		self.dataArray.append(contentsOf: [
			user1,
			user2,
			user3,
			user4,
			user5,
			user6,
			user7,
			user8,
			user9,
			user10,
		])
	}
	
	func updateFilteredArray() {
		
		/*
		1. Sort
		filteredArray = dataArray.sorted { user1, user2 in
			user1.points > user2.points
		}
		위에 sort 를 줄여서 사용하기
		filteredArray = dataArray.sorted(by: { $0.points > $1.points })
		*/
		
		/*
		2. Filter
		filteredArray = dataArray.filter({ user in
			user.isVerified
		})
		
		filter 줄여서 사용하기
		filteredArray = dataArray.filter({ $0.isVerified })
		*/
		
		/*
		3. Map
		여기서는 convert array of users to an array of String 으로 타입을 변환하기
		mappedArray = dataArray.map({ (user) -> String in
			user.name
		})
		map 도 줄여서 사용하기
		mappedArray = dataArray.map({ $0.name })
		*/
		
		// 4. compactMap
		// 만약에 model에 name 이 optional 의 경우일때 그냥 map 을 사용하게 되면 optional 이기 때문에
		// error 발생함
		// compatMap 을 사용하면 값이 있는 것만 골라서 나타냄
		// mappedArray = dataArray.compactMap({ $0.name })
		
		// 5. sort, filter, map 섞어서 사용하기
		mappedArray = dataArray
			.sorted(by: { $0.points > $1.points })
			.filter({ $0.isVerified })
			.compactMap({ $0.name })
	}
}

struct ArraysBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = ArrayModificationViewModel()
	
	// MARK: -  BODY
	var body: some View {
		ScrollView {
			VStack (spacing: 20) {
				/*
				1. Sort, filter UI 예시
				ForEach(vm.filteredArray) { user in
					VStack (alignment: .leading){
						Text(user.name)
							.font(.headline)
						HStack {
							Text("Ponits: \(user.points)")
							Spacer()
							if user.isVerified {
								Image(systemName: "flame.fill")
							}
						} //: HSTACK
					} //: VSTACK
					.foregroundColor(.white)
					.padding()
					.background(Color.blue.cornerRadius(10))
					.padding(.horizontal)
				} //: LOOP
				*/
				
				// 2. map UI 예시
				ForEach(vm.mappedArray, id: \.self) { name in
					Text(name)
						.font(.title)
				}
			} //: VSTACK
		} //: SCROLL
	}
}

// MARK: -  PREVIEW
struct ArraysBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ArraysBootCamp()
	}
}
