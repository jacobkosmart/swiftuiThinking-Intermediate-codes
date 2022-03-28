//
//  DownloadWithEscapingBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/28.
//

import SwiftUI
// MARK: -  MODEL
// struct PostModel: Identifiable, Codable {
// 	let userId: Int
// 	let id: Int
// 	let title: String
// 	let body: String
// }

// MARK: -  VIEWMODEL
class DownloadWithEscapingViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var posts: [PostModel] = []
	// MARK: -  INIT
	init() {
		getPost()
	}
	// MARK: -  FUNCTION
	func getPost() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
		
		downloadData(fromURL: url) { returnedData in
			if let data = returnedData {
				guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
				// print(newPosts)
				// run main thread with weak self
				DispatchQueue.main.async { [weak self] in
					self?.posts = newPosts
				}
			} else {
				print("No Data returned")
			}
		}
	}
	
	func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let data = data,
				error == nil,
				let response = response as? HTTPURLResponse,
				response.statusCode >= 200 && response.statusCode < 300 else {
					print("Error downloading data")
					completionHandler(nil)
					return
				}
			completionHandler(data)
		}.resume() // it's resumed because you can pause or suspend a task an then resume it again
		
	}
}

// MARK: -  VIEW
struct DownloadWithEscapingBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject var vm = DownloadWithEscapingViewModel()
	// MARK: -  BODY
	var body: some View {
		List {
			ForEach(vm.posts) { post in
				VStack (alignment: .leading){
					Text(post.title)
						.font(.headline)
					
					Text(post.body)
						.foregroundColor(.gray)
				} //: VSTACK
				.frame(maxWidth: .infinity, alignment: .leading)
			} //: LOOP
		} //: LIST
		.listStyle(.plain)
	}
}

// MARK: -  PREVIEW
struct DownloadWithEscapingBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		DownloadWithEscapingBootCamp()
	}
}
