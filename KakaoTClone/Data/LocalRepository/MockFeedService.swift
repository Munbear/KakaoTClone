import Foundation

final class MockFeedService: KakaoTMockRepositoryInterface {
    
    func fetchMockFeedList() async throws -> [FeedEntity] {
        (0...8).map {
            FeedEntity(
                id: $0,
                profileImageUrl: "",
                userName: "이름넘버$0",
                uploadLocation: "당산제\($0)동",
                locationName: "허브족발 \($0)호 점",
                content: "\($0)번 째로 오고 있는데 너무 맛있어요",
                feedImages: [],
                likeCount: $0,
                commentCount: $0,
                viewCount: $0
            )
        }
    }
}
