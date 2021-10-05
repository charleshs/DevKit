import DevKit
import Foundation
import XCTest

struct Student {
    static var mockStudents: [Student] {[
        Student(name: "Allen", age: 16, remark: "", score: 90),
        Student(name: "Bill", age: 20, remark: "", score: 50),
        Student(name: "Cathy", age: 17, remark: "", score: 70),
        Student(name: "Don", age: 24, remark: "", score: 60),
        Student(name: "Elle", age: 21, remark: "", score: 80),
    ]}

    var name: String
    var age: Int
    var remark: String
    var score: Int
}

struct Task: Hashable {
    static var mockTasks: [Task] {[
        Task(category: "Routine", name: "Do the trash", done: false, hidden: false),
        Task(category: "Routine", name: "Feed the hamster", done: true, hidden: false),
        Task(category: "Optional", name: "Read a book", done: false, hidden: false),
        Task(category: "Important", name: "Do programming", done: true, hidden: false),
    ]}

    var category: String
    var name: String
    var done: Bool
    var hidden: Bool

    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.category == rhs.category
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(category)
        hasher.combine(name)
    }
}

final class CollectionExtensionsTests: XCTestCase {
    private var students: [Student]!
    private var tasks: [Task]!

    override func setUp() {
        students = Student.mockStudents
        tasks = Task.mockTasks
    }

    override func tearDown() {
        students = nil
        tasks = nil
    }

    func testSafeSubscript() {
        XCTAssertNotNil(students[safe: students.count - 1])
        XCTAssertNil(students[safe: students.count])
    }

    func testChangeWherePredicate() {
        let threshold = 18

        students.changeElements(where: { $0.age > threshold }) { s in
            s.remark = "Grown-up"
        }
        for student in students {
            let remark = student.age > threshold ? "Grown-up" : ""
            XCTAssertEqual(student.remark, remark)
        }
    }

    func testChangeByEquality() {
        tasks.changeElements(byEquality: Task(category: "Routine", name: "Nothing", done: true, hidden: true)) { t in
            t.done = true
            t.hidden = true
        }
        for task in tasks {
            let done = task.category == "Routine" ? true : task.done
            let hidden = task.category == "Routine" ? true : task.hidden
            XCTAssertEqual(task.done, done)
            XCTAssertEqual(task.hidden, hidden)
        }
    }

    func testChangeByHashValue() {
        let position = 2

        XCTAssertEqual(tasks[position].hidden, false)
        tasks.changeElements(byHashValue: tasks[position]) { t in
            t.hidden = true
        }
        XCTAssertEqual(tasks[position].hidden, true)
    }

    func testChangeBySpecs() {
        let changeSpec1 = ChangeSpec<Task>(predicate: { $0.category == "Important" },
                                           mutation: { $0.name = "!!!" })
        let changeSpec2 = ChangeSpec<Task>(predicate: { $0.done },
                                           mutation: { $0.hidden = true })

        tasks.changeElements(bySpecs: changeSpec1, changeSpec2)

        for task in tasks {
            let hidden = task.done
            XCTAssertEqual(task.hidden, hidden)
            if task.category == "Important" { XCTAssertEqual(task.name, "!!!") }
        }
    }
}
