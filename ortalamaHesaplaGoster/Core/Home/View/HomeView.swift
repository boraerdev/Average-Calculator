//
//  HomeView.swift
//  ortalamaHesaplaGoster
//
//  Created by Bora Erdem on 23.07.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State var goAddPage: Bool = false
    @State var goInfoPage: Bool = false
    
    var body: some View {
        ZStack{
            
            VStack{
                listView
            }
            .sheet(isPresented: $goInfoPage) {
                InfoView()
            }
        }
        .sheet(isPresented: $goAddPage, content: { 
            AddPageView(updateData: $goAddPage)
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Ortalama Hesapla")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    goInfoPage.toggle()
                } label: {
                    Image(systemName: "info")
                }
                

            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    goAddPage.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
    private var listView: some View {
        List{
            ForEach(vm.savedNotes) { gelen in
                HStack{
                    VStack(alignment: .leading){
                        Text(gelen.name ?? "")
                        Group{
                            Text("Vize:" + String(gelen.norbir))
                            Text("Final:" + String(gelen.notiki))
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(String(gelen.ortalama)).padding(.horizontal)
                        .foregroundColor(.white)
                        .background(gelen.ortalama > 50 ? Color.green : Color.red)
                        .cornerRadius(5)
                }
                
            }
            .onDelete(perform: vm.deleteNote)
            
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}
