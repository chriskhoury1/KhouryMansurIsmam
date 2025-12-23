module BBP_SafetyAssertion

open util/boolean

enum StatusValue { Optimal, Medium, Bad, MaintenanceRequired }
enum SourceType { Manual, Automated }

sig Segment {
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

fun validReports[s: Segment]: set Report {
    { r: Report | r.target = s and r.isFresh = True and r.isConfirmed = True }
}

assert NoUnconfirmedInfluence {
    always (
        all s: Segment |
        no r: validReports[s] | r.isConfirmed = False
    )
}

check NoUnconfirmedInfluence for 8
