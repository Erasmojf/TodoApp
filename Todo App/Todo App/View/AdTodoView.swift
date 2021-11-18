//
//  AdTodoView.swift
//  Todo App
//
//  Created by Erasmo J.F Da Silva on 18/11/21.
//

import SwiftUI

struct AdTodoView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
   
    let priorities = ["High","Normal","Low"]
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                    
                    // MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        print("Save a new todo item")
                    }) {
                        Text("Save")
                    }//Save Button
                }//:Form
                Spacer()
            }//VSatck
            
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
              Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            }
            )
        }//:Navigation
    }
}
// MARK: - PREVIEW
struct AdTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AdTodoView()
    }
}
