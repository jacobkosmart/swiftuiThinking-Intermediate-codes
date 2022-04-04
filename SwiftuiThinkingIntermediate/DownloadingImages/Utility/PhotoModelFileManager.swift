//
//  PhotoModelFileManager.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
	// MARK: -  PROPERTY
	static let instance = PhotoModelFileManager()
	let folderName = "downloaded_photos"
	// MARK: -  INIT
	private init() {
		createFolderIfNeeded()
	}
	// MARK: -  FUNCTION
	private func createFolderIfNeeded() {
		guard let url = getFolderPath() else { return }
		if !FileManager.default.fileExists(atPath: url.path) {
			do {
				try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
				print("Created folder!")
			} catch let error {
				print("Error creating folder.: \(error)")
			}
		}
	}
	
	private func getFolderPath()-> URL? {
		return FileManager
			.default
			.urls(for: .cachesDirectory, in: .userDomainMask)
			.first?
			.appendingPathComponent(folderName)
	}
	
	// ... /downloaded_photos/
	// ... /downloaded_photos/image_name.png
	private func getImagePath(key: String) -> URL? {
		guard let folder = getFolderPath() else { return nil }
		return folder.appendingPathComponent(key + ".png")
	}
	
	
	func add(key: String, value: UIImage) {
		guard
			let data = value.pngData(),
			let url = getImagePath(key: key) else { return }
		
		do {
			try data.write(to: url)
		} catch let error {
			print("Error saving to file manger: \(error)")
		}
	}
	
	func get(key: String) -> UIImage? {
		guard
			let url = getImagePath(key: key),
			FileManager.default.fileExists(atPath: url.path) else {
				return nil
			}
		return UIImage(contentsOfFile: url.path)
	}
}
