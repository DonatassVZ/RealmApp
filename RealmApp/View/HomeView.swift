//
//  HomeView.swift
//  RealmApp
//
//  Created by Vasiliy Munenko on 29.03.2021.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    @StateObject var modelData = DBViewModel()
    @StateObject var store = Store()
    
    
    var body: some View {
        NavigationView{
            ScrollView {
                
                VStack(spacing: 10){
                    ForEach(modelData.cards){
                        card in
                        
                        
                        HStack{
                            CardViewAdress(card: card)
                            Spacer()
                            Button(action: {
                                withAnimation{
                                    store.activeAdressID = card.id
                                }
                            }, label: {
                                Image(systemName: store.activeAdressID == card.id ?  "largecircle.fill.circle": "circlebadge" )
//                                    .resizable()
//                                    .frame(width: 32 , height : 32)
                                    .foregroundColor(Color.green)
                            })
                            
                        }.frame(maxWidth: .infinity , alignment: .leading)
                        .padding(10)
                        .background( store.activeAdressID == card.id ?  Color.green.opacity(0.5).cornerRadius(20) :
                            Color.gray.opacity(0.2).cornerRadius(20) )
                        
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(menuItems: {
                            Button(action: {modelData.deleteData(object: card) }, label: {
                                Text("Delete Item")
                            })
                            Button(action: {
                                modelData.updateObject = card
                                modelData.openNewPage.toggle()
                            }, label: {
                                Text("Update Item ")
                            })
                            
                            Button(action: {
                                store.activeAdressID = card.id
                            }, label: {
                                Text("Active this adress ")
                                    .padding()
                            })
                        })
                        
                    }
                    
                    //add only selected View
                    Spacer(minLength: 30)
                    Text("Example selected adress-card")
                    if let scard = modelData.getObject(withId: store.activeAdressID){
                        CardViewAdress(card: scard)
                    }
                    
                }.padding(10)
            }
            .navigationTitle("My adresses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    
                    Button(action: {
                            modelData.openNewPage.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    })
                }
            })
            .sheet(isPresented: $modelData.openNewPage, content: {
                AddPageView()
                    .environmentObject(modelData)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct CardViewAdress : View {
    
    var card: Card
    
    var body: some View{
        VStack(alignment: .center, spacing: nil, content: {
            Text(card.city)
            Text(card.street)
            HStack{
                Text("House:\(card.house)")
                .padding(.horizontal , 10)
                if card.flat != ""{
                    Text("Flat: \(card.flat)")
                }
            }
            Text(card.detail)
        //    Text("\(card.id)")  // tech-view
        })
    }
}






