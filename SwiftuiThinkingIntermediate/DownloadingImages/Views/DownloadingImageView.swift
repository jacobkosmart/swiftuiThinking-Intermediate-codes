//
//  DownloadingImageView.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import SwiftUI

struct DownloadingImageView: View {
	// MARK: -  PROPERTY
	@StateObject var loader: ImageLoadingViewModel
	// MARK: -  INIT
	init(url: String, key: String) {
		_loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
	}
	// MARK: -  BODY
	var body: some View {
		ZStack {
			if loader.isLoading {
				ProgressView()
			} else if let image = loader.image {
				Image(uiImage: image)
					.resizable()
					.clipShape(Circle())
			}
		} //: ZSTACK
	}
}

// MARK: -  PREVIEW
struct DownloadingImageView_Previews: PreviewProvider {
	static var previews: some View {
		DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
			.frame(width: 75, height: 75)
			.previewLayout(.sizeThatFits)
	}
}
