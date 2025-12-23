module BBP_Example1

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

pred example1 {
    some s: Segment,
         u1, u2: User,
         r1, r2: Report |
         
        u1 != u2 and
        r1 != r2 and

        r1.source = Automated and
        r1.isConfirmed = False and
        r1.isFresh = True and
        r1.declaredValue = Bad and
        r1.target = s and
        r1.author = u1 and

        r2.source = Manual and
        r2.isConfirmed = True and
        r2.isFresh = True and
        r2.declaredValue = Optimal and
        r2.target = s and
        r2.author = u2
}

run example1 for 5
