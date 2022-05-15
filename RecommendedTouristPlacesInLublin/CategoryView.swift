
import SwiftUI
struct Category: Hashable{
    var name:String = ""
    var id:Int = 0
}
 
struct ContentView: View {
 
    //zastapic kategoriami z bazy danych
    @State var categories: [Category] = [
        Category(name: "Zabytki", id: 0),
        Category(name: "Restauracje", id: 1),
        Category(name: "Teatry", id: 2),
        Category(name: "Kina", id: 3)
    ]
    
    var body: some View {
        VStack{
            NavigationView{
                List{
                    ForEach(categories, id: \.self){
                        category in
                        NavigationLink(destination: CategoryDetailView(category: category.name)){
                            HStack{
                                Text(category.name).padding(10).font(.title.weight(.bold)).foregroundColor(.blue)
                            }
                        }
                    }
                }.navigationTitle("Wybierz kategorię")
            }
        }
    }
}
 
struct CategoryDetailView: View{
    var category: String
    
    var body: some View{
        VStack{
            Text(category}.font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
