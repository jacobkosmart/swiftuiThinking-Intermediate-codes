## SwiftUI Thinking Intermediate code 모음

### 👉 [강의 채널 바로가기](https://www.youtube.com/playlist?list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar)

---

### 01.onLongPressGesture

The tap gesture when you tap on it the action occurs immediately as soon as you tap on it

Teh long press gesture we can set an amount of time that we need to tap and hold or press and hold before the action executes

```swift
struct LongPressGestureBootCamp: View {
// MARK: -  PROPERTY

@State var isComplete: Bool = false

// MARK: -  BODY
var body: some View {
  Text(isComplete ? "COMPLETED" : "NOT COMPLETE")
    .padding()
    .padding(.horizontal)
    .background(isComplete ? Color.green : Color.gray)
    .cornerRadius(10)
  // click button and immediately changed color
    // .onTapGesture {
    // 	isComplete.toggle()
    // }
  // if click and hold for about on second it will switch
  // maximumDistance is move user finger witin 50 points and it should still work
    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
      isComplete.toggle()
    }
}
}

```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/156956561-f995e6f8-6224-4919-8615-aee40912e743.gif">

```swift
struct LongPressGestureBootCamp: View {
// MARK: -  PROPERTY

@State var isComplete: Bool = false
@State var isSuccess: Bool = false

// MARK: -  BODY
var body: some View {
VStack {
Rectangle()
.fill(isSuccess ? Color.green : Color.blue)
.frame(maxWidth: isComplete ? .infinity : 0)
.frame(height: 55)
.frame(maxWidth: .infinity, alignment: .leading)
.background(Color.gray)

HStack {
Text("CLICK HERE")
.foregroundColor(.white)
.padding()
.background(Color.black)
.cornerRadius(10)
.onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
  // start of press -> min duration
  if isPressing {
    withAnimation(.easeInOut(duration: 1.0)) {
      isComplete = true
    }
  } else {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      if !isSuccess {
        withAnimation(.easeInOut) {
          isComplete = false
        }
      }
    }
  }

} perform: {
  // at the min duration
  withAnimation(.easeInOut) {
    isSuccess = true
  }
}

Text("RESET")
.foregroundColor(.white)
.padding()
.background(Color.black)
.cornerRadius(10)
.onTapGesture {
  isComplete = false
  isSuccess = false
}
}
} //: VSTACK
}
}
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/156958039-d2e24e86-f380-463f-a51e-37fb5025629d.gif">

---

### 02.MagnificationGesture

magnification gesture basically the zoom in and out gesture that you use on the map on your iphone. if you have instagram you can zoom in on pictures that is a magnification gesture

```swift
struct MagnificationGestureBootCamp: View {
// MARK: -  PROPERTY

@State var currentAmount: CGFloat = 0
@State var lastAmount: CGFloat = 0

// MARK: -  BODY
var body: some View {
Text("Hello, World!")
.font(.title)
.padding(40)
.background(Color.red)
.cornerRadius(10)
.scaleEffect(1 + currentAmount + lastAmount)
.gesture(
  MagnificationGesture()
    .onChanged({ value in
      currentAmount = value - 1
    })
    .onEnded({ value in
      lastAmount += currentAmount
      currentAmount = 0
    })

)
}
}
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/156959748-1604953e-0397-40a7-8cc3-c105a5aefbeb.gif">

```swift

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
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/156960792-f55f2b76-debe-44ed-8ab0-12c04f404f5e.gif">

---

### 03.RotationGesture

Rotation gesture is when you have two fingers on the device and you rotating an object and we can use it to rotate images, rotate text or rotate pretty much anything that we want on our swiftUI application

```swift
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
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/156961759-14048266-1a21-452d-a7a5-4cd4c10d3124.gif">

---

### 04.DragGesture

The drag gesture is what it sounds like it's when you drag something around the screen. It is really cool features such as swiping on cards if you could use a drag gesture to swipe the cards left and right drag gesture to swipe up or swipe down different screens in our app

```swift
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
```

<img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157175819-34accd0b-a501-4f57-be49-986a721ac8b4.gif">

```swift
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
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157179054-386adbf1-c18f-41eb-84e4-9e4550656a7f.gif">

---

### 05.ScrollViewReader

When we add a very basic scroll view to application we can scroll manually up and down but we cannot automatically scroll to the bottom or scroll to the middle or scroll anywhere automatically in that scroll view

In ScrollViewReader to th app can add features to automatically scroll to the bottom of our scroll view or to any certain point in our scroll view

```swift
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
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157370971-3716cd7a-6834-4654-b421-3eb620ecf3ad.gif">

---

### 06.GeometryReader

Using GeometryReader we can basically get the exact size and location of objects on the screen.

Sometimes when you are building complex applications you do want make sure certain things are specific sizes or maybe specific locations on your app an to do that we can use the geometry reader

GeometryReader is very expensive it costs a lot of computing power to use and you put too many geometry readers and the geometries are doing a lot of tasks on the screen

```swift
struct GeometryReaderBootCamp: View {

// MARK: -  BODY
var body: some View {
// geometry which is the size basically of the content that's inside it
GeometryReader { geometry in
HStack (spacing: 0) {
  Rectangle()
    .fill(Color.red)
  //  UIScreen.main.bounds.width 으로 크기를 설정하면 rotation 할때 크기가 고정되지 않음
    // .frame(width: UIScreen.main.bounds.width * 0.6666)
    // GeometryReader 를 사용하면 rotation 되도 같은 설정으로 유지됨
    .frame(width: geometry.size.width * 0.6666)
  Rectangle()
    .fill(Color.blue)
} //: HSTACK
.ignoresSafeArea()
}
}
}
```

![Kapture 2022-03-09 at 13 31 56](https://user-images.githubusercontent.com/28912774/157373187-08b4bef0-c721-4253-bb6b-6208087e3067.gif)

```swift
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
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157374782-98714811-673c-4173-82bc-ef5d7395b398.gif">

---

### 07.Present multiple sheets from a single view

Use a sheet modifier they try to add some conditional logic in the sheet and then go to present a second or third screen it's wring screen

#### 1. Use a binding

단점은 nextScreen 이 복잡해지고 변수가 많을 경우에는 일일히 다 binding 해줘야 되서 code 가 복잡해짐

```swift
import SwiftUI

// 1 - Use a binding

// MARK: -  MODEL
struct RandomModel: Identifiable {
	let id = UUID().uuidString
	let title: String
}

struct MultipleSheetBootCamp: View {
// MARK: -  PROPERTY
@State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
@State var showSheet: Bool = false
@State var selectedIndex: Int = 0


// MARK: -  BODY
var body: some View {
VStack (spacing: 20) {
  Button {
    selectedIndex = 1
    selectedModel = RandomModel(title: "One")
    showSheet.toggle()
  } label: {
    Text("Button 1")
  }

  Button {
    selectedIndex = 2
    selectedModel = RandomModel(title: "Two")
    showSheet.toggle()
  } label: {
    Text("Button 2")
  }
} //: VSTACK
.sheet(isPresented: $showSheet) {
  // selectedModel 이 이미 초기값 상태 (starting Title) 인상태 에서 넘어가기 때문에 sheet 을 닫은다음에
  // 다시 열어야지 title 이 업데이트가 됨
  // 1번째 방법: Use a binding - 단점은 nextScreen 이 복잡해지고 변수가 많을 경우에는 일일히 다 binding 해줘야 되서 code 가 복잡해짐
  NextScreen(selectedModel: $selectedModel)
}
}
}

// MARK: -  NEXTSCREEN
struct NextScreen: View {

@Binding var selectedModel: RandomModel

var body: some View {
  Text(selectedModel.title)
    .font(.largeTitle)
}
}
```

#### 2. Use multiple sheets

Creating two sheets all you have to do is make sure they are not in the same hierarchy of each other

```swift
import SwiftUI

// 2 - Use multiple .sheets

// MARK: -  MODEL
struct RandomModel: Identifiable {
let id = UUID().uuidString
let title: String
}

struct MultipleSheetBootCamp: View {
// MARK: -  PROPERTY
@State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
@State var showSheet: Bool = false
@State var showSheet2: Bool = false


// MARK: -  BODY
var body: some View {
VStack (spacing: 20) {
  Button {
    showSheet.toggle()
  } label: {
    Text("Button 1")
  }
  .sheet(isPresented: $showSheet) {
    NextScreen(selectedModel: RandomModel(title: "One"))
  }

  Button {
    showSheet2.toggle()
  } label: {
    Text("Button 2")
  }
  .sheet(isPresented: $showSheet2) {
    NextScreen(selectedModel: RandomModel(title: "Two"))
  }
} //: VSTACK
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
```

#### 3. Use $item

2번 방법에서 multiple .sheets 를 사용하면 해결 되지만 만약 필요로 하는 sheet 의 갯수가 많아지면 일일히 다 만들어야 되기 때문에, $item 방법으로 multiple .sheet 을 만들 수 있습니다

```swift
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

```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157386876-d5d07e7f-0fa1-483e-a6be-e434994090fa.gif">

---

### 08.mask

We have one view that is on the bottom then another view that's on the top and then we can mask the top view so that it confirms to the same shape as the bottom view -> Thiis is the mask modifier

```swift
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
      rating = index
    }
} //: LOOP
} //: HSTACK
} //: ZSTACK
}
}
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157586084-89a96a9c-e89d-409f-8751-9177c6955c7d.gif">

```swift
struct MaskBootCamp: View {
// MARK: -  PROPERTY
@State var rating: Int = 0

// MARK: -  BODY
var body: some View {
ZStack {
starsView
.overlay(
  overlayView
    .mask(starsView)
)
} //: ZSTACK
}

private var overlayView: some View {
GeometryReader { geometry in
ZStack(alignment: .leading) {
Rectangle()
  .foregroundColor(.yellow)
  .frame(width: CGFloat(rating) / 5 * geometry.size.width)
} //: ZSTACK
} //: GEOMETRY
.allowsHitTesting(false)
}

private var starsView: some View {
HStack {
ForEach(1..<6) { index in
Image(systemName: "star.fill")
  .font(.largeTitle)
  .foregroundColor(Color.gray)
  .onTapGesture {
    withAnimation(.easeInOut) {
      rating = index
    }
  }
} //: LOOP
} //: HSTACK
}
}
```

## <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/157588713-c3c41f0d-38a7-44ed-957b-53161850406c.gif">

### 09.Sound effects

```swift
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
@StateObject var vm: SoundManager = SoundManager()

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

```

---

### 10.Haptic and vibrations

In iOS when user clicks or error message you can add vibrations to the device

```swift
import SwiftUI


class HapticManager {
	static let instance = HapticManager() // Singleton

	func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(type)
	}

	func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
		let generaotr = UIImpactFeedbackGenerator(style: style)
		generaotr.impactOccurred()
	}
}

struct HapticsBootCamp: View {
	var body: some View {
		VStack (spacing: 20) {
			Button("success") { HapticManager.instance.notification(type: .success) }
			Button("warning") { HapticManager.instance.notification(type: .warning) }
			Button("error") { HapticManager.instance.notification(type: .error) }

			Divider()

			Button("soft") { HapticManager.instance.impact(style: .soft) }
			Button("light") { HapticManager.instance.impact(style: .light) }
			Button("medium") { HapticManager.instance.impact(style: .medium) }
			Button("rigid") { HapticManager.instance.impact(style: .rigid) }
			Button("heavy") { HapticManager.instance.impact(style: .heavy) }
		}
	}
}
```

  <!-- <img height="350"  alt="스크린샷" src=""> -->

---

### 11.Local notifications

Local notifications we can actually set up and create within the application ourselves while the real push notifications are coming from a server

For example, local notification that occurs every monday or every day at 5:00 pm like application we have all of the data to know exactly when to send all of those notifications

But, if you want notifications to happen based on other user interactions like shut down server to notice users urgently you actually need a server and there's a lot more logic involved.

There are three trigger based on time, calendar, location

```swift

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
static let instance = NotificationManager() // Singleton

func requestAuthorization() {
  let options: UNAuthorizationOptions = [.alert, .sound, .badge]

  UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error)  in
    if let error = error {
      print("ERROR: \(error)")
    } else {
      print("SUCCESS")
    }
  }
}

func scheduleNotification() {
  let content = UNMutableNotificationContent()
  content.title = "This is my first notification"
  content.subtitle = "This is sooo easy!"
  content.sound = .default
  content.badge = 1

  // 3 trigger type

  // time
  // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)

  // calendar
  // var datecomponents = DateComponents()
  // datecomponents.hour = 20
  // datecomponents.minute = 26
  // datecomponents.weekday = 1 // 1은 일요일, 6은 금요일일 됨
  // let trigger = UNCalendarNotificationTrigger(dateMatching: datecomponents, repeats: true)

  // location
  let cordinates = CLLocationCoordinate2D(
    latitude: 40.00,
    longitude: 50.00)

  let region = CLCircularRegion(
    center: cordinates,
    radius: 100,
    identifier: UUID().uuidString)

  region.notifyOnEntry = true // 현재 위치에서 cordinate 지정한 위치로 들어올때 region 활성화
  region.notifyOnExit = true // 현재 위치에서 cordinate 지정한 위치로 나갈때 region 활성화

  let trigger = UNLocationNotificationTrigger(region: region, repeats: true)

  let request = UNNotificationRequest(
    identifier: UUID().uuidString,
    content: content,
    trigger: trigger)
  UNUserNotificationCenter.current().add(request)
}

func cancelNotification() {
  UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
  UNUserNotificationCenter.current().removeAllDeliveredNotifications()
}
}

struct NotificationBootCamp: View {
var body: some View {
VStack (spacing: 40) {
  Button("Request Permission") {
    NotificationManager.instance.requestAuthorization()
  }
  Button("Schedile notification") {
    NotificationManager.instance.scheduleNotification()
  }

  Button("Cancel notification") {
    NotificationManager.instance.cancelNotification()
  }
} //: VSTACK
.onAppear {
  // App 이 열리면 badge number 를 0으로 해줌
  UIApplication.shared.applicationIconBadgeNumber = 0
}
}
}
```

  <!-- <img height="350"  alt="스크린샷" src=""> -->

---

### 12.Hashable

```swift
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
```

<p>
<img width="350" alt="image" src="https://user-images.githubusercontent.com/28912774/159608391-4fa07caf-923f-4ea9-bab8-3c390af5ff26.png">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/28912774/159608446-0692fac8-abc4-4f68-abdd-301230d9a7f9.png">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/28912774/159608515-731438b0-f2f2-4c32-8cd5-38307e58db57.png">

</p>

---

### 13.Sort, Filter and Map

A lot of times after you get data into your app your're going to want to either filter or sort even transform it. So that the data that we put on the screen is maybe subset of the original data

```swift
// MARK: -  MODEL
struct UserModel: Identifiable {
let id = UUID().uuidString
let name: String?
let points: Int
let isVerified: Bool
}

// MARK: -  VIEWMODEL

class ArrayModificationViewModel: ObservableObject {
// MARK: -  PROPERTY

@Published var dataArray: [UserModel] = []
@Published var filteredArray: [UserModel] = []
@Published var mappedArray: [String] = []

// MARK: -  INIT
init() {
  getUsers()
  updateFilteredArray()
}

// MARK: -  FUNCTION
func getUsers() {
  let user1 = UserModel(name: "Jacob", points: 90, isVerified: true)
  let user2 = UserModel(name: "Christ", points: 0, isVerified: false)
  let user3 = UserModel(name: "Joe", points: 20, isVerified: true)
  let user4 = UserModel(name: "Emily", points: 35, isVerified: false)
  let user5 = UserModel(name: "Samantha", points: 45, isVerified: true)
  let user6 = UserModel(name: "Sarah", points: 50, isVerified: true)
  let user7 = UserModel(name: "Jason", points: 76, isVerified: false)
  let user8 = UserModel(name: nil, points: 79, isVerified: true)
  let user9 = UserModel(name: nil, points: 80, isVerified: true)
  let user10 = UserModel(name: "Amanda", points: 100, isVerified: true)
  self.dataArray.append(contentsOf: [
    user1,
    user2,
    user3,
    user4,
    user5,
    user6,
    user7,
    user8,
    user9,
    user10,
  ])
}

func updateFilteredArray() {

  /*
  1. Sort
  filteredArray = dataArray.sorted { user1, user2 in
    user1.points > user2.points
  }
  위에 sort 를 줄여서 사용하기
  filteredArray = dataArray.sorted(by: { $0.points > $1.points })
  */

  /*
  2. Filter
  filteredArray = dataArray.filter({ user in
    user.isVerified
  })

  filter 줄여서 사용하기
  filteredArray = dataArray.filter({ $0.isVerified })
  */

  /*
  3. Map
  여기서는 convert array of users to an array of String 으로 타입을 변환하기
  mappedArray = dataArray.map({ (user) -> String in
    user.name
  })
  map 도 줄여서 사용하기
  mappedArray = dataArray.map({ $0.name })
  */

  // 4. compactMap
  // 만약에 model에 name 이 optional 의 경우일때 그냥 map 을 사용하게 되면 optional 이기 때문에
  // error 발생함
  // compatMap 을 사용하면 값이 있는 것만 골라서 나타냄
  // mappedArray = dataArray.compactMap({ $0.name })

  // 5. sort, filter, map 섞어서 사용하기
  mappedArray = dataArray
    .sorted(by: { $0.points > $1.points })
    .filter({ $0.isVerified })
    .compactMap({ $0.name })
}
}

struct ArraysBootCamp: View {
// MARK: -  PROPERTY
@StateObject var vm = ArrayModificationViewModel()

// MARK: -  BODY
var body: some View {
ScrollView {
VStack (spacing: 20) {
/*
1. Sort, filter UI 예시
ForEach(vm.filteredArray) { user in
  VStack (alignment: .leading){
    Text(user.name)
      .font(.headline)
    HStack {
      Text("Ponits: \(user.points)")
      Spacer()
      if user.isVerified {
        Image(systemName: "flame.fill")
      }
    } //: HSTACK
  } //: VSTACK
  .foregroundColor(.white)
  .padding()
  .background(Color.blue.cornerRadius(10))
  .padding(.horizontal)
} //: LOOP
*/

// 2. map UI 예시
ForEach(vm.mappedArray, id: \.self) { name in
  Text(name)
    .font(.title)
}
} //: VSTACK
} //: SCROLL
}
}

```

- Sorting Data

<img width="350" alt="image" src="https://user-images.githubusercontent.com/28912774/159621206-a8b16571-d7e2-4521-b639-63b221a1b88a.png">

- Filter Data

<img width="310" alt="image" src="https://user-images.githubusercontent.com/28912774/159621581-0090fd64-16d7-4566-9e15-7a68322ec182.png">

- Map Data

<img width="306" alt="image" src="https://user-images.githubusercontent.com/28912774/159622362-961295fc-a82e-4f56-8c93-3f0381118060.png">

- 다 합쳐서 같이 쓰기

<img width="312" alt="image" src="https://user-images.githubusercontent.com/28912774/159623238-5e3d4034-7a04-4a9a-8ce8-4ce2a92b8e27.png">

---

### 14.Core Data

To use Core Data stored within the device to save data to it and this data would persist between sessions so if a user closes the app and reopens the app

#### FetchRequest

- 새로운 프로젝트 만들고 Core Data 를 체크하면 apple 에서 제공하는 template 을 통해서 @FetchRequest property 를 사용해서, CoreData 에 CRUD 를 하는 예제 입니다

<img width="1089" alt="image" src="https://user-images.githubusercontent.com/28912774/159641050-37918c94-755d-46db-bd03-2f418a916007.png">

```swift
// in @main
import SwiftUI

@main
struct CoreDataBootCampApp: App {
let persistenceController = PersistenceController.shared

var body: some Scene {
WindowGroup {
  ContentView()
    .environment(\.managedObjectContext, persistenceController.container.viewContext)
}
}
}
```

```swift
// in Persistence

import CoreData

struct PersistenceController {
static let shared = PersistenceController()

static var preview: PersistenceController = {
let result = PersistenceController(inMemory: true)
let viewContext = result.container.viewContext
for x in 0..<10 {
let newFruit = FruitEntity(context: viewContext)
newFruit.name = "Apple \(x)"
}
do {
try viewContext.save()
} catch {
// Replace this implementation with code to handle the error appropriately.
// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
let nsError = error as NSError
fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
}
return result
}()

let container: NSPersistentContainer

init(inMemory: Bool = false) {
container = NSPersistentContainer(name: "CoreDataBootCamp")
if inMemory {
container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
}
container.viewContext.automaticallyMergesChangesFromParent = true
container.loadPersistentStores(completionHandler: { (storeDescription, error) in
if let error = error as NSError? {
  // Replace this implementation with code to handle the error appropriately.
  // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

  /*
    Typical reasons for an error here include:
    * The parent directory does not exist, cannot be created, or disallows writing.
    * The persistent store is not accessible, due to permissions or data protection when the device is locked.
    * The device is out of space.
    * The store could not be migrated to the current model version.
    Check the error message to determine what the actual problem was.
    */
  fatalError("Unresolved error \(error), \(error.userInfo)")
}
})
}
}

```

```swift
// in ContentView

import SwiftUI
  import CoreData

  struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
  entity: FruitEntity.entity(),
  sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)])
  var fruits: FetchedResults<FruitEntity>

  @State var textFiedlText: String = ""

  var body: some View {
  NavigationView {
  VStack (spacing: 20) {

  TextField("Add fruit here...", text: $textFiedlText)
    .font(.headline)
    .padding(.leading)
    .foregroundColor(.white)
    .frame(maxWidth: .infinity)
    .frame(height: 55)
    .padding(.horizontal)

  Button {
    addItem()
  } label: {
    Text("Submit")
      .font(.headline)
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .frame(height: 55)
      .background(Color.cyan.cornerRadius(10))
  }
  .padding(.horizontal)


  List {
    ForEach(fruits) { fruit in
      Text(fruit.name ?? "")
        .onTapGesture {
          updateItem(fruit: fruit)
        }
    }
    .onDelete(perform: deleteItems)
  }
  .navigationTitle("Fruits")
  }
  .background(.ultraThickMaterial)
  }
  }

private func addItem() {
  withAnimation {
    let newFruit = FruitEntity(context: viewContext)
    newFruit.name = textFiedlText
    saveItem()
    textFiedlText = ""
  }
}

private func updateItem(fruit: FruitEntity) {
  withAnimation {
    let currentName = fruit.name ?? ""
    let newName = currentName + "!"
    fruit.name = newName

    saveItem()
  }
}

private func deleteItems(offsets: IndexSet) {
  withAnimation {
    guard let index = offsets.first else { return }
    let fruitEntity = fruits[index]
    viewContext.delete(fruitEntity)
    saveItem()
  }
}

private func saveItem() {
  do {
    try viewContext.save()
  } catch {
    // Replace this implementation with code to handle the error appropriately.
    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    let nsError = error as NSError
    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
  }
}
}

private let itemFormatter: DateFormatter = {
let formatter = DateFormatter()
formatter.dateStyle = .short
formatter.timeStyle = .medium
return formatter
}()

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
}

```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/159642146-00056d0d-c69f-4a90-b87c-7e9455be85c9.gif">

#### Core Data with MVVM

위의 스크린샷과 결과는 같지만, MVVM 로직으로 작성하는 방법 (Core data template 사용하지 않고 하기)

- 먼저 new file 에서 core data 파일을 만들고, `Add Entity -> Attribute 에서 Name: String ` 순으로 core data 속성만들기

```swift
import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - manges the data for a view

// MARK: -  VIEWMODEL
class CoreDataViewModel: ObservableObject {
// MARK: -  PROPERTY
// NSPersistentContainer 생성
let container: NSPersistentContainer
// fetch 되서 저장될 data Array 만듬
@Published var savedEntitied: [FruitEntity] = []

// MARK: -  INIT
init() {
  // container 는 core data 의 FruitsContainer file 이름임
  container = NSPersistentContainer(name: "FruitsContainer")
  // container 의 loadPersistentStores 해줘서 core Data 로드 함
  container.loadPersistentStores { description, error in
    if let error = error {
      print("ERROR LOADING CORE DATA: \(error)")
    } else {
      print("Successfully loaded core data!")
    }
  }
  // Fruits 데이터 가져옴
  fetchFruits()
}
// MARK: -  FUNCTION

func fetchFruits() {
  // core core 에 데이터 요청함
  let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")

  do {
    // error 가 없으면 container 에서 fetch 해옴
    savedEntitied = try container.viewContext.fetch(request)
  } catch let error {
    // error 처리함
      print("Error fetching. \(error)")
  }
}

func addFruits(text: String) {
  // new entity 의 attribute 생성
  let newFruit = FruitEntity(context: container.viewContext)
  // 입력 받은 text 가 새로운 데이터가 됨
  newFruit.name = text
  // 데이터 저장
  saveData()
}

func updateFruit(entity: FruitEntity) {
  // 선택된 entity 의 이름 가져옴
  let currentName = entity.name ?? ""
  // 실행될때 마다 ! 추가 시킴
  let newName = currentName + "!"
  // ! 된것을 entity name 에 저장 시킴
  entity.name = newName
  saveData()
}


func deleteFruit(indexSet: IndexSet) {
  // 선택된 indexSet 에서 index 를 번호를 가져와서
  guard let index = indexSet.first else { return }
  // 그 index 에 맏는 값을 찾아서 entity 에 넣어서
  let entity = savedEntitied[index]
  // 그값을 삭제함
  container.viewContext.delete(entity)
  // 그리고 다시 저장
  saveData()
}

// 저장, 업데이트, 삭제 하고나서 반드시 core data 도 데이터를 갱신해줘야 하기 때문에 저장을 진행 해야 함
func saveData() {
  do {
    // error 가 없으면, 저장 진행하고, 데이터 다시 불러옴
    try container.viewContext.save()
    fetchFruits()
  } catch let error {
      print("Error saving. \(error)")
  }
}
}


struct CoreDataBootCamp: View {
// MARK: -  PROPERTY
@State  var vm = CoreDataViewModel()
@State  var textFieldText: String = ""


// MARK: -  BODY
var body: some View {
NavigationView {
VStack (spacing: 20) {
TextField("Add fruit here...", text: $textFieldText)
  .font(.headline)
  .padding(.leading)
  .frame(height: 55)
  .background(Color.init(UIColor.placeholderText))
  .cornerRadius(10)
  .padding(.horizontal)

Button {
  // textField 가 비어있지 않으면 다음 로직 진행 비어 있으면 return
  guard !textFieldText.isEmpty else { return }
  // addFruit 함수에 textFieldText 입력
  vm.addFruits(text: textFieldText)
  // add 되면 textFieldText 다시 "" 로 초기화
  textFieldText = ""
} label: {
  Text("SAVE")
    .foregroundColor(.white)
    .font(.headline)
    .frame(height: 55)
    .frame(maxWidth: .infinity)
    .background(Color.cyan.cornerRadius(10))
}
.padding(.horizontal)


List {
  ForEach(vm.savedEntitied) { entity in
    Text(entity.name ?? "NO NAME")
      .onTapGesture {
        vm.updateFruit(entity: entity)
      }
  }
  .onDelete(perform: vm.deleteFruit)

}
.listStyle(.plain)

Spacer()
}
.navigationTitle("Fruit")
}
}
}
```

  <img height="350"  alt="스크린샷" src="">

#### Core Data with relationships

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 15.Background threads and Queues

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 16.Weak self

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 17.Typealias

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 18.Escaping

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 19.Codable

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 20.Downland Json

#### Downland Json with escaping

```swift

```

  <img height="350"  alt="스크린샷" src="">

#### Downland Json with Combine

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 21.Timer and onReceive

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 22.Custom publishers and Subscribers in Combine

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 23.FileManager

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 24.NSCache

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 25.Download and Save images

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

###

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

<!-- <p align="center">
  <img height="350"  alt="스크린샷" src="">
</p> -->

<!-- README 한 줄에 여러 screenshoot 놓기 예제 -->
<!-- <p>
   <img height="350" alt="스크린샷" src="">
   <img height="350" alt="스크린샷" src="">
   <img height="350" alt="스크린샷" src="">
</p> -->

---

<!-- 🔶 🔷 📌 🔑 👉 -->

## 🗃 Reference

SwiftUI Continued Learning (Intermediate Level) - [https://www.youtube.com/c/SwiftfulThinking](https://www.youtube.com/c/SwiftfulThinking)
