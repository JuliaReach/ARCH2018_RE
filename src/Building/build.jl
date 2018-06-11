using SX, Reachability, MathematicalSystems

SUITE["Build"] = BenchmarkGroup()

file = @relpath "Building_more_decimals.xml"
H = readsxmodel(file, ST=ConstrainedLinearControlContinuousSystem);

# ================
# BLDF01 - BDS01
# ================



# ================
# BLDC01 - BDS01
# ================