//
//  villageChip.swift
//  KakaoTClone
//
//  Created by 박도원 on 9/12/24.
//

import SwiftUI

struct CustomAppBar: View {
    var body: some View {
        HStack(alignment: .top) {
            Button{
                print("내 프로필 화면으로 이동")
            } label: {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .background(Color(.white), in: Circle())
                    .foregroundStyle(.black)
                    .shadow(radius: 3)
            }
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        Image(systemName: "map.fill")
                        Text("당산제2동").fontWeight(.semibold).font(.system(size: 18))
                    }
                    Text("95명 가는중").fontWeight(.light).font(.system(size: 14))
                }
                Spacer().frame(width: 16)
                Button(action: {}, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(12)
                        .background(Color("MyColor"), in: Circle())
                })
                .buttonStyle(.plain)
                .tint(.secondary)
                .foregroundStyle(.black)

            }
            .padding(.trailing, 16)
            .padding(.leading, 32)
            .padding(.vertical, 8)
            .background(.white)
            .cornerRadius(50)
            .shadow(radius: 4)
            
            Spacer()
            Button{
                print("내 프로필 화면으로 이동")
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 2)
                    }
                    .foregroundStyle(.gray)
                    .background(Circle().fill(Color.white))

            }
        }
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    Group {
//        ContentView(viewModel: .init(villageTahUseCase: .init(repository: FirestoreService())))
//    }
//    
//}
