//
//  GeometryReaderBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/09.
//

import SwiftUI

struct GeometryReaderBootCamp: View {
	// MARK: -  BODY
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(0..<20) { index in
					GeometryReader { geometry in
						RoundedRectangle(cornerRadius: 20)
							.rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 10), axis: (x: 0.0, y: 1.0, z: 0.0))
					}
					.frame(width: 300, height: 250)
					.padding()
				}
			} //: HSTACK
		} //: SCROLL
	}
	// MARK: -  FUNCTION
	func getPercentage(geo: GeometryProxy)-> Double {
		let maxDistance = UIScreen.main.bounds.width / 2
		let currentX = geo.frame(in: .global).midX
		return Double(1 - (currentX / maxDistance))
	}
}
	
	// MARK: -  PREVIEW
	struct GeometryReaderBootCamp_Previews: PreviewProvider {
		static var previews: some View {
			GeometryReaderBootCamp()
		}
	}

