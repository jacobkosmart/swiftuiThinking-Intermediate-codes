//
//  DowanloadWithCombine.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/28.
//

import SwiftUI
import Combine

// MARK: -  MODEL
struct PostModel: Identifiable, Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}

// MARK: -  VIEWMODEL
class DownloadWithCombineViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var posts: [PostModel] = []
	var cancellables = Set<AnyCancellable>()
	// MARK: -  INIT
	init() {
		getPosts()
	}
	// MARK: -  FUNCTION
	func getPosts() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
		
		// 1. Create the publisher
		URLSession.shared.dataTaskPublisher(for: url)
		// 2. subscrube publisher on background thread
			.subscribe(on: DispatchQueue.global(qos: .background)) // acutally don't need to subscibe to work background thread cause it automatically gois on the background thread
		// 3. recieve on main thread
			.receive(on: DispatchQueue.main)
		// 4. tryMap (check that the data is good)
		/*
			.tryMap { (data, response) -> Data in
				guard let response = response as? HTTPURLResponse,
							response.statusCode >= 200 && response.statusCode < 300 else {
								throw URLError(.badServerResponse)
							}
				return data
			}
		 */
			.tryMap(handleOutput)
		// 5. decode (decode data into PostModels)
			.decode(type: [PostModel].self, decoder: JSONDecoder())
		// if there was an error in getting these post models and failing completion make default one
			.replaceError(with: [])
		// 6. sink (put the item into our app)
			.sink(receiveValue: { [weak self] returnedPosts in
				self?.posts = returnedPosts
			})
		// 7. store (cancel subscription if needed)
			.store(in: &cancellables)
	}
	
	func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard let response = output.response as? HTTPURLResponse,
					response.statusCode >= 200 && response.statusCode < 300 else {
						throw URLError(.badServerResponse)
					}
		return output.data
	}
}

struct DowanloadWithCombine: View {
	// MARK: -  PROPERTY
	@StateObject var vm = DownloadWithCombineViewModel()
	// MARK: -  BODY
	var body: some View {
		List{
			ForEach(vm.posts) { post in
				VStack(alignment: .leading) {
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
struct DowanloadWithCombine_Previews: PreviewProvider {
	static var previews: some View {
		DowanloadWithCombine()
	}
}
