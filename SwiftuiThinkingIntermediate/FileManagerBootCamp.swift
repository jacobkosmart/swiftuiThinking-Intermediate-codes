//
//  FileManagerBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/31.
//

import SwiftUI

// MARK: -  LOCALFILEMANGER
class LocalFileManger {
	// singleton instance
	static let instance = LocalFileManger()
	let folderName = "MyApp_Images"
	
	init() {
		createFolderIfNeeded()
	}
	// MARK: -  FUNCTION
	func createFolderIfNeeded() {
		guard
			let path = FileManager
				.default
				.urls(for: .cachesDirectory, in: .userDomainMask)
				.first?
				.appendingPathComponent(folderName) // custom create own folder in FM
				.path else {
					return
				}
		if !FileManager.default.fileExists(atPath: path) {
			do {
				try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
				print("Success creating folder")
			} catch let error {
				print("Error creating folder .\(error)")
			}
		}
	}
	
	func deleteFolder() {
		guard
			let path = FileManager
				.default
				.urls(for: .cachesDirectory, in: .userDomainMask)
				.first?
				.appendingPathComponent(folderName) // custom create own folder in FM
				.path else {
					return
				}
		do {
			try FileManager.default.removeItem(atPath: path)
			print("Success deleting folder")
		} catch let error {
			print("Error deleting folder. \(error)")
		}
	}
	
	func saveImage(image: UIImage, name: String) -> String {
		guard
			let data = image.jpegData(compressionQuality: 0.5),
			let path = getPathForImage(name: name) else {
				print("Error getting data")
				return "Error getting data" } // compress 50 percent of quality from original size
		// image.pngData() // if image is png format this code use
		
		// let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		// let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
		// let directory3 = FileManager.default.temporaryDirectory
		// let path = directory2?.appendingPathComponent("\(name).jpg")
		
		do {
			try data.write(to: path)
			print(path)
			return "Success saving"
		} catch let error {
			print("Error saving. \(error)")
			return "Error saving.\(error)"
		}
	}
	
	func getIamge(name: String)-> UIImage? {
		guard
			let path = getPathForImage(name: name)?.path,
			FileManager.default.fileExists(atPath: path) else {
				print("Error getting path.")
				return nil
			}
		return UIImage(contentsOfFile: path)
	}
	
	func deleteImage(name: String)-> String {
		guard
			let path = getPathForImage(name: name)?.path,
			FileManager.default.fileExists(atPath: path) else {
				print("Error getting path.")
				return "Error getting path."
			}
		
		do {
			try FileManager.default.removeItem(atPath: path)
			print("Sucessfully deleted.")
			return "Sucessfully deleted."
		} catch let error {
			print("Error deleting image. \(error)")
			return "Error deleting image. \(error)"
		}
	}
	func getPathForImage(name: String)-> URL? {
		guard
			let path = FileManager
				.default
				.urls(for: .cachesDirectory, in: .userDomainMask)
				.first?
				.appendingPathComponent(folderName)
				.appendingPathComponent("\(name).jpg") else {
					print("Error getting path.")
					return nil
				}
		return path
	}
}

// MARK: -  VIEWMODEL
class FileMagerViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var image: UIImage? = nil
	let imageName: String = "pic"
	let manager = LocalFileManger.instance
	@Published var inforMessage: String = ""
	// MARK: -  INIT
	init() {
		getImageFromAssetsFolder()
		// getImageFromFileManager()
	}
	// MARK: -  FUNCTION
	func getImageFromAssetsFolder() {
		image = UIImage(named: imageName)
	}
	func getImageFromFileManager() {
		image = manager.getIamge(name: imageName)
	}
	func saveImage() {
		guard let image = image else { return }
		inforMessage = manager.saveImage(image: image, name: imageName)
	}
	func deleteImage() {
		inforMessage =  manager.deleteImage(name: imageName)
		manager.deleteFolder()
	}
}

// MARK: -  VIEW
struct FileManagerBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = FileMagerViewModel()
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			VStack (spacing: 20) {
				if let image = vm.image {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
						.clipped()
						.cornerRadius(10)
				}
				
				HStack {
					Button {
						vm.saveImage()
					} label: {
						Text("Save to File Manager")
							.foregroundColor(.white)
							.font(.headline)
							.padding()
							.padding(.horizontal)
							.background(Color.blue.cornerRadius(10))
					}
					
					Button {
						vm.deleteImage()
					} label: {
						Text("Delete from File Manager")
							.foregroundColor(.white)
							.font(.headline)
							.padding()
							.padding(.horizontal)
							.background(Color.red.cornerRadius(10))
					}
				} //: HSTACK
				
				Text(vm.inforMessage)
					.font(.largeTitle)
					.fontWeight(.semibold)
					.foregroundColor(.purple)
				
				Spacer()
			}  //: VSTACK
			.navigationTitle("File Manager ")
		} //: NAVIGATION
	}
}

// MARK: -  PREVIEW
struct FileManagerBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		FileManagerBootCamp()
	}
}
