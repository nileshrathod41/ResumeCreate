//
//  DashboardContentView.swift
//  AnyMindResume
//
//  Created by Nil Rathod on 11/03/22.
//

import SwiftUI

/// Tab view at the top
enum TabViewItem: String, CaseIterable {
    case about = "person.fill"
    case contact = "envelope.fill"
    case work = "case.fill"
    case education = "graduationcap.fill"
    case skills = "hammer.fill"
    case software = "desktopcomputer"
    case summary = "book.fill"
    case done = "checkmark.seal.fill"

    /// Custom title
    var title: String {
        String(reflecting: self)
            .replacingOccurrences(of: "AnyMindResume.TabViewItem.", with: "")
            .capitalized
    }
    
    /// Next index
    var next: TabViewItem? {
        if let index = TabViewItem.allCases.firstIndex(of: self) {
            if index < (TabViewItem.allCases.count-1) {
                return TabViewItem.allCases[index+1]
            }
        }
        return nil
    }
}

/// Main view for the app
struct DashboardContentView: View {
    
    @ObservedObject var manager = PDFManager()
    @State private var selectedStep: TabViewItem = .about
    @State private var scrollViewProxy: ScrollViewProxy?
    
    // MARK: - Main rendering function
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                VStack {
                    HStack() {
                        Image("AnyMind").resizable()
                            .scaledToFit().frame(width: 100, height: 60, alignment: .center)
                    }.padding([.leading, .trailing], 0).offset(y: 0).opacity(0.8)
                    StepsViewSection
                }
                ZStack {
                    StepTabViewContainer
                    VStack {
                        Color.white.frame(height: 5)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
                        Spacer()
                    }
                    if selectedStep != .done {
                        NextButtonView
                    }
                }.edgesIgnoringSafeArea(.bottom)
            }.navigationBarHidden(true)
        }
    }
    
    /// Step tab view at the top
    private var StepsViewSection: some View {
        func captureScrollView(proxy: ScrollViewProxy) -> some View {
            DispatchQueue.main.async { scrollViewProxy = proxy }
            return EmptyView()
        }
        return ScrollView(.horizontal, showsIndicators: false, content: {
            ScrollViewReader { value in
                captureScrollView(proxy: value)
                HStack {
                    Spacer(minLength: 15)
                    ForEach(0..<TabViewItem.allCases.count, id: \.self, content: { id in
                        VStack(spacing: 5) {
                            Image(systemName: TabViewItem.allCases[id].rawValue)
                                .font(.system(size: 25)).frame(height: 35)
                            Text(TabViewItem.allCases[id].title)
                                .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                            }.offset(y: 22).frame(height: 5)
                            )
                        }
                        .padding()
                        .foregroundColor(selectedStep == TabViewItem.allCases[id] ? .accentColor : Color(#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)))
                        .onTapGesture {
                            UIImpactFeedbackGenerator().impactOccurred()
                            selectedStep = TabViewItem.allCases[id]
                            withAnimation { value.scrollTo(id + 2) }
                            manager.saveCurrentDetails()
                        }
                    })
                    Spacer(minLength: 15)
                }
            }
        })
    }
    
    /// Step tab view container
    private var StepTabViewContainer: some View {
        VStack {
            switch selectedStep {
            case .about:
                AboutTabView(manager: manager)
            case .contact:
                ContactsTabView(manager: manager)
            case .work:
                WorkTabView(manager: manager)
            case .education:
                EducationTabView(manager: manager)
            case .skills:
                SkillsTabView(manager: manager)
            case .software:
                SoftwareTabView(manager: manager)
            case .summary:
                SummaryTabView(manager: manager)
            case .done:
                DoneTabView(manager: manager)
            }
        }
    }
    
    /// Next button at the bottom
    private var NextButtonView: some View {
        VStack {
            Spacer()
            Button(action: {
                UIImpactFeedbackGenerator().impactOccurred()
                selectedStep = selectedStep.next ?? selectedStep
                if let nextIndex = TabViewItem.allCases.firstIndex(of: selectedStep) {
                    withAnimation { scrollViewProxy?.scrollTo(nextIndex + 2) }
                }
                manager.saveCurrentDetails()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, y: 5)
                    Text("Next").font(.system(size: 24))
                        .foregroundColor(.white).bold()
                }
            }).frame(height: 60).padding(30)
        }
    }
}

// MARK: - Preview UI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardContentView()
    }
}
