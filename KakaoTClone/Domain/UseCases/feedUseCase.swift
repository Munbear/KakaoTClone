import Foundation


final class FeedUseCase {
//    let repository: KakaoTRepositoryInterface
//    init(repository: KakaoTRepositoryInterface) {
//        self.repository = repository
//    }
    
    let repository: KakaoTMockRepositoryInterface
    init(repository: KakaoTMockRepositoryInterface) {
        self.repository = repository
    }
    
    
    func fetchFeedList() async throws -> [FeedEntity] {
        let feedList = try await repository.fetchMockFeedList()
        print("피드 가짜 데이터: \(feedList)")
        return feedList
    }
}
