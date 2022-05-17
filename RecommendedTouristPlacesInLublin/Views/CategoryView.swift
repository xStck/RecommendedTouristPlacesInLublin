//
//  CategoryView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 16/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    private var categories: FetchedResults<Category>
    
    var body: some View {
        VStack{
            Spacer()
            List {
                ForEach(categories, id: \.id){category in
                    NavigationLink(destination: PlacesView(selectedCategoryName: category.name!)){
                        Text(category.name!)
                    }
                }
            }
            Spacer()
            FooterView()
        }.navigationBarTitle("Kategorie")
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
