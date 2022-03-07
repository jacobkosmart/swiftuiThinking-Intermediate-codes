//
//  RotationGestrueBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/07.
//

import SwiftUI

struct RotationGestrueBootCamp: View {
	// MARK: -  PROPERTY
	
	@State var angle: Angle = Angle(degrees: 0)
	
	// MARK: -  BODY
	var body: some View {
		Text("Hello, World!")
			.font(.largeTitle)
			.fontWeight(.semibold)
			.foregroundColor(.white)
			.padding(50)
			.background(Color.blue)
			.cornerRadius(10)
			.rotationEffect(angle)
			.gesture(
				RotationGesture()
					.onChanged({ value in
						angle = value
					})
					.onEnded({ value in
						withAnimation(.spring()) {
							angle = Angle(degrees: 0)
						}
					})
			)
	}
}

// MARK: -  PREVIEW
struct RotationGestrueBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		RotationGestrueBootCamp()
	}
}
