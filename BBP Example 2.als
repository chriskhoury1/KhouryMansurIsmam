module BBP_Example2

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

pred example2 {
    some s: Segment,
         u1, u2: User,
         r1, r2: Report | {

        u1 != u2
        r1 != r2

        r1.target = s
        r2.target = s
        r1.author = u1
        r2.author = u2

        r1.isConfirmed = True
        r2.isConfirmed = True
        r1.isFresh = True
        r2.isFresh = True

        r1.declaredValue = Optimal
        r2.declaredValue = Bad
    }
}

run example2 for 5
