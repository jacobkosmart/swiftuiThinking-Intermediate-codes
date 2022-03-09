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

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 07.Present multiple sheets from a single view

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 08.mask

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 09.Sound effects

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 10.Haptic and vibrations

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 11.Local notifications

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

### 12.Hashable

```swift

```

  <img height="350"  alt="스크린샷" src="">

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
