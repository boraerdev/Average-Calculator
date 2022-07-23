//
//  AddPageView.swift
//  ortalamaHesaplaGoster
//
//  Created by Bora Erdem on 23.07.2022.
//

import SwiftUI

struct AddPageView: View {
    @State var not1: Int = 0
    @State var not2: Int = 0
    @State var notName: String = ""
    @State var iconSaved: Bool = false
    @Binding var updateData: Bool
    @EnvironmentObject var vm: HomeViewModel
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                HeadView(savedIcon: $iconSaved).padding(.top,30)
                notTextField
                NotHStack(not: $not1, label: "Vize notunuz :")
                NotHStack(not: $not2, label: "Final notunuz: ")
                ortGorunum
                ekleButton
                

                Spacer()
            }.padding(.horizontal)
        }.onDisappear {
            vm.fetchData()
        }
    }
    
        
    
    
    private var notTextField : some View {
        TextField("Ders Adını Giriniz", text: $notName)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.blue)
            ).padding(.vertical)
    }
    
    
    private var ekleButton : some View {
        
        Button {
            updateData = false
            guard notName != "" else {return}
            vm.addNot(not1: not1, not2: not2, name: notName, ortalama: Double(not1) * 0.4 + Double(not2) * 0.6)
            withAnimation(.easeInOut) {
                iconSaved.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                presentationMode.wrappedValue.dismiss()
                vm.fetchData()
            }
            vm.fetchData()
            
        } label: {
            Text("Ekle")
                .padding(10)
                .frame(maxWidth:.infinity)
                
        }
        .buttonStyle(BorderedButtonStyle())

        
    }
    private var ortGorunum: some View {
        VStack{
            Text("Ortalama").font(.caption).foregroundColor(.secondary)
            Text(String(Double(not1) * 0.4 + Double(not2) * 0.6 ))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Double(not1) * 0.4 + Double(not2) * 0.6 > 50 ? Color.green: Color.red)
                .cornerRadius(10)
        }
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView(updateData: .constant(true))
            .environmentObject(HomeViewModel())
    }
}

struct PickerView: View {
    @Binding var not: Int
    var body: some View {
        Picker(selection: $not) {
            ForEach(0..<101, id: \.self) { number in
                Text(String(number)).tag(number)
            }
        } label: {
            Text("Picker")
        }
        .pickerStyle(MenuPickerStyle())
        .padding(8)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

struct NotHStack: View {
    @Binding var not: Int
    @State var label: String
    var body: some View {
        HStack{
            Text(label).foregroundColor(.secondary)
            Spacer()
            PickerView(not: $not)
            
        }
    }
}

struct HeadView: View {
    @Binding var savedIcon: Bool
    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        HStack{
            Text("Ders Ekle").font(.title2).fontWeight(.bold)
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: savedIcon == true ? "checkmark" : "xmark").font(.title2)
            }
        }
    }
}
