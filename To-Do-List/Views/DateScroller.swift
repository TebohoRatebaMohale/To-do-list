////
////  DateScroller.swift
////  To-Do-List
////
////  Created by Teboho Mohale on 2023/03/01.
////

import SwiftUI

struct DateScroller: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext

    @State var datePickerID : UUID = UUID()

    var body: some View

    {
        VStack{
            HStack {
                

                DatePicker(selection: $dateHolder.date,
                           label: { Text(" ") })
                .id(datePickerID)
                .onChange(of: dateHolder.date) { newValue in
                    dateHolder.refreshTaskItems(viewContext)
                    datePickerID = UUID()
                }

                
                Button(action: moveBack) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .font(Font.title.weight(.bold))
                }
                .opacity(10.0)
                

                Button(action: moveForward) {
                    Image(systemName: "arrow.right")
                        .imageScale(.large)
                        .font(Font.title.weight(.bold))
                        .opacity(10.0)
                }

            }


        }
    }

    func dateFormatted() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL yy"
        return dateFormatter.string(from: dateHolder.date)
    }

    func moveBack()
    {
        withAnimation
        {
            dateHolder.moveDate(-1, viewContext)
        }
    }

    func moveForward()
    {
        withAnimation
        {
            dateHolder.moveDate(1, viewContext)
        }
    }
}

struct DateScroller_Previews: PreviewProvider {
    static var previews: some View {
        DateScroller()
    }
}
//

//import SwiftUI
//
//struct DateScroller: View {
//    @EnvironmentObject var dateHolder: DateHolder
//    @Environment(\.managedObjectContext) private var viewContext
//
//    var body: some View
//    {
//        HStack
//        {
//            Spacer()
//            Button(action: moveBack)
//            {
//                Image(systemName: "arrow.left")
//                    .imageScale(.large)
//                    .font(Font.title.weight(.bold))
//            }
//            Text(dateFormatted())
//                .font(.title)
//                .bold()
//                .animation(.none)
//                .frame(maxWidth: .infinity)
//            Button(action: moveForward)
//            {
//                Image(systemName: "arrow.right")
//                    .imageScale(.large)
//                    .font(Font.title.weight(.bold))
//            }
//        }
//    }
//
//    func dateFormatted() -> String
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd LLL yy"
//        return dateFormatter.string(from: dateHolder.date)
//    }
//
//    func moveBack()
//    {
//        withAnimation
//        {
//            dateHolder.moveDate(-1, viewContext)
//        }
//    }
//
//    func moveForward()
//    {
//        withAnimation
//        {
//            dateHolder.moveDate(1, viewContext)
//        }
//    }
//}
//
//struct DateScroller_Previews: PreviewProvider {
//    static var previews: some View {
//        DateScroller()
//    }
//}
