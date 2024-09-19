import Foundation

struct FeedData: Identifiable {
    let id: String
    let profileImageUrl: String
    let userName: String
    let uploadLocation: String
    let locationName: String
    let content: String
    let feedImages: [String]
    let likeCount: Int
    let commentCount: Int
    let viewCount: Int
}

final class FeedViewModel: ObservableObject {
    
    private let feedUseCase: FeedUseCase
    @Published private(set) var feedList: [FeedData] = []
    
    init(feedUseCase: FeedUseCase) {
        self.feedUseCase = feedUseCase
    }
    
    
    // 피드 게시글 가져오기
    func fetchFeedList() async throws {
        do {
            let feedEntities = try await feedUseCase.fetchFeedList()
            let feedData = feedEntities.map {
                FeedData(
                    id: String($0.id),
                    profileImageUrl: $0.profileImageUrl,
                    userName: $0.userName,
                    uploadLocation: $0.uploadLocation,
                    locationName: $0.locationName,
                    content: $0.content,
                    feedImages: $0.feedImages,
                    likeCount: $0.likeCount,
                    commentCount: $0.commentCount,
                    viewCount: $0.viewCount
                )
            }
            self.feedList = feedData
        } catch {
            print("에러 핸들링")
        }
    }
}
