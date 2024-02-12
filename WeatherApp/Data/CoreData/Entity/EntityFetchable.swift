//
//  EntityFetchable.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import Foundation
import CoreData

protocol EntityFetchable {
    associatedtype Entity: NSManagedObject
    static func fetchRequest() -> NSFetchRequest<Entity>
}
