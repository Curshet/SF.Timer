import Cocoa
import Foundation

class Table: CustomStringConvertible {
    
    private var timers: [Timer] = []
    
    private func updateTimers() {
        var validTimers: [Timer] = []
        for timer in timers {
            if !timer.isFinished() {
                validTimers.append(timer)
            }
        timers = validTimers
    }
}
    
    func updateTable() {
        updateTimers()
        timers = timers.sorted { $0.remainTime()! > $1.remainTime()! }
    }
    
    var description: String {
        return "\(timers)"
    }
    
    func addTimer(timer: Timer) {
        timers.append(timer)
    }
    
}


class Timer {
    
    var name: String
    var countDown: Int
    
    private var startTime: Int?
    private var pauseStatus = false
    private var pauseTime: Int?
    private var pausePeriod = 0
    
    func start() {
        guard pauseTime == nil else { return }
        startTime = Int(Date().timeIntervalSince1970)
    }
    
    func isFinished() -> Bool {
        guard startTime == nil else { return true }
        
        let currentTime = Int(Date().timeIntervalSince1970)
        if pauseTime != nil {
             return false
        } else {
            return (currentTime - startTime!) - pausePeriod > countDown
        }
    }

    func remainTime() -> Int? {
        guard startTime != nil else { return nil }
        
        let currentTime = Int(Date().timeIntervalSince1970)
        return currentTime - startTime!
    }

    func pause() {
        pauseTime = Int(Date().timeIntervalSince1970)
    }
    
    func resume() {
        guard pauseTime != nil else { return }
        
        let currentTime = Int(Date().timeIntervalSince1970)
        let diff = currentTime - pauseTime!
        pausePeriod += diff
        pauseTime = nil
        pauseStatus = false
    }
    
    init(name: String, countDown: Int) {
        self.name = name
        self.countDown = countDown
    }
    
}


//var tableOne: Table = .init()
//var timerOne: Timer = .init(name: "Timer1", countDown: 999)
//tableOne.addTimer(timer: timerOne)
//print(tableOne)
//timerOne.start()
//timerOne.pause()
//tableOne.updateTable()
//print(tableOne)


