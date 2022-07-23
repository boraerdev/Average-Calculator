//
//  InfoView.swift
//  ortalamaHesaplaGoster
//
//  Created by Bora Erdem on 23.07.2022.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack{
            infoHeadView().padding(.top,30)
            groupBoxView.padding(.vertical)
            Spacer()
        }.padding(.horizontal)
    }
    private var groupBoxView: some View {
        GroupBox {
            VStack(alignment: .leading){
                groupBoxItem(text: "Developer", value: "Bora Erdem")
                groupBoxItem(text: "Version", value: "1.0")
            }

        } label: {
            HStack{
                Text("Ortalama Hesaplayıcı")
                Spacer()
                Image(systemName: "info")
                
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct infoHeadView: View {
    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        HStack{
            Text("Hakkında").font(.title2).fontWeight(.bold)
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark").font(.title2)
            }
        }
    }
}

struct groupBoxItem: View {
    var text: String
    var value: String
    var body: some View {
        VStack {
            Divider()
            HStack{
                Text(text)
                Spacer()
                Text(value).foregroundColor(.secondary)
            }
        }
    }
}
