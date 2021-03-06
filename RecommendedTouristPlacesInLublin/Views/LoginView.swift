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
    @State private var changeDayNight: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(){
                
                HeaderView()
                Divider()
                ToggleView(changeDayNight: $changeDayNight)
                Divider()
                
                Text("PODAJ NAZWĘ UŻYTKOWNIKA")
                    .font(.title)
                    .dayNightStyleText(toggle: changeDayNight)
                
                HStack(){
                    Image(systemName: "person.fill").dayNightStyleBackgroundIcon(toggle: self.changeDayNight)
                    TextField("", text: $userUserName)
                        .underlineTextFieldStyle()
                        .dayNightStyleText(toggle: changeDayNight)
                }
                if(userUserName.isEmpty){
                    Text("Aby przejść dalej, podaj swoją nazwę użytkownika")
                        .foregroundColor(Color.red)
                }else{
                    NavigationLink(destination: CategoryView(userUserName: self.$userUserName, changeDayNight: $changeDayNight)){
                        Text("Przejdź dalej")
                            .buttonCustomStyle()
                    }
                    .simultaneousGesture(TapGesture().onEnded{_ in
                        self.addUser()
                    })
                }
                
                
                VStack{
                    Image("Lublin_logo").resizable().aspectRatio(contentMode: .fit)
                }.frame(width: CGFloat(100), height: CGFloat(100))
                
                Spacer()
                
                FooterView()
            }
            .navigationBarTitle("Nazwa użytkownika", displayMode: .inline)
            .onAppear{self.addData()}
            .dayNightStyleBackground(toggle: changeDayNight)
        }
    }
    
    private func addData(){
        if(users.isEmpty && categories.isEmpty && opinions.isEmpty && places.isEmpty){
            var newUser = User(context: viewContext)
            var newCategory = Category(context: viewContext)
            
            //Dodawanie użytkowników do bazy danych
            let userNameArr: [String] = ["Andrzej", "Piotr", "Jakub"]
            
            for i in 0..<userNameArr.count{
                if(i != 0){
                    newUser = User(context: viewContext)
                }
                
                newUser.id = UUID()
                newUser.username = userNameArr[i]
                
                do{
                    try viewContext.save()
                }catch{
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            
            //Dodawanie kategorii do bazy danych
            let categoryNameArr: [String] = ["Zabytki", "Restauracje", "Teatry", "Kina"]
            
            for i in 0..<4{
                if(i != 0){
                    newCategory = Category(context: viewContext)
                }
                
                newCategory.id = UUID()
                newCategory.name = categoryNameArr[i]
                
                do{
                    try viewContext.save()
                }catch{
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            
            //Dodawanie miejsc do bazy danych
            var placeNameArr: [String] = ["Pałac Sobieskich", "Archikatedra św. Jana Chrzciciela i św. Jana Ewangelisty", "Baszta Gotycka", "Koper Włoski u Braci Mazur", "Restauracja Magia w Lublinie", "Pyzata Chata", "Teatr ITP", "Teatr Pierwszego Kontaktu", "Teatr im. Hansa Christiana Andersena w Lublinie", "Multikino", "Cinema City", "Kino Perła"]
            
            var placeImageArr: [String] = ["zabytekpalacsobieskich", "zabytekarchikatedra", "zabytekbasztagotycka", "restauracjakoperwloski", "restauracjamagiawlublinie", "restauracjapyzatachata", "teatritp", "teatrpierwszegokontaktu", "teatrhansa", "kinomultikino", "kinocinemacity", "kinokinoperla"]
            
            var placeDescArr: [String] = ["Pałac Sobieskich (Radziwiłłów, Vetterów) został wybudowany w pierwszej połowie XVI wieku. Pierwotnie służył jako punkt obronny wysunięty poza mury miasta", "Ufundowana pod koniec XVI wieku katedra o barokowym wnętrzu ozdobionym freskami.", "Baszta Półokrągła zwana jest tak z racji swojego kształtu. Jest ona wraz z fragmentem murów obronnych, świadectwem gotyckich obwarowań staromiejskich.", "Dania podawane na wspólnych talerzach i koktajle w bezpretensjonalnej restauracji włoskiej z tarasem.", "Tradycyjna restauracja serwująca sycące dania, tatary i pizze oraz koktajle, wina i mocne alkohole.", "Bezpretensjonalna, przytulna restauracja serwująca duże porcje takich potraw jak pierogi, kotlety i zupy.", "Zespół został założony z inicjatywy salezjanina, ks. Mariusza Lacha w 2001 roku.", "Teatr Pierwszego Kontaktu powstał w październiku 2005 roku w Lublinie. Pierwsza grupa wyłoniła się w wyniku warsztatów prowadzonych przez Henryka Kowalczyka – założyciela Teatru Scena 6, które odbywały się w Wojewódzkim Ośrodku Kultury.", "Teatr im. H. Ch. Andersena jest miejscem, w którym to, co piękne i ciekawe płynnie przenika się z tym, co trudne i skłaniające do refleksji.", "Multikino w Lublinie zostało otwarte w listopadzie 2013 roku. Mieści się na pierwszym piętrze w Galerii Olimp.", "Cinema City Felicity składa się z 9 klimatyzowanych sal, które pomieszczą jednocześnie blisko 1 700 widzów.", "Funkcjonuje w sezonie wakacyjnym, od czerwca do sierpnia 5 dni w tygodniu, od środy do niedzieli wyświetlamy filmowe hity. Projekcje zaczynają się po zachodzie słońca."]
            
            var placeLatitudeArr : [String] = ["51.24513945062349", "51.246899237466", "51.24686560691351", "51.23755448979576", "51.24841909740968", "51.24551039653255", "51.24819170076517", "51.235935547887976", "51.24678149283614", "51.26736717016585", "51.23210987725407", "51.243974482797086"]
            
            var placeLongitudeArr : [String] = ["22.56628734638244", "22.568356426400396", "22.566617811484523", "22.548470750409923", "22.567890389713853", "22.556392642409673", "22.544951139880023", "22.504817079571794", "22.548075803148798", "22.57117602346184", "22.614365544970106", "22.567327857030296"]
            
            categoryNameArr.forEach { category in
                //Dodawanie miejsc w zależności od kategorii
                addCategoryItemsToDB(categoryName: category, placeNameArr: Array(placeNameArr.prefix(3)), placeImageArr: Array(placeImageArr.prefix(3)),placeDescArr: Array(placeDescArr.prefix(3)), placeLongitudeArr: Array(placeLongitudeArr.prefix(3)), placeLatitudeArr: Array(placeLatitudeArr.prefix(3)))
                
                //Inna kategoria co 3 miejsca
                placeNameArr = Array(placeNameArr.dropFirst(3))
                placeImageArr = Array(placeImageArr.dropFirst(3))
                placeDescArr = Array(placeDescArr.dropFirst(3))
                placeLatitudeArr = Array(placeLatitudeArr.dropFirst(3))
                placeLongitudeArr = Array(placeLongitudeArr.dropFirst(3))
            }
            
            //Dodawanie opinii do bazy danych
            let rating: [Int16] = [5,4,3,5,5,5,4,5,4,5,3,2,5,4,3,5,5,5,5,5,5,5,5,5,4,5,4,3,3,1,5,4,5,5,5,1]
            
            let content: [String] = ["Piekny budynek chociaż przydałby się remont. Mimo wszystko perła Lublina. Cudowny!!","Fajnie wyglada jako ruinka niestety nie ma mozliwosci wejscia na teren palacu","Bardzo zaniedbane miejsce z niezwykłą historią...","Zachwycająca, majestatyczna katedra z kopią Całunu Turyńskiego. Przed katedrą duży parking, wejście bez barier.","Przepiękna Archikatedra warto do niej pójść","Najwyższej próby malarstwo iluzjonistyczne.","Warto zobaczyć także ładny mural zaraz obok wieży.","Można zaglądnąć w starą basztę od wewnątrz","Przez tyle lat nie wiedziałem o istnieniu tego miejsca a jest naprawdę ciekawe.","Super lokal, pyszne i konkretne żarcie, dobre drinki i bardzo przyjemny lokal.","Zaczynam się zastanawiać czy właściciele nie zaczynają wpadać w rutynę i czy jedzenie nie staje się gorsze....?","Niestety ale po dzisiejszej wizycie nie mogę zbyt wiele dobrego powiedzieć. Czas oczekiwania na jedzenie to 1,5 godziny.","Rewelacja! Przemiła obsługa - to pierwsze co nas zachęciło. Pyszne jedzenie - zdecydowanie podstawa wszystkiego!","Niezłe miejsce. Obsługa uprzejma, lecz niektóre panie niezbyt orientują się w menu.","Mila obsługa. Zarowno wystrój resrauracji jak i dania tylko ok, po przeczytanych opiniach spodziewalismy się znacznie wiecej.","Przemiła obsługa, ogromne porcje i bardzo przyzwoite ceny. Bardzo miłe akcenty w postaci czekadełka i czegoś na osłodę rachunku.","Kiedyś to była stołówka, teraz droga restauracja. Ale fajna! Duże porcje, wszystko bardzo smaczne, przemiła obsługa.","By odwiedzić to miejsce skusiły nas bardzo dobre opinie, co prawda miejsce nie jest w samym sercu starego miasta lecz mimo to warto podejść parę metrów do tego miejsca.","To było coś niesamowitego!","Dobre spektakle, widać dużo serca i pracy.","wspaniały studencki teatr","Jeden z najlepszych teatrów niezawodowych w Lublinie","To było niesamowite doznanie estetyczno wizualne.","Teatr wysokich lotów","Miejsce bardzo sympatyczne, trochę ciężko trafić bo szatnia jest w innym miejscu, a scena w innym.","Szczerze polecam. Miejsce warte odwiedzenia. Dzieci zachwycone. Przedstawienie super.","Spektakle nie są tanie ale są rewelacyjne. Super scenografia, stroje...","Sam seans był bardzo dobry i w przystępnej cenie ale popcorn nachos i tak dalej były stanowczo za drogie.","Ogólnie jest OK. Sale są super wygodne a ceny zestawów całkiem przystępne. Duży minus natomiast za oszczędzanie na klimatyzacji (w połowie seansu zrobiło sie juz trochę duszno).","30 minut reklam to na prawdę gruba przesada, będąc w tym kinie człowiek ma wrażenie ze przyszedł oglądać reklamy a nie seans, w dodatku zachowanie personelu i obsługa klientów… porażka.","Nasze ulubione kino :), ale 4DX mnie rozczarował, fotele za bardzo się ruszają podczas filmu, bardzo to rozprasza podczas śledzenia fabuły.","Kino jak kino, dźwięk i obraz OK (sala 1). Fotele wygodne. Obsługa uprzejma. Czysto. Ceny biletów i w barku u konkurencji chyba trochę niższe.","Najlepsze Kino w Lublinie Miła obsługa duża sala kinowa idealna głośność bajek i filmów bardzo wygodne fotele wszędzie czysto jedyny minus to drogie jedzenie.","Ciekawa inicjatywa. Razem z dziewczyną kilka razy mieliśmy przyjemność bycia tu na seansach.","Jedno z fajniejszych miejsc w Lublinie w okresie letnim. Niskie ceny piwa i przekąsek, ciekawy repertuar.","Opryskliwa obsługa. Zostałem odesłany przez obsługę baru po dodatkowe leżaki  do siedzenia (sytuacja braku miejsc) i zatrzymany przez ochronę po chwili z pytaniem \"mamy się przejść do baru i zapytać czy to prawda\"."]
            
            placeNameArr = ["Pałac Sobieskich", "Archikatedra św. Jana Chrzciciela i św. Jana Ewangelisty", "Baszta Gotycka", "Koper Włoski u Braci Mazur", "Restauracja Magia w Lublinie", "Pyzata Chata", "Teatr ITP", "Teatr Pierwszego Kontaktu", "Teatr im. Hansa Christiana Andersena w Lublinie", "Multikino", "Cinema City", "Kino Perła"]
            
            addOpinionsToItem(placeNameArr: &placeNameArr, userNameArr: userNameArr, placeRatingArr: rating, placeContentArr: content)
        }else{
            print("Dane już zostały dodane")
        }
    }
    
    private func addUser(){
        if(getUserByUserName(viewContext: viewContext, userName: userUserName) == nil){
            let newUser = User(context: viewContext)
            
            newUser.id = UUID()
            newUser.username = userUserName
            
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addCategoryItemsToDB(categoryName: String, placeNameArr: [String], placeImageArr: [String], placeDescArr: [String], placeLongitudeArr: [String], placeLatitudeArr: [String]){
        var newPlace = Place(context: viewContext)
        
        for i in 0..<placeNameArr.count{
            if(i != 0){
                newPlace = Place(context: viewContext)
            }
            
            newPlace.id = UUID()
            newPlace.name = placeNameArr[i]
            newPlace.desc = placeDescArr[i]
            newPlace.imageName = placeImageArr[i]
            newPlace.longitude = placeLongitudeArr[i]
            newPlace.latitude = placeLatitudeArr[i]
            newPlace.category = getCategoryByName(viewContext: viewContext, categoryName: categoryName)
            
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addOpinionsToItem(placeNameArr: inout [String], userNameArr: [String], placeRatingArr: [Int16], placeContentArr: [String]){
        var newOpinion = Opinion(context: viewContext)
        var userName = ""
        
        for i in 0..<placeRatingArr.count{
            if(i != 0){
                newOpinion = Opinion(context: viewContext)
            }
            
            newOpinion.id = UUID()
            newOpinion.rating  = placeRatingArr[i]
            newOpinion.content  = placeContentArr[i]
            userName = userNameArr[i%3]
            newOpinion.user  = getUserByUserName(viewContext: viewContext, userName: userName)
            
            if(i%3==0 && i != 0){
                placeNameArr.removeFirst()
            }
            
            newOpinion.place  = getPlaceByName(viewContext: viewContext, placeName: placeNameArr[0])
            
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
