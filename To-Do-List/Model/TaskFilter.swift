//
//  TaskFilter.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/03/01.
//

import SwiftUI

enum TaskFilter: String
{
    
    static var allFilters: [TaskFilter]
    {
        return [.NonCompleted,.Completed,.OverDue,.All]
    }
    
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case OverDue = "Overdue"
//    case AllItems = "AllItems"
}

