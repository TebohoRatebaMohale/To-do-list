//
//  CheckBoxView.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/02/28.
//

import SwiftUI
import CoreData

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    @State var trimVal : CGFloat = 0
    
    var body: some View {
        
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill":"circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                withAnimation(Animation.easeIn(duration: 1.5)) {
                    if !passedTaskItem.isCompleted()
                    {
                        passedTaskItem.completedDate = Date()
                        dateHolder.saveContext(viewContext)
                    }
                }
//                else {
//                    withAnimation(Animation.easeIn(duration: 1.5){
//                        self.trimVal =  0
//                        self.passedTaskItem.toggle()
//                    }
//                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
