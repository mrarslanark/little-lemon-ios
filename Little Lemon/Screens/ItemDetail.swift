//
//  ItemDetail.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/11/23.
//

import SwiftUI

struct ItemDetail: View {
    
    @Binding var item: Dish?
    
    var body: some View {
        VStack {
            NavigationBar()
            AsyncImage(url: URL(string: item?.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
            }.frame(maxWidth: .infinity, maxHeight: 300)
            VStack {
                Text(item?.title ?? "Title")
                    .font(.custom("MarkaziText-Regular", size: 40))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(item?.category?.capitalized ?? "Starters")
                        .font(.custom("Karla-ExtraBold", size: 16))
                        .foregroundColor(Color("Gray 3"))
                    Spacer()
                    Text("$\(item?.price ?? "Price")")
                        .font(.custom("Karla-Medium", size: 16))
                }
                Text(item?.summary ?? "Description")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .font(.custom("Karla-Regular", size: 16))
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding([.leading, .trailing], 25)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(item: .constant(nil))
    }
}
