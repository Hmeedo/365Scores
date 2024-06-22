//
//  GamesTimeLinePresenter.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import Foundation

protocol GamesTimeLinePresenterProtocol: AnyObject {
    func viewLoaded()
    func reloadButtonPressed()
    func numberOfTimeLineObjects() -> Int
    func timeLineObjectAtRow(_ row: Int) -> TimeLineObject
    func objectTypeAtRow(_ row: Int) -> TimeLineObjectType
}

class GamesTimeLinePresenter: GamesTimeLinePresenterProtocol {
    private weak var view: GamesTimeLineViewProtocol?
    private var dataManager: TimeLineManagerProtocol?
    private var timeLineObjects: [TimeLineObject] = []
    private var fetchTimeLineTask: Task<Void, Error>?
    
    init(view: GamesTimeLineViewProtocol, dataManager: TimeLineManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func numberOfTimeLineObjects() -> Int {
        timeLineObjects.count
    }
    
    func timeLineObjectAtRow(_ row: Int) -> TimeLineObject {
        timeLineObjects[row]
    }
    
    func objectTypeAtRow(_ row: Int) -> TimeLineObjectType {
        timeLineObjects[row].type
    }
    
    func viewLoaded() {
        fetchData()
    }
    
    func reloadButtonPressed() {
        fetchData()
    }
    
    private func fetchData() {
        guard let dataManager = dataManager else {
            return
        }
        //cancel the task if its already running
        fetchTimeLineTask?.cancel()
        fetchTimeLineTask = nil
        view?.showLoading()
        //[weak self] resolve the retain cycle. and we cancel the task on deinit
        fetchTimeLineTask = Task { @MainActor [weak self] in
            guard let self else {
                return
            }
            do {
                timeLineObjects = try await dataManager.fetchTimeLine()
                view?.showTimeLine()
            }
            catch {
                view?.showError(error: error.localizedDescription)
            }
        }
    }
    
    deinit {
        fetchTimeLineTask?.cancel()
    }
}
