//
//  GamesTimeLinePresenter.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import Foundation

protocol GamesTimeLinePresenterProtocol: AnyObject {
    func fetchData()
    func viewLoaded()
    func numberOfRowsInSection(_ section: Int) -> Int
    func timeLineObjectAtRow(_ row: Int) -> TimeLineObject
    func objectTypeAtRow(_ row: Int) -> TimeLineObjectType
}

class GamesTimeLinePresenter: GamesTimeLinePresenterProtocol {
    weak var view: GamesTimeLineViewProtocol?
    private(set) var dataManager: TimeLineManagerProtocol?
    
    private var timeLineObjects: [TimeLineObject] = []
    
    init(view: GamesTimeLineViewProtocol, dataManager: TimeLineManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }

    func viewLoaded() {
        fetchData()
    }
    
    func fetchData() {
        guard let dataManager = dataManager else {
            return
        }
        view?.showLoading()
        Task { @MainActor in
            do {
                timeLineObjects = try await dataManager.fetchTimeLine()
                view?.showTimeLine()
            }
            catch {
                view?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        timeLineObjects.count
    }
    
    func timeLineObjectAtRow(_ row: Int) -> TimeLineObject {
        timeLineObjects[row]
    }
    
    func objectTypeAtRow(_ row: Int) -> TimeLineObjectType {
        timeLineObjects[row].type
    }
}
