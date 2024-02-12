//
//  CoreDataService.swift
//  MusicSpeedChanger
//
//  Created by Dmitry Lipuntsov on 28.04.2023.
//

import Foundation
import CoreData

class CoreDataService<Entity: EntityFetchable & NSManagedObject & Identifiable> {
    
    var container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }
        
    @Published var entitiesPublisher: [Entity] = []
    
    init(containerName: String) {
        container = NSPersistentContainer(name: containerName)
        loadStore()
    }
    
    private func loadStore() {
        container.loadPersistentStores { description, error in
            if let error = error {
                let message = "Error loading core data with error: \(error)"
                let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
                LoggerManager.shared.log(
                    subsystem: .data,
                    level: .warning,
                    destination: destination,
                    message: message
                )
            }
            self.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    private func save() {
        DispatchQueue.main.async { [weak self] in
            do{
                try self?.context.save()
                self?.fetchEntities()
            } catch let error{
                let message = "Error saving Core Data. \(error.localizedDescription)"
                let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
                LoggerManager.shared.log(
                    subsystem: .data,
                    level: .warning,
                    destination: destination,
                    message: message
                )
            }
        }
    }
    
    func fetchEntities() {
        let request = NSFetchRequest<Entity>(entityName: "\(Entity.self)")
        do {
            let response = try context.fetch(request)
            entitiesPublisher = response
        } catch let error {
            let message = "Error fetching with error: \(error)"
            let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
            LoggerManager.shared.log(
                subsystem: .data,
                level: .error,
                destination: destination,
                message: message
            )
        }
    }
    
    func fetchEntity(id: UUID) -> Entity? {
        return entitiesPublisher.first(where: {$0.id as? UUID == id})
    }
    
    func add(persistedCompletion: (Entity) -> ()) {
        let newEntity = Entity(context: context)
        persistedCompletion(newEntity)
        save()
    }
    
    func delete(_ entity: Entity) {
        context.delete(entity)
        save()
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Entity.fetchRequest() as! NSFetchRequest<NSFetchRequestResult>
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let result = try context.execute(batchDeleteRequest)
            try context.save()
            
            if let deletionResult = result as? NSBatchDeleteResult,
               let deletedObjectIDs = deletionResult.result as? [NSManagedObjectID] {
                if !deletedObjectIDs.isEmpty {
                    for objectID in deletedObjectIDs {
                        let entityName = context.registeredObject(for: objectID)?.entity.name ?? "Unknown"
                        debugPrint("Successfully deleted object with ID \(objectID) from entity \(entityName)")
                    }
                } else {
                    debugPrint("No objects were deleted for the specified predicate.")
                }
            } else {
                debugPrint("Unexpected result type after batch delete.")
            }
        } catch {
            let message = "Error deleting entities with predicate: \(error)"
            let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
            LoggerManager.shared.log(
                subsystem: .data,
                level: .error,
                destination: destination,
                message: message
            )
        }
    }
    
    func delete(projectID: UUID, trackID: UUID) {
        do {
            let entityFetchRequest = NSFetchRequest<Entity>(entityName: "Entity")
            entityFetchRequest.predicate = NSPredicate(format: "id == %@", projectID as CVarArg)
            if let entity = try context.fetch(entityFetchRequest).first {
                context.delete(entity)
                save()
            }
        } catch {
            let message = "Error deleting track from project: \(error)"
            let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
            LoggerManager.shared.log(
                subsystem: .data,
                level: .error,
                destination: destination,
                message: message
            )
        }
    }

}
