//
//  ContentView.swift
//  Todo App
//
//  Created by Erasmo J.F Da Silva on 18/11/21.
//  SwiftUI ♡ Better Apps. Less Code
//  https://erasmojf.github.io/
//  Fidju de Bideira de Feira de Caracol

import SwiftUI
import CoreData


struct ContentView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
   // MARK: - BODY        
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unkown")
    
                        Spacer()
                        
                        Text(todo.priority ?? "Unkown")
                    }
                }// ForEach
            
            } //LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
             Button(action: {
                self.showingAddTodoView.toggle()
            }) {
                Image(systemName: "plus")
             }//: Add Button
             .sheet(isPresented: $showingAddTodoView) {
                AdTodoView().environment(\.managedObjectContext, self.viewContext)
            }
         )
        }//NAVIGATIONVIEW
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        let context = (UIApplication.shared.delegate as! AppDelegate).presistentContainer.viewContext
       return ContentView()
//            .environment(\.managedObjectContext, context)
        .previewDevice("iPhone 11 Pro")
    }
}
