//
//  ListReformulation.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI



struct ListReformulation: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var item: Item
    @Binding var txtarray: [String]
    @State var showReformulation2: Bool = false
    @State var currtxt: String = ""
    @State var index: Int = 0
    
    
    var body: some View {
        VStack{
            List{
                ForEach(txtarray, id: \.self) { txt in
                    
                    VStack{
                        Text("\(item.reformtxttitle![txtarray.index(of: txt)!])")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(txt)")
                            .font(.body)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }.padding(.vertical, 15)
                        .onTapGesture{
                            currtxt = txt
                            index = txtarray.index(of: txt)!
                            self.showReformulation2 = true
                        }
                }
                
            }
            
        }.background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
            .sheet(isPresented: $showReformulation2){
                Reformulation(item: $item, showReformulation: $showReformulation2, currtxt: $currtxt, index: $index)
                
            }
            .navigationTitle("Writing Reformulation")
        
            .toolbar{
                
                ToolbarItem(placement: .bottomBar){
                    
                    Text("\(txtarray.count) reformulation")
                    
                    
                }
            }
        
        
    }
    
}

//struct ListReformulation_Previews: PreviewProvider {
//    static var previews: some View {
//        ListReformulation()
//    }
//}

