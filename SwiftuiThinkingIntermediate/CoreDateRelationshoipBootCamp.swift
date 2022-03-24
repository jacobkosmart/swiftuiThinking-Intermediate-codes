//
//  CoreDateRelationshoipBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/24.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity, DepartmentEntity, EmployeeEntity

// MARK: -  SINGLETON
class CoreDataManager {
	// MARK: -  PROPERTY
	static let instance = CoreDataManager()
	let container: NSPersistentContainer
	let contex: NSManagedObjectContext
	
	// MARK: -  INIT
	init() {
		container = NSPersistentContainer(name: "CoreDataContainer")
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Error loading Core Data. \(error)")
			}
		}
		contex = container.viewContext
	}
	// MARK: -  FUNCTION
	func save() {
		do {
			try contex.save()
			print("Saved successfully")
		} catch let error {
			print("Error saving Core Data. \(error.localizedDescription)")
		}
	}
}


// MARK: -  VIEWMODEL
class coreDataRelationshipViewModel: ObservableObject {
	// MARK: -  PROPERTY
	let manager = CoreDataManager.instance
	@Published var businesses: [BusinessEntity] = []
	@Published var departments: [DepartmentEntity] = []
	@Published var employees: [EmployeeEntity] = []
	
	// MARK: -  INIT
	init() {
		getBusiness()
		getDepartments()
		getEmployees()
	}
	
	// MARK: -  FUNCTION
	func getBusiness() {
		let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
		
		// Business name sort
		let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
		request.sortDescriptors = [sort]
		
		// Business name filter : Apple 인것만 출력하기
		// let filter = NSPredicate(format: "name == %@", "Apple")
		// request.predicate = filter
		
		do {
			businesses = try manager.contex.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}
	
	func getDepartments() {
		let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
		
		do {
			departments = try manager.contex.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}
	
	
	func getEmployees() {
		let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
		
		// let filter = NSPredicate(format: "business == %@", business)
		// request.predicate = filter
		
		do {
			employees = try manager.contex.fetch(request)
		} catch let error {
			print("Error fetching. \(error.localizedDescription)")
		}
	}
	
	func updateBusiness() {
		let existingBusiness = businesses[2]
		existingBusiness.addToDepartment(departments[1])
		save()
	}
	
	func addBusiness() {
		let newBusiness = BusinessEntity(context: manager.contex)
		newBusiness.name = "FaceBook"
		
		// Add exsiting departments to the new business
		// newBusiness.department = [departments[0], departments[1]]
		
		// Add exsiting employees to the new business
		// newBusiness.employees = [employees[1]]
		
		// Add new business to existing department
		// newBusiness.addToDepartment(<#T##value: DepartmentEntity##DepartmentEntity#>)
		
		// Add new business to existing employee
		// newBusiness.addToDepartment(<#T##value: DepartmentEntity##DepartmentEntity#>)
		save()
	}
	
	func addDepartment() {
		let newDepartment = DepartmentEntity(context: manager.contex)
		newDepartment.name = "Finance"
		newDepartment.business = [businesses[0], businesses[1], businesses[2]]
		newDepartment.addToEmployees(employees[1])
		// newDepartment.employees = [employees[1]]
		newDepartment.addToEmployees(employees[1])
		save()
	}
	
	func addEmployee() {
		let newEmployee = EmployeeEntity(context: manager.contex)
		newEmployee.age = 21
		newEmployee.dateJoined = Date()
		newEmployee.name = "John"
		
		newEmployee.business = businesses[2]
		newEmployee.department = departments[2]
		save()
	}
	
	// coreData 에서 relations 되어있는데 주의해야 될 점은 CoreData 파일에서 option 에 Delete Rule 에서 Cascade 을 하게 되면 만약 finance department 가 삭제가 되면 거기에 연관된 employee 들도 시스테 상에서 같이 삭제됨 (주의!!) - 기본값은 Nullify 로 되어 있음 (이거는 finance 만 삭제됨). Deny 는 finance 에서 employees 가 한명이라도 있게되면 그게 삭제가 되지 않음
	func deleteDepartment() {
		let department = departments[2]
		manager.contex.delete(department)
		save()
	}
	
	func save() {
		businesses.removeAll()
		departments.removeAll()
		employees.removeAll()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.manager.save()
			self.getBusiness()
			self.getDepartments()
			self.getEmployees()
		}
	}
}



struct CoreDateRelationshoipBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = coreDataRelationshipViewModel()
	
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			ScrollView {
				VStack (spacing: 20) {
					Button {
						// vm.getEmployees(forBusiness: vm.businesses[0])
					} label: {
						Text("Perform Action")
							.foregroundColor(.white)
							.frame(height: 65)
							.frame(maxWidth: .infinity)
							.background(Color.blue.cornerRadius(10))
					}
					
					// BusinessView
					ScrollView(.horizontal, showsIndicators: true) {
						HStack (alignment: .top){
							ForEach(vm.businesses) {
								BusinessView(entity: $0)
							}
						} //: HSTACK
					} //: SCROLL
					
					// DepartmentView
					ScrollView(.horizontal, showsIndicators: true) {
						HStack (alignment: .top){
							ForEach(vm.departments) {
								DepartmentView(entity: $0)
							}
						} //: HSTACK
					} //: SCROLL
					
					// EmployeeView
					ScrollView(.horizontal, showsIndicators: true) {
						HStack (alignment: .top){
							ForEach(vm.employees) {
								EmployeeView(entity: $0)
							}
						} //: HSTACK
					} //: SCROLL

				} //: VSTACK
				.padding()
			} //: SCROLL
			.navigationTitle("Relationship")
		} //: NAVIGATION
	}
}

// MARK: -  PREVIEW
struct CoreDateRelationshoipBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		CoreDateRelationshoipBootCamp()
	}
}

// MARK: -  BUSINESS VIEW
struct BusinessView: View {
	// Property
	let entity: BusinessEntity
	
	// Body
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()
			
			if let departments = entity.department?.allObjects as? [DepartmentEntity] {
				Text("Departments:")
					.bold()
				ForEach(departments) {
					Text($0.name ?? "")
				}
			}
			
			if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
				Text("Employees:")
					.bold()
				ForEach(employees) {
					Text($0.name ?? "")
				}
			}
		} //: VSTACK
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(Color.gray.opacity(0.3).cornerRadius(10))
		.shadow(radius: 10)
	}
}


// MARK: -  DEPARTMENT VIEW
struct DepartmentView: View {
	// Property
	let entity: DepartmentEntity
	
	// Body
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()
			
			if let businesses = entity.business?.allObjects as? [BusinessEntity] {
				Text("Businesses:")
					.bold()
				ForEach(businesses) {
					Text($0.name ?? "")
				}
			}
			
			if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
				Text("Employees:")
					.bold()
				ForEach(employees) {
					Text($0.name ?? "")
				}
			}
		} //: VSTACK
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(Color.green.opacity(0.3).cornerRadius(10))
		.shadow(radius: 10)
	}
}


// MARK: -  EMPLOYEE VIEW
struct EmployeeView: View {
	// Property
	let entity: EmployeeEntity
	
	// Body
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()
			
			Text("Age: \(entity.age)")
			Text("Date Joined: \(entity.dateJoined ?? Date())")
			
			Text("Business:")
				.bold()
			Text(entity.business?.name ?? "")
			
			Text("Department:")
				.bold()
			Text(entity.department?.name ?? "")
		} //: VSTACK
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(Color.red.opacity(0.3).cornerRadius(10))
		.shadow(radius: 10)
	}
}
