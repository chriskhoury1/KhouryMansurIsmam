module BBP_FreshnessAssertion

open util/boolean

enum StatusValue { Optimal, Medium, Bad, MaintenanceRequired }

sig Segment {
    var currentStatus: one StatusValue
}

sig User {}

sig Report {
    target: one Segment,
    author: one User,
    declaredValue: one StatusValue,
    var isFresh: one Bool,
    var isConfirmed: one Bool
}

fun validReports[s: Segment]: set Report {
    { r: Report | r.target = s and r.isFresh = True and r.isConfirmed = True }
}

assert FreshOverridesStale {
    always (
        all s: Segment |
        (some r: validReports[s] | r.declaredValue = Optimal)
        implies s.currentStatus = Optimal
    )
}

check FreshOverridesStale for 8
