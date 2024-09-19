import Foundation

protocol KakaoTRepositoryInterface {
    func fetchVillageTagInfosTest() async throws -> [VillageTagEntity]
    
    func fetchFeedList() async throws -> [FeedEntity]
}

protocol KakaoTMockRepositoryInterface {
    func fetchMockFeedList() async throws -> [FeedEntity]
}
