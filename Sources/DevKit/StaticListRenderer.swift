import UIKit

public struct StaticSection {
    public let title: String?
    public private(set) var rows: [StaticRow]

    public init(title: String?, rows: [StaticRow]) {
        self.title = title
        self.rows = rows
    }
}

public struct StaticRow {
    private let title: String
    private let subtitle: String?
    private let style: UITableViewCell.CellStyle
    private let accessory: UITableViewCell.AccessoryType
    private let selectHandler: () -> Void

    public init(
        title: String,
        subtitle: String? = nil,
        style: UITableViewCell.CellStyle = .default,
        accessory: UITableViewCell.AccessoryType = .none,
        selectHandler: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.accessory = accessory
        self.selectHandler = selectHandler
    }

    public func buildCell() -> UITableViewCell {
        let cell = UITableViewCell(style: style, reuseIdentifier: nil)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        cell.accessoryType = accessory
        return cell
    }

    public func handleSelect() {
        selectHandler()
    }
}

open class StaticListRenderer: NSObject {
    public weak var tableView: UITableView? {
        didSet {
            connectWithTableView()
        }
    }

    public private(set) var sections: [StaticSection] = []

    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        connectWithTableView()
    }

    open func display(sections: [StaticSection]) {
        self.sections = sections
        tableView?.reloadData()
    }

    private func connectWithTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
}

extension StaticListRenderer: UITableViewDataSource, UITableViewDelegate {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getRow(for: indexPath).buildCell()
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        getRow(for: indexPath).handleSelect()
    }

    private func getRow(for indexPath: IndexPath) -> StaticRow {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
