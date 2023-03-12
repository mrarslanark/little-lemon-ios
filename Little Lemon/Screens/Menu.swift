//
//  Menu.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/4/23.
//

import SwiftUI

enum MenuCategories: String, CaseIterable {
    case starters
    case mains
    case desserts
    case sides
}

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var navigateToListItem = false
    @State private var selectedFilter: MenuCategories?
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .padding([.top, .bottom], 16)
                
                // Hero Section
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: -8) {
                        Text("Little Lemon")
                            .font(.custom("MarkaziText-Medium", size: 48))
                            .foregroundColor(Color("Primary Color 2"))
                        Text("Chicago")
                            .font(.custom("MarkaziText-Regular", size: 30))
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 18) {
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist")
                            .font(.custom("Karla-Regular", size: 16))
                            .foregroundColor(.white)
                        Image("Hero Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 100, maxHeight: 100)
                            .cornerRadius(12)
                            .scaledToFill()
                    }
                    Spacer(minLength: 16)
                    NavigationLink(destination: Search()) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(.infinity)
                }
                .padding(25)
                .frame(maxWidth: .infinity)
                .background(Color("Primary Color 1"))
                
                // Category Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Order for Delivery".uppercased())
                        .font(.custom("Karla-ExtraBold", size: 20))
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack {
                            ForEach(MenuCategories.allCases, id: \.self) { category in
                                Text(category.rawValue.capitalized)
                                    .font(.custom("Karla-ExtraBold", size: 16))
                                    .padding(12)
                                    .background(selectedFilter == category ? Color("Secondary Color 4") : Color("Secondary Color 3"))
                                    .cornerRadius(12)
                                    .foregroundColor(selectedFilter == category ? .white : .black)
                                    .onTapGesture {
                                        if selectedFilter == category {
                                            selectedFilter = nil
                                        } else {
                                            selectedFilter = category
                                        }
                                    }
                            }
                        }
                    }
                    .frame(maxHeight: 60)
                }
                .padding(EdgeInsets(top: 16, leading: 25, bottom: 16, trailing: 25))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color("Secondary Color 3"))
                
                
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
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }.onAppear {
            getMenuData()
        }
    }
    
    private func getMenuData() {
        
        // Clear the core data initially before fetching data from the API
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let data {
                    let decoder = JSONDecoder()
                    let fullMenu = try decoder.decode(MenuList.self, from: data)
                    fullMenu.menu.forEach { menu in
                        let dish = Dish(context: viewContext)
                        dish.title = menu.title
                        dish.image = menu.image
                        dish.price = menu.price
                        dish.summary = menu.summary
                        dish.category = menu.category
                    }
                    try? viewContext.save()
                }
            } catch let error {
                print(String(describing: error))
            }
        }
        task.resume()
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
        if selectedFilter == nil {
            return NSPredicate(value: true);
        }

        return NSPredicate(format: "category == %@", selectedFilter!.rawValue)
    }
}


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
