//
//  DragGestureBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/08.
//

import SwiftUI

struct DragGestureBootCamp: View {
	// MARK: -  PROPERTY
	
	@State var offset: CGSize = .zero
	
	// MARK: -  BODY
	var body: some View {
		ZStack {
			
			VStack {
				Text("\(offset.width)")
				Spacer()
			} //: VSTACK
			
			RoundedRectangle(cornerRadius: 20)
				.frame(width: 300, height: 500)
				.offset(offset)
				.scaleEffect(getScaleAmount())
				.rotationEffect(Angle(degrees: getRotationAmount()))
				.gesture(
					DragGesture()
						.onChanged({ value in
							withAnimation(.spring()) {
								offset = value.translation
							}
						})
						.onEnded({ value in
							withAnimation(.spring()) {
								offset = .zero
							}
						})
			)
		} //: ZSTACK
	}
	
	// MARK: -  FUNCTION
	func getScaleAmount() -> CGFloat {
		let max = UIScreen.main.bounds.width / 2
		// 절대값으로 abs 붙여줌
		let currentAmount = abs(offset.width)
		let percentage = currentAmount / max
		// 최소 값이 0.5 에서 천천히 변하기 위해 * 0.5 해줌
		return 1.0 - min(percentage, 0.5) * 0.5
	}
	
	func getRotationAmount() -> Double {
		let max = UIScreen.main.bounds.width / 2
		let currentAmount = offset.width
		let percentage = currentAmount / max
		let percentageAsDouble  = Double(percentage)
		let maxAngle: Double = 10
		return percentageAsDouble * maxAngle
	}
}

// MARK: -  PREVIEW
struct DragGestureBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		DragGestureBootCamp()
	}
}
