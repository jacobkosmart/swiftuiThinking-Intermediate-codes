//
//  PhotoModelDataService.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import Foundation
import Combine

class PhotoModelDataService {
	// MARK: -  PROPERTY
	static let instance = PhotoModelDataService() // Singleton
	@Published var photoModel: [PhotoModel] = []
	var cancellables = Set<AnyCancellable>()
	// MARK: -  INIT
	private init() {
		downloadData()
	}
	// MARK: -  FUNCTION
	func downloadData() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
		
		URLSession.shared.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.receive(on: DispatchQueue.main)
			.tryMap(handelOutPut)
			.decode(type: [PhotoModel].self, decoder: JSONDecoder())
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("Error downloading data. \(error)")
				}
			} receiveValue: { [weak self] returnedPhotoModels in
				self?.photoModel = returnedPhotoModels
			}
			.store(in: &cancellables)

			
	}
	
	private func handelOutPut(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			response.statusCode >= 200 && response.statusCode < 300 else {
				throw URLError(.badServerResponse)
			}
		return output.data
	}
}
