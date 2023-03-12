//
//  Search.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/12/23.
//

import SwiftUI


struct Search: View {
    
    enum FocusField: Hashable {
        case field
    }
    
    @State private var searchText: String = ""
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    TextField(text: $searchText) {
                        Text("Search Menu")
                            .font(.custom("Karla-Regular", size: 16))
                            .foregroundColor(.gray)
                    }
                    .focused($focusedField, equals: .field)
                    .onAppear {
                        self.focusedField = .field
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(.infinity)
                
                LazyVStack(spacing: 18) {
                    FetchedObjects(
                        predicate: buildPredicate(),
                        sortDescriptors: buildSortDescriptors()
                    ) { (dishes: [Dish]) in
                        ForEach(dishes, id: \.id) { dish in
                            NavigationLink(destination: ItemDetail(item: .constant(dish))) {
                                HStack(spacing: 12) {
                                    VStack(alignment: .leading) {
                                        Text(dish.title ?? "")
                                            .font(.custom("Karla-Bold", size: 18))
                                        Text(dish.summary ?? "")
                                            .font(.custom("Karla-Regular", size: 16))
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        Text("$\(dish.price ?? "")")
                                            .font(.custom("Karla-Medium", size: 16))
                                    }
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: 75, maxHeight: 100)
                                                .cornerRadius(12)
                                        case .failure:
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                        @unknown default:
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                        }
                                    }.frame(width: 75, height: 100)
                                }.frame(maxWidth: .infinity)
                            }
                            if dish.id != dishes.last?.id {
                                Divider()
                            }
                        }
                    }
                }
                .padding([.leading, .trailing, .top], 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            )
        ]
    }
    
    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true);
        }
        
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
