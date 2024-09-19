import Foundation



struct TagInfo: Identifiable {
    let id: String
    let villageName: String
    let activeUserCount: String
}

final class VillageTagViewModel: ObservableObject {
    
    private let villageTagUseCase: VillageTagUseCase
    @Published private(set) var villageInfo: [TagInfo] = []
    
    
    init(villageTahUseCase: VillageTagUseCase) {
        self.villageTagUseCase = villageTahUseCase
    }
    
    func getVillageTagInfo() async throws {
        do {
            let villageEntities = try await villageTagUseCase.fetchVillageTagInfosTest()
            let tagInfos = villageEntities.map {
                TagInfo(
                    id: String($0.id),
                    villageName: $0.villageName,
                    activeUserCount: String($0.activeUserCount)
                )
            }
            
            self.villageInfo = tagInfos
        } catch {
            print("에러 핸들링")
        }
    }
}
