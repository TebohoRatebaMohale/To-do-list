////
////  ContentView.swift
////  To-Do-List
////
////  Created by Teboho Mohale on 2023/02/27.
////
//
//import SwiftUI
//import CoreData
//
//
//
//struct TaskListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var dateHolder: DateHolder
//
//    @State var selectedFilter = TaskFilter.NonCompleted
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<TaskItem>
//
//    var body: some View {
//        NavigationView {
//            VStack
//            {
//                DateScroller()
//                                   .padding()
//                                   .environmentObject(dateHolder)
//
//                ZStack
//                {
//
//            List {
//                ForEach(filteredTaskItems())
//                { taskItem in
//                    NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: Date()).environmentObject(dateHolder))
//                    {
//                        TaskCell(passedTaskItem: taskItem)
//                            .environmentObject(dateHolder)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction)
//                {
//                    Picker("", selection: $selectedFilter.animation())
//                    {
//                        ForEach(TaskFilter.allFilters, id: \.self)
//                        {
//                            filter in
//                            Text(filter.rawValue)
//                        }
//                    }
//                }
//            }
//                    FloatingButton()
//                        .environmentObject(dateHolder)
//            }
//            }
//
//            .navigationTitle("To Do")
//            Image("scr")
//            .resizable()
//                //.frame(width: 500, height: 500)
//                .scaledToFit()
//              //  .foregroundColor(.blue)
//                .padding(.top, -100.0)
//                .opacity(10.0)
//                .padding(.leading, -50)
//                .padding(.bottom, -380)
//        }
//    }
//
//    private func filteredTaskItems() -> [TaskItem]
//        {
//            if selectedFilter == TaskFilter.Completed
//            {
//                return dateHolder.taskItems.filter{ $0.isCompleted()}
//            }
//
//            if selectedFilter == TaskFilter.NonCompleted
//            {
//                return dateHolder.taskItems.filter{ !$0.isCompleted()}
//            }
//
//            if selectedFilter == TaskFilter.OverDue
//            {
//                return dateHolder.taskItems.filter{ $0.isOverdue()}
//            }
//
//            return dateHolder.taskItems
//        }
//
//
////    func saveContext(_ context: NSManagedObjectContext) {
////        do {
////            try context.save()
////        } catch {
////
////            let nsError = error as NSError
////            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
////        }
////    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { filteredTaskItems()[$0]}.forEach(viewContext.delete)
//
//                dateHolder.saveContext(viewContext)
//            }
//
//        }
//    }
//
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
////
//private let itemPicker: DatePicker = {
//    let picker = DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text(" ") })
//  //  picker.dateStyle = .long
//  //  picker.timeStyle = .medium
//    return picker
//}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//
//
//}

import SwiftUI
import CoreData
//
//struct TaskListView: View {
//    @Environment(\.managedObjectContext) private var viewContext //primary responsibility is to manage a collection of managed objects
//    @EnvironmentObject var dateHolder: DateHolder
//
//    @State var selectedFilter = TaskFilter.NonCompleted
//
//    var body: some View
//    {
//        NavigationView
//        {
//            TabView {
//
//            VStack
//            {
//                DateScroller()
//                    .padding()
//                    .environmentObject(dateHolder)
//                ZStack
//                {
//                    List
//                    {
//                        ForEach(filteredTaskItems())
//                        { taskItem in
//                            NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: taskItem.dueDate!)
//                                .environmentObject(dateHolder))
//                            {
//                                TaskCell(passedTaskItem: taskItem)
//                                    .environmentObject(dateHolder)
//                            }
//                        }
//                        .onDelete(perform: deleteItems)
//                    }
//                    .toolbar {
//                        ToolbarItem(placement: .confirmationAction) {
//                            Picker("", selection: $selectedFilter.animation())
//                            {
//                                ForEach(TaskFilter.allFilters, id: \.self)
//                                {
//                                    filter in
//                                    Text(filter.rawValue)
//                                }
//                            }
//                        }
//
//                    }
//
//                    FloatingButton()
//                        .environmentObject(dateHolder)
//
//
//                               }
//                }
////                TaskListView()
////                    .tabItem {
////                        Label("List", systemImage: "list.bullet")
////                    }
//    CalendarView()
//                       .tabItem {
//                           Label("Calendar", systemImage: "calendar")
//                       }
//            }
//            .navigationTitle("To Do List")
//        }
//    }
//
//    private func filteredTaskItems() -> [TaskItem]
//    {
//        if selectedFilter == TaskFilter.Completed
//        {
//            return dateHolder.taskItems.filter{ $0.isCompleted()}
//        }
//
//        if selectedFilter == TaskFilter.NonCompleted
//        {
//            return dateHolder.taskItems.filter{ !$0.isCompleted()}
//        }
//
//        if selectedFilter == TaskFilter.OverDue
//        {
//            return dateHolder.taskItems.filter{ $0.isOverdue()}
//        }
//
//        return dateHolder.taskItems
//    }
//
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { filteredTaskItems()[$0] }.forEach(viewContext.delete)
//
//            dateHolder.saveContext(viewContext)
//        }
//    }
//}
//
////private let itemFormatter: DateFormatter = {
////    let formatter = DateFormatter()
////    formatter.dateStyle = .short
////    formatter.timeStyle = .medium
////    return formatter
////}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
//
//
//

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext //primary responsibility is to manage a collection of managed objects
    @EnvironmentObject var dateHolder: DateHolder

    @State var selectedFilter = TaskFilter.NonCompleted
    @State private var searchText = ""
//    @State private var searchQuery = ""

    var body: some View
    {
        NavigationView
        {
            TabView {
                           
            VStack
            {
                DateScroller()
                    .padding()
                    .environmentObject(dateHolder)
                ZStack
                {
                    List
                    {
                        ForEach(filteredTaskItems(searchText: searchText))
                        { taskItem in
                            NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: taskItem.dueDate!)
                                .environmentObject(dateHolder))
                            {
                                TaskCell(passedTaskItem: taskItem)
                                    .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Picker("", selection: $selectedFilter.animation())
                            {
                                ForEach(TaskFilter.allFilters, id: \.self)
                                {
                                    filter in
                                    Text(filter.rawValue)
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("Search", text: $searchText, onEditingChanged: {_ in}, onCommit: {})
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    
                    FloatingButton()
                        .environmentObject(dateHolder)
                    
                               }
                }
    CalendarView()
                       .tabItem {
                           Label("Show Items", systemImage: "calendar")
                       }
            }
            .navigationTitle("To Do List")
        }
    }

    private func filteredTaskItems(searchText: String) -> [TaskItem]
    {
        var filteredItems = dateHolder.taskItems

        if !searchText.isEmpty {
            filteredItems = filteredItems.filter { task in
                let taskTitle = task.title?.lowercased() ?? ""
                return taskTitle.contains(searchText.lowercased())
            }
        }

        if selectedFilter == TaskFilter.Completed
        {
            return filteredItems.filter{ $0.isCompleted()}
        }
        
        if selectedFilter == TaskFilter.NonCompleted
        {
            return filteredItems.filter{ !$0.isCompleted()}
        }
        
        if selectedFilter == TaskFilter.OverDue
        {
            return filteredItems.filter{ $0.isOverdue()}
        }
        
        return filteredItems
    }

    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredTaskItems(searchText: searchText)[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}
