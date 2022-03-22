//
//  HashableBootCamp.swift
//  SwiftuiThinkingIntermediate
//
//  Created by Jacob Ko on 2022/03/18.
//

import SwiftUI

// Model
// 2-1
// 모델을 사용할경우 hashValue 를 사용하려면 hashable protocol 을 사용하면 됩니다. 주로 ID 값이 있는 경우가 많기
// 때문에 Identifiable protocol 을 사용합니다(그러면 반드시 모델에 ID 값이 있어야 합니다)
struct MyDateModel1: Identifiable {
	let id =  UUID().uuidString // id 값은 UUID() 을 사용하면 swift 에서 random ID 을 생성하고 String 타입으로 바꿔 줍니다
	// 만약 데이터 모델에 id 값이 있다면 hashable protocol 을 사용할 필요가 없습니다.
	let title: String
}

struct MyDateModel2: Hashable {
	let title: String
	
	// hash valse 값을 생성해주는 함수를 만들어 줘야 합니다
	// hash into inout 함수를 만들어 주고,
	func hash(into hasher: inout Hasher) {
		hasher.combine(title) // 이렇게 하면 hash 의 고유의 hash value 값이 생성이 됩니다. 단점을 title 의 값이
		// 중복이 되면 hasher 의 값이 같아지기 때문에 사용하려면 중복의 값이 없어야 합니다
	}
}


struct HashableBootCamp: View {
	
	// 1-1. 먼저 요일데이터 변수를 만들어 보겠습니다
	let dateArray1: [String] = [
		"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"
	]
	
	// 2-1. 모델을 사용해서 데이터 만들기
	let dateArray2: [MyDateModel1] = [
		MyDateModel1(title: "일요일"),
		MyDateModel1(title: "월요일"),
		MyDateModel1(title: "화요일"),
		MyDateModel1(title: "수요일"),
		MyDateModel1(title: "목요일"),
		MyDateModel1(title: "금요일"),
		MyDateModel1(title: "토요일")
	]
	
	// 3-1. Hashable protocol 사용
	let dateArray3: [MyDateModel2] = [
		MyDateModel2(title: "일요일"),
		MyDateModel2(title: "월요일"),
		MyDateModel2(title: "화요일"),
		MyDateModel2(title: "수요일"),
		MyDateModel2(title: "목요일"),
		MyDateModel2(title: "금요일"),
		MyDateModel2(title: "토요일")
	]
	
	var body: some View {
		
		// Part 1. Basic hashable
		
		// 2. 스크롤뷰 만들어주고, 그 안에 vstack 만들고 그 안에 data 를 forEach 로 반복문을 돌려 줍니다
		ScrollView {
			VStack (spacing: 20) {
				// 3. ForEach 에서 data, id, content parameter 가 있는것을 선택 해 줍니다. dataArray 넣어주고
				// 4. id 는 자기자신의 고유값이 될수 있게 \.self 해줍니다 (이것을 하게되면, 반복문을 돌때 그 하나의 object 마다 id 값을 부여하게 되는것입니다
				// 5. Enter 누루고 item in 해주면 반복문이 돌떼 마가 그 하나의 오브젝트 값이 item 이라는 변수로 불릴 수 있게 되서 거기에 접근할 수 있게 됩니다
				ForEach(dateArray1, id: \.self) { item in
					Text(item)
						.font(.headline)
					// 6. 위와 같이 하면 각각의 item 들은 고유의 hash value 갑을 가질 수 있게 됩니다
					
					Text(item.hashValue.description)
						.font(.headline)
					// 각각의 item 값에 hash 값을 화면에 표시 할 수 있습니다. 각각의 값이 다른게 보이시죠?
					// 위의 hash 값들은 반복문을 돌면서 프로그램에서 랜덤 하게 각가의 값들에 게 고유의 숫자 값을 부여 합니다
				}
			}
		}
		
		// Part 2. Model 만들어서 identifiable protocol 사용하기
		ScrollView {
			VStack (spacing: 20) {
				// 2-3
				// 이미 model 에 id 값이 있기 때문에 위와 같이 \.self 값을 안 넣어 줘도 됩니다
				ForEach(dateArray2) { item in
					Text(item.title)
						.font(.headline)
					Text(item.id) // UUID 로 생성한 ID
				}
				// 이렇게 사용하면 part 1. 에서 만들 것과 비슷하게 hash 값이 고유의 ID 값이 되어서 사용할 수 있게 됩니다
			}
		}
		
		// Part 3. Hashable protocol 사용하기
		// 만약 Model 에 ID 값이 없는경우 UUID() 를 사용하지 않고 hashable protocol 을 사용해서 고유의 hash value 값을 사용하는 예시를 만들겠습니다
		ScrollView {
			VStack (spacing: 20) {
				ForEach(dateArray3, id: \.self) { item in
					Text(item.hashValue.description)
						.font(.headline)
				}
			}
		}
		// 위의 예시들을 보게 되면 id 값이 없는 경우에는 hash 함수를 만들어줘서 각각의 고유값을 부여 할 수 있으나,
		// UUID 를 사용해서 고유의 ID 값을 주게 되면 더 간편히 hash 값을 부여하는것과 유사하게 각각의 반복문에서 고유의 ID
		// 값을 줄 수 있습니다
		// 지금까지 hasherble 의 개념 과 사용방법에 대해서 설명 드렸습니다. 다음 강의에서 뵙겠습니다. 감사합니다
	}
}

struct HashableBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		HashableBootCamp()
	}
}
