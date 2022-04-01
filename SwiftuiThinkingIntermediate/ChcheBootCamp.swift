//
//  ChcheBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/01.
//

import SwiftUI

// MARK: -  CACHEMANAGER
class CacheManger {
	// make singleton : means this is going to be the only instance of catch manager in our entire app
	static let instance = CacheManger()
	private init() { }
	
	var imageCache: NSCache<NSString, UIImage> = {
		let cache = NSCache<NSString, UIImage>()
		// when we store any kind of data in this local cache it's going to store it in the memoryof the device. So, put a count limit on your cache
		cache.countLimit = 100 // the maximum number of objects the cache should hold
		// Themaximum total cost that the cache can hold before it starts evicting object
		cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
		return cache
	}()
	
	func add(image: UIImage, name: String) -> String {
		imageCache.setObject(image, forKey: name as NSString)
		return "Added to cache!"
	}
	
	func remove(name: String) -> String {
		imageCache.removeObject(forKey: name as NSString)
		return "Removed from cache!"
	}
	func get(name: String) -> UIImage? {
		return imageCache.object(forKey: name as NSString)
	}
}

// MARK: -  VIEWMODEL
class CacheViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var startingImage: UIImage? = nil
	@Published var cachedImage: UIImage? = nil
	@Published var infoMessage: String = ""
	let imageName: String = "pic"
	let manager = CacheManger.instance
	
	// MARK: -  INIT
	init() {
		getImageFromAssetsFolder()
	}
	// MARK: -  FUNCTION
	func getImageFromAssetsFolder() {
		startingImage = UIImage(named: imageName)
	}
	func saveToCache() {
		guard let image = startingImage else { return }
		infoMessage = manager.add(image: image, name: imageName)
	}
	func removeFromCache() {
		infoMessage = manager.remove(name: imageName)
	}
	func getFromCache() {
		if let returnedImage = manager.get(name: imageName) {
			cachedImage = returnedImage
			infoMessage = "Get image from Cache"
		} else {
			infoMessage = "Image not found in Cache"
		}
		cachedImage = manager.get(name: imageName)
	}
}

// MARK: -  VIEW
struct ChcheBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = CacheViewModel()
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			VStack (spacing: 20) {
				// Image
				if let image = vm.startingImage {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
						.clipped()
						.cornerRadius(10)
				}
				
				// InfoMessage
				Text(vm.infoMessage)
					.font(.headline)
					.foregroundColor(.purple)
				
				// Buttons
				HStack {
					Button {
						vm.saveToCache()
					} label: {
						Text("Save to Cache")
							.font(.headline)
							.foregroundColor(.white)
							.padding()
							.background(Color.blue)
							.cornerRadius(10)
					}
					Button {
						vm.removeFromCache()
					} label: {
						Text("Delete from Cache")
							.font(.headline)
							.foregroundColor(.white)
							.padding()
							.background(Color.red)
							.cornerRadius(10)
					}
				} //: HSTACK
				Button {
					vm.getFromCache()
				} label: {
					Text("Getfrom Cache")
						.font(.headline)
						.foregroundColor(.white)
						.padding()
						.background(Color.green)
						.cornerRadius(10)
				}
				// Load Cache Image
				if let image = vm.cachedImage {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
						.clipped()
						.cornerRadius(10)
				}
				Spacer()
			} //: VSTACK
			.navigationTitle("Cache Pratice")
		} //: NAVIGATION
	}
}

// MARK: -  PREVIEW
struct ChcheBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ChcheBootCamp()
	}
}
