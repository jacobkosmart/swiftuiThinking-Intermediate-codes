//
//  ScrollViewReaderBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/09.
//

import SwiftUI

struct ScrollViewReaderBootCamp: View {
	// MARK: -  PROPERTY
	@State var scrollToIndex: Int = 0
	@State var textFieldText: String = ""
	
	// MARK: -  BODY
	var body: some View {
		VStack {
			TextField("Ender a # here", text: $textFieldText)
				.frame(height: 55)
				.border(Color.gray)
				.padding(.horizontal)
				.keyboardType(.numberPad)
			
			Button {
				withAnimation(.easeInOut) {
					if let index = Int(textFieldText) {
						scrollToIndex = index
					}
				}
			} label: {
				Text("Scroll Now")
			}
			
			ScrollView {
				// proxy is basically reading the size of the scroll view
				ScrollViewReader { proxy in
					ForEach(0..<50) { index in
						Text("This is item #\(index)")
							.frame(height: 200)
							.frame(maxWidth: .infinity)
							.background(Color.white)
							.cornerRadius(10)
							.shadow(radius: 10)
							.padding()
							.id(index)
					} //: LOOP
					.onChange(of: scrollToIndex) { newValue in
						withAnimation(.spring()) {
							proxy.scrollTo(newValue, anchor: .top)
						}
					}
				} //: SCROLLREADER
			} //: SCROLL
		} //: VSTACK
	}
}

// MARK: -  PREVIEW
struct ScrollViewReaderBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ScrollViewReaderBootCamp()
	}
}
