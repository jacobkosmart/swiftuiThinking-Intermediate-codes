//
//  ImageLoadingViewModel.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var image: UIImage? = nil
	@Published var isLoading: Bool = false
	var cancellables = Set<AnyCancellable>()
	let manager = PhotoModelCacheManager.instance // temporary store
	// let manager = PhotoModelFileManager.instance // store in local device
	
	let urlString: String
	let imageKey: String
	// MARK: -  INIT
	init(url: String, key: String) {
		urlString = url
		imageKey = key
		getImage()
	}
	// MARK: -  FUNCTION
	func getImage() {
		if let savedImage = manager.get(key: imageKey) {
			image = savedImage
			print("Getting saved image!")
		} else {
			downloadImage()
			print("Downloading image now!")
		}
	}
	
	func downloadImage() {
		print("Downloading image now!")
		isLoading = true
		guard let url = URL(string: urlString) else {
			isLoading = false
			return
		}
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map { UIImage(data: $0.data) }
			// .map { (data, response) -> UIImage? in
			// 	return UIImage(data: data)
			// }
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.isLoading = false
			} receiveValue: { [weak self] returnedImage in
				guard let self = self,
							let image = returnedImage else { return }
				
				self.image = image
				self.manager.add(key: self.imageKey, value: image)
			}
			.store(in: &cancellables)
	}
}
