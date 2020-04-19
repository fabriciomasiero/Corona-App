//
//  ContentView.swift
//  Covid Spread World
//
//  Created by Fabrício Masiero on 10/04/20.
//  Copyright © 2020 Fabrício Masiero. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText: String = ""
    @ObservedObject var viewModel: SummaryViewModel
    
    init(viewModel: SummaryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
//        NavigationView {
            VStack(alignment: .center) {
                SearchView(searchText: $searchText, viewModel: viewModel).padding(.top)
                Text(viewModel.summary?.country() ?? "")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                ConfirmedView(summary: viewModel.summary).padding(.all).border(Color.black).cornerRadius(1)
                HStack {
                    DeathView(summary: viewModel.summary).padding(.all).border(Color.black).cornerRadius(1)
                    RecoveredView(summary: viewModel.summary).padding(.all).border(Color.black).cornerRadius(1)
                }
                Rectangle().frame(height: 1)
                    .padding(.horizontal, 0).foregroundColor(Color.black)
                List(viewModel.summary?.countries ?? [], id: \.country) { country in
                    HStack {
                        Text(country.country).onTapGesture {
                            self.viewModel.setCountry(country)
                            self.searchText = country.country
                        }
                        
                        Text(country.confirmed())
                            .font(.footnote)
                            .padding(.trailing)
                    }
                    
                }.simultaneousGesture(DragGesture().onChanged({ changed in
                    UIApplication.shared.endEditing()
                }))
                
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }
//        }.navigationBarTitle("COVID-19")
    }
}

struct SearchView: View {
    @Binding var searchText: String
    let viewModel: SummaryViewModel
    var body: some View {
        SearchBar(text: $searchText, viewModel: viewModel)
            .padding(.top)
    }
}
struct ConfirmedView: View {
    let summary: Summary?
    var body: some View {
        VStack {
            Text("Confirmed")
            HStack {
                Text(summary?.totalConfirmed() ?? "0")
                    .font(.title).animation(Animation.default.speed(2))
                Image("arrow.up").foregroundColor(Color.red)
                Text(summary?.newConfirmed() ?? "0")
                    .font(.caption).animation(Animation.default.speed(2))
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}
struct DeathView: View {
    let summary: Summary?
    var body: some View {
        VStack {
            Text("Deaths")
            HStack {
                Text(summary?.totalDeaths() ?? "0")
                    .font(.title)
                    //                    .transition(.scale)
                    .animation(Animation.default.speed(2))
                Image("arrow.up").foregroundColor(Color.red)
                Text(summary?.newDeaths() ?? "0")
                    .font(.caption).animation(Animation.default.speed(2))
                
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}
struct RecoveredView: View {
    let summary: Summary?
    var body: some View {
        VStack {
            Text("Recovered")
            HStack {
                Text(summary?.totalRecovered() ?? "0")
                    .font(.title).animation(Animation.default.speed(2))
                Image("arrow.up").foregroundColor(Color.green)
                Text(summary?.newRecovered() ?? "0")
                    .font(.caption).animation(Animation.default.speed(2))
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    let viewModel: SummaryViewModel
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if searchText.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.text = ""
                }
            }
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            text = searchBar.text ?? ""
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search country here..."
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
        viewModel.search(text: text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SummaryViewModel(summaryClient: SummaryClient()))
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
