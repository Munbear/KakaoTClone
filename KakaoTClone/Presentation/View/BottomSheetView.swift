import SwiftUI

struct BottomSheetView: View {
    @State private var offsetY: CGFloat = 0
    @State private var lastOffsetY: CGFloat = 0
    
    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    var lowHeight: CGFloat {
        screenHeight * 0.20
    }
    
    var middleHeight: CGFloat {
        screenHeight * 0.55
    }
    
    var highHeight: CGFloat {
        screenHeight - getSafeAreaInsets().top - getSafeAreaInsets().bottom
    }
    
    @State private var currentHeight: CGFloat = 0
    @State private var showCreatePostView = false
    @State private var opacity = 0.0
    
    
//    var feedViewModel: FeedViewModel {
////        let repository = FirestoreService()
//        let repository = MockFeedService()
//        let useCase = FeedUseCase(repository: repository)
//        return FeedViewModel(feedUseCase: useCase)
//    }
    
    @ObservedObject var feedViewModel: FeedViewModel
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                VStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 52, height: 4)
                        .foregroundColor(.gray)
                        .padding(.top, 16)
                        .padding(.bottom, 24)
                    
                    
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(Categories.allCases) { category in
                            VStack {
                                Image(systemName: "bed.double.circle.fill")
                                    .resizable()
                                .frame(width: 48, height: 48)
                                Text(category.rawValue)
                            }
                        }
                    }
                    Spacer().frame(height: 16)
                    
                    Divider().padding(.horizontal, 16)
                    
                    // 필터
                    HStack() {
                        Button {
                            
                        } label: {
                            HStack {
                                Text("인기순")
                                    .font(.callout)
                                    .foregroundStyle(.black)
                                
                                
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .frame(width: 12, height: 6)
                                    .foregroundColor(Color("Gray600"))
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                        }
                        .background(.white) // 배경색
                        .cornerRadius(25) // 둥근 모서리
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("Gray400"), lineWidth: 1) // 1px의 갈색 테두리
                        )
                        Spacer()
                        
                        // 검색 버튼
                        Button {
                            
                        } label: {
                            HStack {
                                Text("내용 검색")
                                    .font(.callout)
                                    .foregroundStyle(Color("Gray600"))
                                
                                
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 14)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                        }
                        .background(Color("MyColor")) // 배경색
                        .cornerRadius(25) // 둥근 모서리
                    }.padding(.horizontal, 16)
                    
                    
                    // 피드 리스트
                    PostView(feedViewModel: feedViewModel)
                }
                .frame(width: geometry.size.width, height: highHeight) // 바텀 시트의 크기
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: screenHeight - currentHeight) // offset으로 바텀 시트 위치 조정
                .gesture(
                    DragGesture().onChanged { value in
                        let dragAmount = value.translation.height + lastOffsetY
                        
                        // 사용자가 드래그하는 동안 바텀 시트의 위치를 업데이트
                        if dragAmount > screenHeight - highHeight && dragAmount < screenHeight - lowHeight {
                            offsetY = dragAmount
                        }
                    }.onEnded { _ in
                        
                        let currentOffset = screenHeight - offsetY
                        let closePosition = nearestPosition(to: currentOffset)
                        
                        withAnimation {
                            currentHeight = closePosition
                        }
                        
                        lastOffsetY = screenHeight - currentHeight
                    }
                ).onAppear {
                    // 초기 높이를 중간 높이로 설정
                    currentHeight = middleHeight
                    lastOffsetY = screenHeight - currentHeight
                }
            }.ignoresSafeArea(edges: .bottom)
        }
    }
    // 세 단계 중 가장 가까운 위치로 스냅하는 함수
    func nearestPosition(to currentHeight: CGFloat) -> CGFloat {
        let heights = [lowHeight, middleHeight, highHeight]
        return heights.min(by: { abs($0 - currentHeight) < abs($1 - currentHeight) }) ?? middleHeight
    }
    
    func getSafeAreaInsets() -> UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return .zero
        }
        return window.safeAreaInsets
    }
}


//#Preview {
//    ContentView(feedViewModel: .init(feedUseCase: .init(repository: MockFeedService()
//}
