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
    
    
    var body: some View {
        VStack{
            List{
                ForEach(txtarray, id: \.self) { txt in
                    VStack{
                        Text("\(item.reformtxttitle![txtarray.index(of: txt)!])")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .frame( height: 10)
                        Text("\(txt)")
                            .font(.body)
                            .foregroundColor(.gray)
                            .frame(maxHeight: 10)
                        
                    }.padding(.vertical, 15)
                        .swipeActions(edge: .trailing) {
                            Button {
                                txtarray.removeAll {$0 == txt}
                                addTxtref(txtref: txtarray)
                                setTxt(txtbool: txtarray.isEmpty)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                                
                            }
                            .tint(Color.red)
                        }
                }
                
            }
            
        }.background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
            .navigationTitle("Writing Reformulation")
        
            .toolbar{
                
                ToolbarItem(placement: .navigationBarTrailing){
                    EditButton().font(Font.system(size: 20))
                    
                }
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    Text("\(txtarray.count) reformulation")
                    Spacer()
                    
                    Button(action: {
                        //               INSERT ACTION
                    }, label: {
                        Image(systemName: "square.and.pencil")
                    }
                    )
                }
            }
        
        
    }
    func setTxt(txtbool: Bool){
        withAnimation {
//            item.txticon = !txtbool
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addTxtref(txtref: [String]){
        withAnimation {
            item.reformtxt = txtref
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


//struct ListReformulation_Previews: PreviewProvider {
//    static var previews: some View {
//        ListReformulation()
//    }
//}

