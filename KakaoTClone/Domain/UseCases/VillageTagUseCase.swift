import Foundation


final class VillageTagUseCase {
    let repository: KakaoTRepositoryInterface
    
    init(repository: KakaoTRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchVillageTagInfosTest() async throws -> [VillageTagEntity] {
        let villageTagInfos = try await repository.fetchVillageTagInfosTest()
        return villageTagInfos
    }
}
