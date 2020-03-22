

import UIKit



struct task{
    var name = "un-named"
    var desc = "un-descripted"
}

class TaskManager: NSObject {
    
    var tasks = [task]()
    
    func addTask(name: String, desc: String){
        tasks.append(task(name: name, desc: desc))
    }
}

var taskMgr : TaskManager = TaskManager()
