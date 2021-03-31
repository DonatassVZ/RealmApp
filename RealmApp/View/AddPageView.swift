//
//  AddPageView.swift
//  RealmApp
//
//  Created by Vasiliy Munenko on 29.03.2021.
//

import SwiftUI

struct AddPageView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var modelData : DBViewModel
    
    var isEdited : Bool = false
    
    var body: some View {
        
        NavigationView{
            VStack{
                VStack{
                    HStack{
                        Text("Info for delivery")
                        Spacer()
                        if isEdited{
                            Button(action: {
                                // delete adress
                                print("Delete this adress item")
                            }, label: {
                                Image(systemName: "trash")
                                
                            }).frame(width: 50, height: 50, alignment: .center)
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("City")
                        TextField("Enter your city", text: $modelData.city)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Street")
                        TextField("Enter your street", text: $modelData.street)
                    }
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("House")
                            
                            TextField("House number", text: $modelData.house)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Flat")
                            TextField("Enter number", text: $modelData.flat )
                                .keyboardType(.decimalPad)
                                
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Comment")
                        TextField("Enter comment", text: $modelData.detail)
                            
                    }
                    
                }.padding()
                .background(Color.orange.opacity(0.12))
                .cornerRadius(20)
                
                Spacer()
            }.padding()
            .navigationTitle("Add Adress")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        modelData.addData(presentation: presentation)
                    }, label: {
                        Text("Done")
                    })
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            })
        }.onAppear(perform: {
            modelData.setInitialData()
               })
        .onDisappear(perform: {
            modelData.deInitData()  
        })
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView()
    }
}
