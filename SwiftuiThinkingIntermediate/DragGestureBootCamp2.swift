//
//  DragGestureBootCamp2.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/08.
//

import SwiftUI

struct DragGestureBootCamp2: View {
	// MARK: -  PROPERTY
	
	@State var startOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
	@State var currentDragOffsetY: CGFloat = 0
	@State var endingOffsetY: CGFloat = 0
	
	// MARK: -  BODY
	var body: some View {
		ZStack {
			// Background
			Color.green.ignoresSafeArea()
			
			// Foreground
			MySingUpView()
				.offset(y: startOffsetY)
				.offset(y: currentDragOffsetY)
				.offset(y: endingOffsetY)
				.gesture(
					DragGesture()
						.onChanged({ value in
							withAnimation(.spring()) {
								currentDragOffsetY = value.translation.height
							}
						})
						.onEnded({ value in
							withAnimation(.spring()) {
								if currentDragOffsetY < -150 {
									// cancel offset
									endingOffsetY = -startOffsetY
								} else if endingOffsetY != 0 && currentDragOffsetY > 150 {
									endingOffsetY = 0
								}
								currentDragOffsetY = 0
							}
						})
				)
			
			Text("\(currentDragOffsetY)")
		} //: ZSTACK
		.ignoresSafeArea(edges: .bottom)
	}
}

// MARK: -  PREVIEW
struct DragGestureBootCamp2_Previews: PreviewProvider {
	static var previews: some View {
		DragGestureBootCamp2()
	}
}


// MARK: -  EXTENSION
struct MySingUpView: View {
	var body: some View {
		VStack (spacing: 20) {
			Image(systemName: "chevron.up")
				.padding(.top)
			Text("Sign up")
				.font(.headline)
				.fontWeight(.semibold)
			
			Image(systemName: "flame.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
			
			Text("This is the decription for our app. This is my favorite SwiftUI course and I recommend to all of my fiends to subscribe to SwiftUI Thinking!")
				.multilineTextAlignment(.center)
			
			Text("Create An Account")
				.foregroundColor(.white)
				.font(.headline)
				.padding()
				.padding(.horizontal)
				.background(Color.black.cornerRadius(10))
			
			Spacer()
		} //: VSTACK
		.frame(maxWidth: .infinity)
		.background(Color.white)
		.cornerRadius(30)
	}
}
