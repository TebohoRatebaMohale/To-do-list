//
//  TaskItemExtension.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/02/28.
//

import SwiftUI



struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

extension TaskItem
{
    func isCompleted() -> Bool
    {
       return completedDate != nil
    }
    
    func isOverdue() -> Bool
    {
    if let due = dueDate
    {
        return !isCompleted() && scheduleTime && due < Date()
    }
        return false
    }
    
    func OverDueColor() -> Color
    {
        return isOverdue() ? .red : .green
    }
    
    
    func dueDateTimeOnly() -> String
    {
        if let due = dueDate
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss a"
            return dateFormatter.string(from: due)
            
        }
        return ""
    }
    
}


