//
//  AutocompleteViewModel.swift
//  Mobile_Development_CA2
//
//  Created by Student on 17/04/2025.
//

//Some of the following code is taken from:
//https://hackernoon.com/address-autocompletion-using-swiftui-and-mapkit
//https://www.youtube.com/watch?v=cOD1l2lv2Jw


import Foundation
import MapKit
import Combine

class AutocompleteViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var searchQuery = ""

    @Published var suggestions: [MKLocalSearchCompletion] = []

    private var completer: MKLocalSearchCompleter

    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()

        // Set this ViewModel as the delegate to receive updates.
        completer.delegate = self

        // Specify the type of results we want (addresses).
        completer.resultTypes = .address
    }

    // Update the autocomplete query whenever the user types in the search field.
    func updateSearch(query: String) {
        completer.queryFragment = query
    }

    // Method called when new autocomplete results are available.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.suggestions = completer.results
        }
    }

    // Method called if the search completer fails to fetch results.
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error fetching suggestions: \(error.localizedDescription)")
    }
}
