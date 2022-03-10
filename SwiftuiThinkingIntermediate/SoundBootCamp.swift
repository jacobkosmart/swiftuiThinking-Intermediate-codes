//
//  SoundBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/10.
//

import SwiftUI
import AVKit


// MARK: -  VIEWMODEL

class SoundManager: ObservableObject {
	
	var player: AVAudioPlayer?
	
	enum SoundOption: String {
		case tada
		case badum
	}
	
	func playSound(sound: SoundOption) {
		
		guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
		
		do {
			player = try AVAudioPlayer(contentsOf: url)
			player?.play()
		} catch let error {
			print("Error playing sound. \(error.localizedDescription)")
		}
	}
}

struct SoundBootCamp: View {
	@StateObject private var vm: SoundManager = SoundManager()
	
	// MARK: -  BODY
	var body: some View {
		VStack (spacing: 40) {
			Button {
				vm.playSound(sound: .tada)
			} label: {
				Text("Play sound 1")
			}
			
			Button {
				vm.playSound(sound: .badum)
			} label: {
				Text("Play sound 2")
			}
		} //: VSTACK
	}
}

// MARK: -  PREVIEW
struct SoundBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		SoundBootCamp()
	}
}
