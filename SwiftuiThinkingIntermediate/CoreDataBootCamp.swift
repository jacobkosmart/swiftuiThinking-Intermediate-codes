//
//  CoreDataBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/23.
//

import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - manges the data for a view

// MARK: -  VIEWMODEL
class CoreDataViewModel: ObservableObject {
	// MARK: -  PROPERTY
	// NSPersistentContainer 생성
	let container: NSPersistentContainer
	// fetch 되서 저장될 data Array 만듬
	@Published var savedEntitied: [FruitEntity] = []
	
	// MARK: -  INIT
	init() {
		// container 는 core data 의 FruitsContainer file 이름임
		container = NSPersistentContainer(name: "FruitsContainer")
		// container 의 loadPersistentStores 해줘서 core Data 로드 함
		container.loadPersistentStores { description, error in
			if let error = error {
				print("ERROR LOADING CORE DATA: \(error)")
			} else {
				print("Successfully loaded core data!")
			}
		}
		// Fruits 데이터 가져옴
		fetchFruits()
	}
	// MARK: -  FUNCTION
	
	func fetchFruits() {
		// core core 에 데이터 요청함
		let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
		
		do {
			// error 가 없으면 container 에서 fetch 해옴
			savedEntitied = try container.viewContext.fetch(request)
		} catch let error {
			// error 처리함
				print("Error fetching. \(error)")
		}
	}
	
	func addFruits(text: String) {
		// new entity 의 attribute 생성
		let newFruit = FruitEntity(context: container.viewContext)
		// 입력 받은 text 가 새로운 데이터가 됨
		newFruit.name = text
		// 데이터 저장
		saveData()
	}
	
	func updateFruit(entity: FruitEntity) {
		// 선택된 entity 의 이름 가져옴
		let currentName = entity.name ?? ""
		// 실행될때 마다 ! 추가 시킴
		let newName = currentName + "!"
		// ! 된것을 entity name 에 저장 시킴
		entity.name = newName
		saveData()
	}
	
	
	func deleteFruit(indexSet: IndexSet) {
		// 선택된 indexSet 에서 index 를 번호를 가져와서
		guard let index = indexSet.first else { return }
		// 그 index 에 맏는 값을 찾아서 entity 에 넣어서
		let entity = savedEntitied[index]
		// 그값을 삭제함
		container.viewContext.delete(entity)
		// 그리고 다시 저장
		saveData()
	}
	
	// 저장, 업데이트, 삭제 하고나서 반드시 core data 도 데이터를 갱신해줘야 하기 때문에 저장을 진행 해야 함
	func saveData() {
		do {
			// error 가 없으면, 저장 진행하고, 데이터 다시 불러옴
			try container.viewContext.save()
			fetchFruits()
		} catch let error {
				print("Error saving. \(error)")
		}
	}
}


struct CoreDataBootCamp: View {
	// MARK: -  PROPERTY
	@State  var vm = CoreDataViewModel()
	@State  var textFieldText: String = ""
	
	
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			VStack (spacing: 20) {
				TextField("Add fruit here...", text: $textFieldText)
					.font(.headline)
					.padding(.leading)
					.frame(height: 55)
					.background(Color.init(UIColor.placeholderText))
					.cornerRadius(10)
					.padding(.horizontal)
				
				Button {
					// textField 가 비어있지 않으면 다음 로직 진행 비어 있으면 return
					guard !textFieldText.isEmpty else { return }
					// addFruit 함수에 textFieldText 입력
					vm.addFruits(text: textFieldText)
					// add 되면 textFieldText 다시 "" 로 초기화
					textFieldText = ""
				} label: {
					Text("SAVE")
						.foregroundColor(.white)
						.font(.headline)
						.frame(height: 55)
						.frame(maxWidth: .infinity)
						.background(Color.cyan.cornerRadius(10))
				}
				.padding(.horizontal)
				
				
				List {
					ForEach(vm.savedEntitied) { entity in
						Text(entity.name ?? "NO NAME")
							.onTapGesture {
								vm.updateFruit(entity: entity)
							}
					}
					.onDelete(perform: vm.deleteFruit)
					
				}
				.listStyle(.plain)
				
				Spacer()
			}
			.navigationTitle("Fruit")
		}
	}
}

// MARK: -  PREVIEW
struct CoreDataBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		CoreDataBootCamp()
	}
}
