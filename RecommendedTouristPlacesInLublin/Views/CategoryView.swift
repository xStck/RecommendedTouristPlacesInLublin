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
    
    @Binding var userUserName: String
    @Binding var changeDayNight: Bool
    
    var body: some View {
        VStack{
            ToggleView(changeDayNight: $changeDayNight)
            
            Spacer()
            
            List {
                ForEach(categories, id: \.id){category in
                    NavigationLink(destination: PlacesView(selectedCategoryName: category.name!, userUserName: self.$userUserName, changeDayNight: self.$changeDayNight)){
                        Text(category.name!)
                            .dayNightStyleText(toggle: self.changeDayNight)
                    }
                }
                .dayNightStyleBackgroundList(toggle: changeDayNight)
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            
            Spacer()
            
        }
        .navigationBarTitle("Kategorie", displayMode: .inline)
        .dayNightStyleBackground(toggle: changeDayNight)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(userUserName: .constant(""), changeDayNight: .constant(false))
    }
}
