//
//  MultipleSheetBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/09.
//

import SwiftUI

// 3 - Use $item

// MARK: -  MODEL
struct RandomModel: Identifiable {
	let id = UUID().uuidString
	let title: String
}

struct MultipleSheetBootCamp: View {
	// MARK: -  PROPERTY
	@State var selectedModel: RandomModel? = nil
	
	
	// MARK: -  BODY
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack (spacing: 20) {
				// 버튼 50개 생성
				ForEach(0..<50) { index in
					Button {
						selectedModel = RandomModel(title: "\(index)")
					} label: {
						Text("Button \(index)")
					}
				}
			} //: VSTACK
			.sheet(item: $selectedModel) { model in
				NextScreen(selectedModel: model)
			}
		} //: SCROLL
	}
}

// MARK: -  NEXTSCREEN
struct NextScreen: View {
	
	let selectedModel: RandomModel
	
	var body: some View {
		Text(selectedModel.title)
			.font(.largeTitle)
	}
}

// MARK: -  PREVIEW
struct MultipleSheetBootCamp_Previews: PreviewProvider {
	
	static var previews: some View {
		MultipleSheetBootCamp()
	}
}
