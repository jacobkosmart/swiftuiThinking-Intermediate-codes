//
//  MaskBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/10.
//

import SwiftUI

// mask 를 사용하지 않고,  클릭시 별 색 바뀌게 만들기
struct MaskBootCamp: View {
	// MARK: -  PROPERTY
	@State var rating: Int = 3
	
	// MARK: -  BODY
	var body: some View {
		ZStack {
			HStack {
				ForEach(1..<6) { index in
					Image(systemName: "star.fill")
						.font(.largeTitle)
						.foregroundColor(rating >= index ? Color.yellow : Color.gray)
						.onTapGesture {
							withAnimation(.spring()) {
								rating = index
							}
						}
				} //: LOOP
			} //: HSTACK
		} //: ZSTACK
	}
}

// MARK: -  PREVIEW
struct MaskBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		MaskBootCamp()
	}
}
