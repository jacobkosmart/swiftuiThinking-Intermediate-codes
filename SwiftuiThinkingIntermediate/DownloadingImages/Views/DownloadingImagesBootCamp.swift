//
//  DownloadingImagesBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/04/04.
//

import SwiftUI

struct DownloadingImagesBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject  var vm = DownloadingImagesViewModel()
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			List {
				ForEach(vm.dataArray) { model in
					DownloadingImagesRow(model: model)
				} //: LOOP
			} //: LIST
			.listStyle(.plain)
			.navigationTitle("Downloading Images!")
		} //: NAVIGATION
	}
}

// MARK: -  PREVIEW
struct DownloadingImagesBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		DownloadingImagesBootCamp()
			.preferredColorScheme(.dark)
	}
}
