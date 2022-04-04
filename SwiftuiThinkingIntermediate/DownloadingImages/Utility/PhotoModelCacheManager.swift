//
//  PhotoModelCacheManager.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
	// MARK: -  PROPERTY
	static let instance = PhotoModelCacheManager() // Singleton
	var phtoCache: NSCache<NSString, UIImage> = {
		var cache = NSCache<NSString, UIImage>()
		cache.countLimit = 200
		cache.totalCostLimit = 1024 * 1024 * 200 // 200mb limit
		return cache
	}()
	// MARK: -  INIT
	private init() {
		
	}
	// MARK: -  FUNCTION
	func add(key: String, value: UIImage) {
		phtoCache.setObject(value, forKey: key as NSString)
	}
	
	func get(key: String) -> UIImage? {
		return phtoCache.object(forKey: key as NSString)
	}
}
