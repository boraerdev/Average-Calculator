//
//  CoreData.swift
//  ortalamaHesaplaGoster
//
//  Created by Bora Erdem on 23.07.2022.
//

import Foundation
import CoreData
import UIKit

class CoreData: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedNotes: [NotEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "NotData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
            self.fetchData()
        }
    }
    
    func fetchData(){
        let request = NSFetchRequest<NotEntity>(entityName: "NotEntity")
        do{
            savedNotes = try container.viewContext.fetch(request)
        }catch let error{
            print(error)
        }
    }
    
    func addNot(not1: Int, not2 : Int, name: String, ortalama: Double){
        let entity = NotEntity(context: container.viewContext)
        entity.name = name
        entity.norbir = Int32(not1)
        entity.notiki = Int32(not2)
        entity.ortalama
        saveData()
    }
    
    func deleteNote(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedNotes[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
        }catch let error{
            print(error)
        }
    }
    
}
