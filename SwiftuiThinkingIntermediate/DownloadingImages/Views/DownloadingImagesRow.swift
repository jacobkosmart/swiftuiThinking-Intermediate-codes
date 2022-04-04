//
//  DownloadingImagesRow.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import SwiftUI

struct DownloadingImagesRow: View {
	// MARK: -  PROPERTY
	let model: PhotoModel
	// MARK: -  BODY
	var body: some View {
		HStack {
			DownloadingImageView(url: model.url, key: "\(model.id)")
				.frame(width: 75, height: 75)
			VStack (alignment: .leading){
				Text(model.title)
					.font(.headline)
				Text(model.url)
					.foregroundColor(.gray)
					.italic()
			} //: VSTACK
			.frame(maxWidth: .infinity, alignment: .leading)
		} //: HSTACK
	}
}

// MARK: -  PREVIEW
struct DownloadingImagesRow_Previews: PreviewProvider {
	static var previews: some View {
		DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "Title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
	
