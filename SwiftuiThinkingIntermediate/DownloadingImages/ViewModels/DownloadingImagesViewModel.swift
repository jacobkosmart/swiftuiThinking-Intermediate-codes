//
//  DownloadingImagesViewModel.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var dataArray: [PhotoModel] = []
	var cancellables = Set<AnyCancellable>()
	
	let dataService = PhotoModelDataService.instance
	
	// MARK: -  INIT
	init() {
		addSbuscribers()
	}
	// MARK: -  FUNCTION
	func addSbuscribers() {
		dataService.$photoModel
			.sink { [weak self] returnedPhotoModels in
				self?.dataArray = returnedPhotoModels
			}
			.store(in: &cancellables)
	}
}
