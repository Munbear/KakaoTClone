import Foundation


struct FeedDataDTO: Codable {
    let feedList: [FeedDTO]
}

struct FeedDTO: Codable {
    var id: Int
    var profileImageUrl: String
    var userName: String
    var uploadLocation: String
    var locationName: String
    var content: String
    var feedImages: [String]
    var likeCount: Int
    var commentCount: Int
    var viewCount: Int

}
 
extension FeedDTO {
    func toFeedEntity() -> FeedEntity {
        FeedEntity(
            id: id,
            profileImageUrl: profileImageUrl,
            userName: userName,
            uploadLocation: uploadLocation,
            locationName: locationName,
            content: content,
            feedImages: feedImages,
            likeCount: likeCount,
            commentCount: commentCount,
            viewCount: viewCount
        )
    }
}
