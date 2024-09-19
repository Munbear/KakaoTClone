import SwiftUI

struct PostView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
    }
    
    var body: some View {
        ScrollView {
            if feedViewModel.feedList.isEmpty {
                Text("데이터 없음")
            }
            VStack(spacing: 20) {
                ForEach(feedViewModel.feedList, id: \.id) { feedData in
                    VStack(alignment: .leading) {
                        // 유저 프로필
                        HStack() {
                            //유저 프로필 이미지
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color(.lightGray))
                            VStack(alignment: .leading) {
                                Text("\(feedData.userName)")
                                Text(feedData.uploadLocation)
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundStyle(Color(.lightGray))
                            Text(feedData.locationName)
                        }.padding(.bottom, 8)
                        // 내용
                        Text(feedData.content).padding(.bottom, 16)
                        
                        // 사진
                        if feedData.feedImages.isEmpty {
                            Image("turtlerock")
                                .resizable()
                                .frame(height: 200)
                                .cornerRadius(8)
                                .aspectRatio(16/9, contentMode: .fill)
                            Spacer().frame(height: 24)
                        } else {
                            Image("turtlerock")
                                .resizable()
                                .frame(height: 200)
                                .cornerRadius(8)
                                .aspectRatio(16/9, contentMode: .fill)
                            Spacer().frame(height: 24)
                        }
                        
                        
                        
                        // 좋아요 버튼
                        HStack {
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "hand.thumbsup")
                                        .foregroundStyle(Color(.lightGray))
                                    Text(String(feedData.likeCount))
                                        .foregroundStyle(Color(.lightGray))
                                }
                            }
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "message")
                                        .foregroundStyle(Color(.lightGray))
                                    Text(String(feedData.commentCount))
                                        .foregroundStyle(Color(.lightGray))
                                }
                            }
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "eyes")
                                        .foregroundStyle(Color(.lightGray))
                                    Text(String(feedData.viewCount))
                                        .foregroundStyle(Color(.lightGray))
                                }
                            }
                        }
                        Spacer().frame(height: 16)
                        
                        // last comment preview
                        //                        HStack {
                        //                            Image("turtlerock")
                        //                                .resizable()
                        //                                .frame(width: 24, height: 24)
                        //                                .clipShape(Circle())
                        //                            Text("ㅇ로아러ㅣㄴ아러 ㅣ나얼ㅁㄴ이ㅏ러 미나어리만얼 ㅣ마너 ㅣ만어 ㄹ ").lineLimit(1)
                        //                        }
                        //                        Spacer().frame(height: 16)
                        
                        
                        
                        // 댓글 쓰기 버튼
                        Button {
                            
                        } label: {
                            HStack {
                                Image("turtlerock")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                Text("댓글 쓰기...")
                                    .foregroundStyle(Color(.lightGray))
                            }
                        }
                        Spacer().frame(height: 24)
                        Divider()
                    }.padding(.horizontal, 16)
                }
            }.padding(.bottom)
        }.task {
            do {
                try await feedViewModel.fetchFeedList()
                print("데이터 로드 성공: \(feedViewModel.feedList)")
            } catch {
                print("뷰 에러 핸들링")
                print("데이터 로드 실패: \(error)")
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    PostView(feedViewModel: .init(feedUseCase: .init(repository: MockFeedService())))
    
}
