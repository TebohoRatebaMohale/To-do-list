//
//  TaskCell.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/02/28.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View
    {
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dateHolder)
        
        Text(passedTaskItem.name ?? "")
            .padding(.horizontal)
        if !passedTaskItem.isCompleted() && passedTaskItem.scheduleTime
        {
            Spacer()
            Text(passedTaskItem.dueDateTimeOnly())
                .font(.footnote)
                .foregroundColor(passedTaskItem.OverDueColor())
                .padding(.horizontal)
        }
        
    }
}



struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem: TaskItem())
    }
}
