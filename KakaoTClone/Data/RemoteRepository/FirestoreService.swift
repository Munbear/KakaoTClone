import Foundation
import FirebaseFirestore


final class FirestoreService: KakaoTRepositoryInterface{
    private let db = Firestore.firestore()
    
    func fetchVillageTagInfosTest() async throws -> [VillageTagEntity] {
        let ref = db.collection("areaInfo").document(DocumentKey.villageInfo)
        do {
            let docSnapshot = try await ref.getDocument()
            if let data = docSnapshot.data(), let villageInfoArray = data["areaInfo"] as? [[String: Any]] {
                let castingData: [VillageTagDTO] = villageInfoArray.map { villageInfo in
                    return VillageTagDTO(
                        id: villageInfo["id"] as? Int ?? 0,
                        villageName: villageInfo["villageName"] as? String ?? "",
                        activeUserCount: villageInfo["activeUserCount"] as? Int ?? 9
                    )
                }
                return castingData.map { $0.toVillageTagEntity() }
            } else {
                print("문서 없음요")
                return []
            }
        } catch {
            print("에러 핸들링")
            return []
        }
    }
    
    func fetchFeedList() async throws -> [FeedEntity] {
        let ref = db.collection("feed").document(DocumentKey.feed)
        do {
            let snapshot = try await ref.getDocument()
            if let data = snapshot.data(), let feedDataArray = data["feed"] as? [[String: Any]] {
                let castingData: [FeedDTO] = feedDataArray.map { feedData in
                    return FeedDTO(
                        id: feedData["id"] as? Int ?? 0,
                        profileImageUrl:feedData["profileImageUrl"] as? String  ?? "",
                        userName: feedData["userName"] as? String ?? "",
                        uploadLocation: feedData["uploadLocation"] as? String ?? "",
                        locationName: feedData["locationName"] as? String ?? "",
                        content: feedData["content"] as? String ?? "",
                        feedImages: feedData["feedImages"] as? [String] ?? [],
                        likeCount: feedData["likeCount"] as? Int ?? 0,
                        commentCount: feedData["commentCount"] as? Int ?? 0,
                        viewCount: feedData["viewCount"] as? Int ?? 0)
                }
                print("케스팅 데이터 \(castingData)")
                return castingData.map { $0.toFeedEntity() }
            } else {
                print("피드 데이터 뭔가 잘못됨")
                return []
            } 
        } catch {
            print("뭔가 잘못됨")
            return []
        }
    }
}
