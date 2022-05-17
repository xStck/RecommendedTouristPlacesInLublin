    func addUser(viewContext: NSManagedObjectContext){
        if(getUserByUserName(userName: userUserName) == nil){
            let newUser = User(context: viewContext)
            newUser.id = UUID()
            newUser.username = userUserName
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }else{
            print("Taki użytkownik już istnieje")
        }
    }
    
    func getCategoryByName(viewContext: NSManagedObjectContext, categoryName: String) -> Category{
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
    
    func getPlaceByName(viewContext: NSManagedObjectContext, placeName: String) -> Place{
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
    
    func getUserByUserName(viewContext: NSManagedObjectContext, userName: String) -> User?{
        var aUser: User?
        do{
            let userFetchRequest: NSFetchRequest<User> = User.fetchRequest()
            userFetchRequest.predicate = NSPredicate(format: "username == %@", userName)
            let fetchedResults = try viewContext.fetch(userFetchRequest)
            aUser = fetchedResults.first
        }catch{
            print("fetch task failed", error)
        }
        
        return aUser
    }
    
    func addCategoryItemsToDB(viewContext: NSManagedObjectContext, categoryName: String, placeNameArr: [String], placeDescArr: [String], placeLongitudeArr: [String], placeLattitudeArr: [String]){
        var newPlace = Place(context: viewContext)
        for i in 0..<placeNameArr.count{
            if(i != 0){
                newPlace = Place(context: viewContext)
            }
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
    
    func addOpinionsToItem(viewContext: NSManagedObjectContext, placeNameArr: inout [String], userNameArr: [String], placeRatingArr: [Int16], placeContentArr: [String]){
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
            newOpinion.user  = getUserByUserName(userName: userName)
            if(i%3==0 && i != 0){
                placeNameArr.removeFirst()
            }
            newOpinion.place  = getPlaceByName(placeName: placeNameArr[0])
            
            do{
                try viewContext.save()
            }catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }