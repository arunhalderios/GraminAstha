//
//  MemberListView.swift
//  Gramin Astha
//
//  Created by Debabrata Mandal on 13/08/26.
//

import SwiftUI


struct Group: View {
    var body: some View {
        Text("New Member")
            .font(.largeTitle)
            .navigationTitle("New Member")
    }
}

struct CashBookView: View {
    var body: some View {
        Text("Cash Book")
            .font(.largeTitle)
            .navigationTitle("Cash Book")
    }
}

struct LedgerView: View {
    var body: some View {
        Text("Ledger")
            .font(.largeTitle)
            .navigationTitle("Ledger")
    }
}

struct UnknownView: View {
    var body: some View {
        Text("Unknown")
            .font(.largeTitle)
            .navigationTitle("Unknown")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .navigationTitle("Settings")
    }
}
