//
//  MagnificationGestureBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/07.
//

import SwiftUI

struct MagnificationGestureBootCamp: View {
	// MARK: -  PROPERTY
	
	@State var currentAmount: CGFloat = 0
	
	// MARK: -  BODY
	var body: some View {
		VStack (spacing: 10) {
			
			HStack {
				Circle().frame(width: 35, height: 35)
				Text("SwiftUI Thinking")
				Spacer()
				Image(systemName: "ellipsis")
			} //: HSTACK
			.padding(.horizontal)
			
			Rectangle()
				.frame(height: 300)
				.scaleEffect(1 + currentAmount)
				.gesture(
					MagnificationGesture()
						.onChanged({ value in
							currentAmount = value - 1
						})
						.onEnded({ value in
							withAnimation(.spring()) {
								currentAmount = 0
							}
						})
				)
			
			HStack {
				Image(systemName: "heart.fill")
				Image(systemName: "text.bubble.fill")
				Spacer()
			} //: HSTACK
			.padding(.horizontal)
			.font(.headline)
			
			Text("This is the caption for my photo!")
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.horizontal)
		} //: VSTACK
	}
}

// MARK: -  PREVIEW
struct MagnificationGestureBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		MagnificationGestureBootCamp()
	}
}
