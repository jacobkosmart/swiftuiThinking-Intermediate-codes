//
//  TypealiasBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/25.
//

import SwiftUI

// MARK: -  MODEL
struct MovieModel {
	let title: String
	let director: String
	let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootCamp: View {
	// MARK: -  PROPERTY
	@State var item: MovieModel = MovieModel(title: "Title", director: "Jacob", count: 5)
	@State var item2: TVModel = TVModel(title: "TVTitle", director: "Emma", count: 10)
	// MARK: -  BODY
	var body: some View {
		VStack {
			Text(item.title)
			Text(item.director)
			Text("\(item.count)")
			
			Divider()
			
			Text(item2.title)
			Text(item2.director)
			Text("\(item2.count)")
		} //: VSTACK
	}
}

// MARK: -  PREVIEW
struct TypealiasBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		TypealiasBootCamp()
			.preferredColorScheme(.dark)
	}
}
