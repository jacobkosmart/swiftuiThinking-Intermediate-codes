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

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 14.Core Data

#### FetchRequest

```swift

```

  <img height="350"  alt="스크린샷" src="">

#### Core Data with MVVM

```swift

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
