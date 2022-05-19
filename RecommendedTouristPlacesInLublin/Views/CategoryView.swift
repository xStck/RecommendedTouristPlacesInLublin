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
    @State private var changeDayNight: Bool = false

    var body: some View {
        VStack{
            Toggle(isOn: $changeDayNight){
                if(changeDayNight == false){
                    Text("Zmień na tryb nocny").dayNightStyleText(toggle: changeDayNight)
                }else{
                    Text("Zmień na tryb dzienny").dayNightStyleText(toggle: changeDayNight)
                }
            }
            Spacer()
            List {
                ForEach(categories, id: \.id){category in
                    NavigationLink(destination: PlacesView(selectedCategoryName: category.name!, userUserName: self.$userUserName)){
                        Text(category.name!).dayNightStyleText(toggle: self.changeDayNight)
                    }
                }.dayNightStyleBackgroundList(toggle: changeDayNight)
            }.onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            VStack(){Text("")}
            Spacer()
            FooterView()
        }.navigationBarTitle("Kategorie", displayMode: .inline).dayNightStyleBackground(toggle: changeDayNight)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(userUserName: .constant(""))
    }
}
