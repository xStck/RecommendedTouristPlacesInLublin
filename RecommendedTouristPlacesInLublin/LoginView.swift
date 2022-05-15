//
//  ContentView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData


struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)])
    private var users: FetchedResults<User>
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    private var categories: FetchedResults<Category>
    
    @FetchRequest(entity: Opinion.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Opinion.rating, ascending: true)])
    private var opinions: FetchedResults<Opinion>
    
    @FetchRequest(entity: Place.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)])
    private var places: FetchedResults<Place>
    
    
    @State private var userUserName: String = ""
    
    var body: some View {
        VStack(){
            
            Spacer()
            Text("PODAJ NAZWĘ UŻYTKOWNIKA").font(.title)
            TextField("Nazwa użytkownika", text: $userUserName).underlineTextFieldStyle()
            Button(action: addData){
                Text("Przejdź dalej").buttonCustomStyle()
            }
            
            Spacer()
            FooterView()
        }
        
    }
    
    private func addData(){
        var newUser = User(context: viewContext)
        var newOpinion = Opinion(context: viewContext)
        var newCategory = Category(context: viewContext)
        var newPlace = Place(context: viewContext)
        
        //Dodawanie użytkowników
        let userNameArr: [String] = ["Andrzej", "Piotr", "Jakub"]
        for i in 0..<userNameArr.count{
            newUser.id = UUID()
            newUser.username = userNameArr[i]
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            newUser = User(context: viewContext)
        }
        
        //Dodawanie do bazy danych kategorii
        let categoryNameArr: [String] = ["Zabytek", "Restauracja", "Teatr", "Kino"]
        for i in 0..<categoryNameArr.count{
            newCategory.id = UUID()
            newCategory.name = categoryNameArr[i]
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            newCategory = Category(context: viewContext)
        }
        
        //Dodawanie do bazy danych zabytków
        var placeNameArr: [String] = ["Pałac Sobieskich", "Archikatedra św. Jana Chrzciciela i św. Jana Ewangelisty", "Baszta Gotycka"]
        var placeDescArr: [String] = ["Pałac Sobieskich (Radziwiłłów, Vetterów) został wybudowany w pierwszej połowie XVI wieku. Pierwotnie służył jako punkt obronny wysunięty poza mury miasta", "Ufundowana pod koniec XVI wieku katedra o barokowym wnętrzu ozdobionym freskami.", "Baszta Półokrągła zwana jest tak z racji swojego kształtu. Jest ona wraz z fragmentem murów obronnych, świadectwem gotyckich obwarowań staromiejskich."]
        var placeLongitudeArr: [String] = ["51.24513945062349","51.246899237466", "51.24686560691351"]
        var placeLattitudeArr: [String] = ["22.56628734638244", "22.568356426400396", "22.566617811484523"]
        addCategoryItemsToDB(categoryName: "Zabytek", placeNameArr: placeNameArr, placeDescArr: placeDescArr, placeLongitudeArr: placeLongitudeArr, placeLattitudeArr: placeLattitudeArr)
        
        //Dodawanie do bazy danych restauracji
        placeNameArr = ["Koper Włoski u Braci Mazur", "Restauracja Magia w Lublinie", "Pyzata Chata"]
        placeDescArr = ["Dania podawane na wspólnych talerzach i koktajle w bezpretensjonalnej restauracji włoskiej z tarasem.", "Tradycyjna restauracja serwująca sycące dania, tatary i pizze oraz koktajle, wina i mocne alkohole.", "Bezpretensjonalna, przytulna restauracja serwująca duże porcje takich potraw jak pierogi, kotlety i zupy."]
        placeLongitudeArr = ["51.23755448979576", "51.24841909740968", "51.24551039653255"]
        placeLattitudeArr = ["22.548470750409923", "22.567890389713853", "22.556392642409673"]
        addCategoryItemsToDB(categoryName: "Restauracja", placeNameArr: placeNameArr, placeDescArr: placeDescArr, placeLongitudeArr: placeLongitudeArr, placeLattitudeArr: placeLattitudeArr)
        
        
        
        //Dodawanie do bazy danych kin
        placeNameArr = ["Multikino","Cinema City","Kino Perła"]
        placeDescArr = ["Multikino w Lublinie zostało otwarte w listopadzie 2013 roku. Mieści się na pierwszym piętrze w Galerii Olimp.","Cinema City Felicity składa się z 9 klimatyzowanych sal, które pomieszczą jednocześnie blisko 1 700 widzów.","Funkcjonuje w sezonie wakacyjnym, od czerwca do sierpnia 5 dni w tygodniu, od środy do niedzieli wyświetlamy filmowe hity. Projekcje zaczynają się po zachodzie słońca."]
        placeLongitudeArr = ["51.26736717016585","51.23210987725407","51.243974482797086"]
        placeLattitudeArr = ["22.57117602346184","22.614365544970106","22.567327857030296"]
        addCategoryItemsToDB(categoryName: "Kino", placeNameArr: placeNameArr, placeDescArr: placeDescArr, placeLongitudeArr: placeLongitudeArr, placeLattitudeArr: placeLattitudeArr)
        
        
        //Dodawanie do bazy danych teatrów
        placeNameArr = ["Teatr ITP","Teatr Pierwszego Kontaktu","Teatr im. Hansa Christiana Andersena w Lublinie"]
        placeDescArr = ["Zespół został założony z inicjatywy salezjanina, ks. Mariusza Lacha w 2001 roku.","Teatr Pierwszego Kontaktu powstał w październiku 2005 roku w Lublinie. Pierwsza grupa wyłoniła się w wyniku warsztatów prowadzonych przez Henryka Kowalczyka – założyciela Teatru Scena 6, które odbywały się w Wojewódzkim Ośrodku Kultury.","Teatr im. H. Ch. Andersena jest miejscem, w którym to, co piękne i ciekawe płynnie przenika się z tym, co trudne i skłaniające do refleksji."]
        placeLongitudeArr = ["51.24819170076517","51.235935547887976","51.24678149283614"]
        placeLattitudeArr = ["22.544951139880023","22.504817079571794","22.548075803148798"]
        addCategoryItemsToDB(categoryName: "Teatr", placeNameArr: placeNameArr, placeDescArr: placeDescArr, placeLongitudeArr: placeLongitudeArr, placeLattitudeArr: placeLattitudeArr)
        
        
        //Dodawanie opinii do zabytków
        
        
        
    }
    
    func getCategoryByName(categoryName: String) -> Category{
        var aCategory: Category?
        do{
            let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            categoryFetchRequest.predicate = NSPredicate(format: "name == %@", categoryName)
            let fetchedResults = try viewContext.fetch(categoryFetchRequest)
            aCategory = fetchedResults.first!
        }catch{
            print("fetch task failed", error)
        }
        
        return aCategory!
    }
    
    func getPlaceByName(placeName: String) -> Place{
        var aPlace: Place?
        do{
            let placeFetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
            placeFetchRequest.predicate = NSPredicate(format: "name == %@", placeName)
            let fetchedResults = try viewContext.fetch(placeFetchRequest)
            aPlace = fetchedResults.first!
        }catch{
            print("fetch task failed", error)
        }
        
        return aPlace!
    }
    
    func getUserByUserName(userName: String) -> User{
        var aUser: User?
        do{
            let userFetchRequest: NSFetchRequest<User> = User.fetchRequest()
            userFetchRequest.predicate = NSPredicate(format: "username == %@", userName)
            let fetchedResults = try viewContext.fetch(userFetchRequest)
            aUser = fetchedResults.first!
        }catch{
            print("fetch task failed", error)
        }
        
        return aUser!
    }
    
    func addCategoryItemsToDB(categoryName: String, placeNameArr: [String], placeDescArr: [String], placeLongitudeArr: [String], placeLattitudeArr: [String]){
        let newPlace = Place(context: viewContext)
        for i in 0..<placeNameArr.count{
            newPlace.id = UUID()
            newPlace.name = placeNameArr[i]
            newPlace.desc = placeDescArr[i]
            newPlace.longitude = placeLongitudeArr[i]
            newPlace.lattitude = placeLattitudeArr[i]
            newPlace.category = getCategoryByName(categoryName: categoryName)
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
