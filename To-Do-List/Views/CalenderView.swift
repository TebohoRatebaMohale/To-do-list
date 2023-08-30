//
//  CalenderView.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/03/23.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TaskItem.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)])
    private var taskItems: FetchedResults<TaskItem>
    
    var body: some View {
        HStack{
            TabView(selection: $dateHolder.date)
            {
                ForEach(Array(arrayLiteral: dateHolder.date), id: \.self)
                { date in
                    let tasksForDate = taskItems.filter { $0.dueDate?.isSameDay(as: date) ?? false }
                    VStack {
                        CalendarHeaderView(date: date)
                        if tasksForDate.isEmpty {
                            Text("No tasks for this date")
                                .padding()
                        } else {
                            List {
                                ForEach(tasksForDate) { taskItem in
                                    NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: taskItem.dueDate!)
                                        .environmentObject(dateHolder))
                                    {
                                        TaskCell(passedTaskItem: taskItem)
                                            .environmentObject(dateHolder)
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                    .tag(date)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct CalendarHeaderView: View {
    let date: Date
    
    var body: some View {
        Text(date, formatter: DateFormatter.dayHeaderFormatter)
            .font(.title2)
            .padding(.vertical)
    }
}

extension DateFormatter {
    static let dayHeaderFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter
    }()
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}


struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
//        CalendarView(dateHolder: DateHolder())
    }
}
