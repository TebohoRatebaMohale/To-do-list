////
////  TaskEditView.swift
////  To-Do-List
////
////  Created by Teboho Mohale on 2023/02/27.
////
//

import SwiftUI
//import CoreData
import UserNotifications

struct TaskEditView: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var dueDate: Date
    @State var scheduleTime: Bool
    @State var priority: Int
    @State var category: Int
    
    let priorityOptions = ["Low", "Medium", "High"]
    
    let categoryOptions = ["Work", "Entainment", "Home"]
    
    init(passedTaskItem: TaskItem?, initialDate: Date)
    {
        if let taskItem = passedTaskItem
        {
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
            _priority = State(initialValue: Int(taskItem.priority))
            _category = State(initialValue: Int(taskItem.category))
        }
        else
        {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
            _priority = State(initialValue: Int())
            _category = State(initialValue: Int())
        }
    }
    
    var body: some View
    {
        Form
        {
            Section(header: Text("Category"))
                        {
                            Picker("category", selection: $category) {
                                ForEach(0..<categoryOptions.count) { index in
                                    Text(categoryOptions[index]).tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
            
            Section(header: Text("Priority"))
                        {
                            Picker("Priority", selection: $priority) {
                                ForEach(0..<priorityOptions.count) { index in
                                    Text(priorityOptions[index]).tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
            
            Section(header: Text("Task"))
            {
                TextField("Task Name", text: $name)
                TextField("Description", text: $desc)
            }
            
            Section(header: Text("Due Date"))
            {
                Toggle("Schedule Time", isOn: $scheduleTime)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComps())
            }
            
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//                }

                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
            
            
            if selectedTaskItem?.isCompleted() ?? false
            {
                Section(header: Text("Completed"))
                {
                    Text(selectedTaskItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }
            
            Section()
            {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            .background(
//                Color(Color.yellow as! CGColor)
            )
            
        }
    }

    
    func displayComps() -> DatePickerComponents
    {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    func saveAction()
    {
        withAnimation
        {
            if selectedTaskItem == nil
            {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.desc = desc
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            selectedTaskItem?.priority = Int16(priority)
            selectedTaskItem?.category = Int16(category)
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct TaskEditView_Previews: PreviewProvider
{
    static var previews: some View {
        TaskEditView(passedTaskItem: TaskItem(), initialDate: Date())
    }
}
