import SwiftUI
import Combine

struct CreatePostView: View {
    @State var textFieldText: String = ""
    @Binding var isShow: Bool
    @FocusState var focused: Bool
    @State private var keyboardHeight: CGFloat = 0
    
    
    @State var openPhoto = false
    @State var image: UIImage?
    
    
    // 키보드 노티피케이션을 구독하여 키보드 높이를 관리하는 함수
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.keyboardHeight = keyboardFrame.height
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.keyboardHeight = 0
        }
    }
    

    var body: some View {
        VStack() {
            Spacer().frame(height: 24)
            HStack {
                Button {
                    isShow = false
                } label: {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                Button {
                    
                } label: {
                     Text("완료")
                }
            }
            .padding(.horizontal, 16)
            
            
            Spacer().frame(height: 32)
            
            HStack(alignment: .firstTextBaseline) {
                ForEach(Categories.allCases) { category in
                    VStack {
                        Image(systemName: "bed.double.circle.fill")
                            .resizable()
                        .frame(width: 48, height: 48)
                        Text(category.rawValue)
                    }
                }
                Spacer()
            }.padding(.leading, 16)
            
            
            Spacer().frame(height: 24)
            Divider().padding(.horizontal, 16)
            Spacer().frame(height: 24)
            
            // 지역 선택
            VStack(alignment: .leading) {
                HStack {
                    Text("영등포구")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                Spacer().frame(height: 16)
                Text("Tip 지역이나 장소를 선택하면 빠르게 답변받을 수 있어요")
                
            }.padding(.horizontal, 16)
            
            Divider().frame(height: 8).overlay(Color("MyColor"))
            
            TextField("실시간 정보를 공유하거나 질문해보세요", text: $textFieldText, axis: .vertical)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .lineLimit(10)    
                .focused($focused)
            Spacer()
            
            // 사진 불러오기
            VStack {
                Spacer()
                HStack {
                    Button {
                        self.openPhoto.toggle()
                    } label: {
                        Image(systemName: "camera")
                    }.fullScreenCover(isPresented: $openPhoto) {
                        UImagePicker(sourceType: .photoLibrary) { (image) in
                            self.image = image
                        }
                    }
                    
                    Text("0/5")
                    Spacer()
                    Text("작성 유의 사항")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.white)
                // 시트가 아닌 사진 불러오기 버튼만 키보드 위로 이동
                .offset(y: -keyboardHeight)
                //.padding(.horizontal, 16)
//                .padding(.vertical, 16)
            }.animation(.easeInOut(duration: 0.3), value: keyboardHeight)
        }
        .onAppear {
            focused = true
            subscribeToKeyboardNotifications()
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
        .background(.white)
        .cornerRadius(12)
//        .animation(.easeInOut, value: keyboardHeight)
        
    }
}
//
#Preview {
    CreatePostView(isShow: .constant(true))
}
