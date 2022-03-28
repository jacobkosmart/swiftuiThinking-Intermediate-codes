//
//  CodableBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/28.
//

import SwiftUI

// Codable = Decodable + Encodable

// MARK: -  MODEL
struct CustomerModel: Identifiable, Codable {
	let id: String
	let name: String
	let points: Int
	let isPremium: Bool
	
	// Using Codable protocol, doesn't need to boiler code below
	
	// enum CodingKeys: String, CodingKey {
	// 	case id
	// 	case name
	// 	case points
	// 	case isPremium
	// }
	//
	// init(id: String, name: String, points: Int, ispremium: Bool) {
	// 	self.id = id
	// 	self.name = name
	// 	self.points = points
	// 	self.isPremium = ispremium
	// }
	//
	// init(from decoder: Decoder) throws {
	// 	let container = try decoder.container(keyedBy: CodingKeys.self)
	// 	self.id = try container.decode(String.self, forKey: .id)
	// 	self.name = try container.decode(String.self, forKey: .name)
	// 	self.points = try container.decode(Int.self, forKey: .points)
	// 	self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
	// }
	//
	// // Encode function
	// func encode(to encoder: Encoder) throws {
	// 	var container = encoder.container(keyedBy: CodingKeys.self)
	// 	try container.encode(id, forKey: .id)
	// 	try container.encode(name, forKey: .name)
	// 	try container.encode(points, forKey: .points)
	// 	try container.encode(isPremium, forKey: .isPremium)
	// }
}

// MARK: -  VIEWMODEL
class CodableViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var customer: CustomerModel? = nil
	// MARK: -  INIT
	init() {
		getData()
	}
	// MARK: -  FUNCTION
	func getData() {
		guard let data = getJsonData() else { return }
		
		// manually decode data
		
		// if
		// 	let localData = try? JSONSerialization.jsonObject(with: data, options: []),
		// 	let dictonary = localData as? [String:Any],
		// 	let id = dictonary["id"] as? String,
		// 	let name = dictonary["name"] as? String,
		// 	let points = dictonary["points"] as? Int,
		// 	let isPremium = dictonary["isPremium"] as? Bool {
		//
		// 	let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
		// 	customer = newCustomer
		// }
		
		// Using decode protocol
		
		// do {
		// 	self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
		// } catch let error {
		// 	print("Error decoding. \(error)")
		// }
		
		// short one line from do catch
		self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
	}
	func getJsonData()-> Data? {
		
		let customer = CustomerModel(id: "111", name: "Emma", points: 100, isPremium: false)
		let jsonData = try? JSONEncoder().encode(customer)
		
		// let dictionary: [String:Any] = [
		// 	"id" : "12345",
		// 	"name" : "Jacob",
		// 	"points" : 5,
		// 	"isPremium" : true
		// ]
		//
		// let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
		return jsonData
	}
}

struct CodableBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = CodableViewModel()
	// MARK: -  BODY
	var body: some View {
		VStack (spacing: 20) {
			if let customer = vm.customer {
				Text(customer.id)
				Text(customer.name)
				Text("\(customer.points)")
				Text(customer.isPremium.description)
			}
		} //: VSTACK
	}
}

// MARK: -  PREVIEW
struct CodableBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		CodableBootCamp()
	}
}
