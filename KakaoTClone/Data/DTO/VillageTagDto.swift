import Foundation


struct VillageTagDataDTO: Codable {
    let villageTagInfos: [VillageTagDTO]
}

struct VillageTagDTO: Codable {
    var id: Int
    var villageName: String
    var activeUserCount: Int
}


extension VillageTagDTO {
    func toVillageTagEntity() -> VillageTagEntity {
        VillageTagEntity(id: id, villageName: villageName, activeUserCount: activeUserCount)
    }
}
