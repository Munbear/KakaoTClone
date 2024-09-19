import SwiftUI
import Combine

struct ContentView: View {
    @State var draw: Bool = true
    @State private var isShowCreatePostView = false
    @ObservedObject var feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(draw: true).edgesIgnoringSafeArea(.all)
            HStack(alignment: .top) {
                CustomAppBar()
            }
            Spacer()
            BottomSheetView(feedViewModel: feedViewModel)
           
            // 게시글 작성하기 Floathing action button
            Button {
                isShowCreatePostView.toggle()
            } label: {
                Image(systemName: "square.and.pencil.circle.fill")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    .background(Circle().fill(.white))
                    .foregroundStyle(.purple)
            }
            .padding(.trailing, 10)
            .position(CGPoint(x: UIScreen.main.bounds.width * 0.9, y: UIScreen.main.bounds.height * 0.85 ))
            
            // 게시글 작성 화면
            if isShowCreatePostView {
                CreatePostView(isShow: $isShowCreatePostView)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: isShowCreatePostView)
                    .padding(.top, 1)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }.animation(.easeInOut, value: isShowCreatePostView)
    }
}

#Preview {
    ContentView(feedViewModel: .init(feedUseCase: .init(repository: MockFeedService())))
}
