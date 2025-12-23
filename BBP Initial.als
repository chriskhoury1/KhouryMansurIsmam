module BBP_Initial

open util/boolean

enum StatusValue { Optimal, Medium, Bad, MaintenanceRequired }
enum SourceType { Manual, Automated }

sig Location {}

sig Segment {
    startNode: one Location,
    endNode: one Location,
    var currentStatus: one StatusValue
}

sig User {}

sig Report {
    target: one Segment,
    author: one User,
    declaredValue: one StatusValue,
    source: one SourceType,
    var isFresh: one Bool,
    var isConfirmed: one Bool
}

fact Topology {
    all s: Segment | s.startNode != s.endNode
}

pred initialWorld {
    no Report
}

run initialWorld for 3
