using SX, Reachability, MathematicalSystems

SUITE["Build"] = BenchmarkGroup()

file = @relpath "Building_more_decimals.xml"
H = readsxmodel(file, ST=ConstrainedLinearControlContinuousSystem)

# ================
# BLDF01 - BDS01
# ================

n = size(H.modes[1].A, 1)-1
A = H.modes[1].A[1:n, 1:n] 
B = eye(n)
U = Hyperrectangle(low=[0.8], high=[1.0])
X, Uin = nothing, ConstantInput(H.modes[1].B[1:n, 1] * U)
S = ConstrainedLinearControlContinuousSystem(A, B, X, Uin)
initially = " x1 >= 0.0002000 & x1 <= 0.0002500 & x2 >= 0.0002000 & x2 <= 0.0002500 & x3 >= 0.0002000 & x3 <= 0.0002500 & x4 >= 0.0002000 & x4 <= 0.0002500 & x5 >= 0.0002000 & x5 <= 0.0002500 & x6 >= 0.0002000 & x6 <= 0.0002500 & x7 >= 0.0002000 & x7 <= 0.0002500 & x8 >= 0.0002000 & x8 <= 0.0002500 & x9 >= 0.0002000 & x9 <= 0.0002500 & x10 >= 0.0002000 & x10 <= 0.0002500 & x11 >= 0.0000000 & x11 <= 0.0000000 & x12 >= 0.0000000 & x12 <= 0.0000000 & x13 >= 0.0000000 & x13 <= 0.0000000 & x14 >= 0.0000000 & x14 <= 0.0000000 & x15 >= 0.0000000 & x15 <= 0.0000000 & x16 >= 0.0000000 & x16 <= 0.0000000 & x17 >= 0.0000000 & x17 <= 0.0000000 & x18 >= 0.0000000 & x18 <= 0.0000000 & x19 >= 0.0000000 & x19 <= 0.0000000 & x20 >= 0.0000000 & x20 <= 0.0000000 & x21 >= 0.0000000 & x21 <= 0.0000000 & x22 >= 0.0000000 & x22 <= 0.0000000 & x23 >= 0.0000000 & x23 <= 0.0000000 & x24 >= 0.0000000 & x24 <= 0.0000000 & x25 >= -0.0001000 & x25 <= 0.0001000 & x26 >= 0.0000000 & x26 <= 0.0000000 & x27 >= 0.0000000 & x27 <= 0.0000000 & x28 >= 0.0000000 & x28 <= 0.0000000 & x29 >= 0.0000000 & x29 <= 0.0000000 & x30 >= 0.0000000 & x30 <= 0.0000000 & x31 >= 0.0000000 & x31 <= 0.0000000 & x32 >= 0.0000000 & x32 <= 0.0000000 & x33 >= 0.0000000 & x33 <= 0.0000000 & x34 >= 0.0000000 & x34 <= 0.0000000 & x35 >= 0.0000000 & x35 <= 0.0000000 & x36 >= 0.0000000 & x36 <= 0.0000000 & x37 >= 0.0000000 & x37 <= 0.0000000 & x38 >= 0.0000000 & x38 <= 0.0000000 & x39 >= 0.0000000 & x39 <= 0.0000000 & x40 >= 0.0000000 & x40 <= 0.0000000 & x41 >= 0.0000000 & x41 <= 0.0000000 & x42 >= 0.0000000 & x42 <= 0.0000000 & x43 >= 0.0000000 & x43 <= 0.0000000 & x44 >= 0.0000000 & x44 <= 0.0000000 & x45 >= 0.0000000 & x45 <= 0.0000000 & x46 >= 0.0000000 & x46 <= 0.0000000 & x47 >= 0.0000000 & x47 <= 0.0000000 & x48 >= 0.0000000 & x48 <= 0.0000000 & t==0"
f = i -> SX.parse_sxmath(initially)[i].args[3]
X0 = Hyperrectangle(low=[f(i) for i in 1:2:96], high=[f(i) for i in 2:2:96])
problem = InitialValueProblem(S, X0)

δ_max = 0.0009
time_horizon = 20.0
pBDS01 = LinearConstraintProperty(sparsevec([25], [1.0], 48), 0.0051) # x25 <= 0.0051

sol = solve(problem, :property => pBDS01, :T=>time_horizon, :δ=>δ_max, :vars=>[25], :mode=>"check")
SUITE["Build"]["BLDF01-BDS01", "dense"] = @benchmarkable solve($problem, :property => $pBDS01, :T=>$time_horizon, :δ=>$δ_max, :vars=>[25], :mode=>"check")

sol = solve(problem, :approx_model=>"nobloating", :property=>pBDS01, :T=>time_horizon, :δ=>δ_max, :vars=>[25], :mode=>"check")
SUITE["Build"]["BLDF01-BDS01", "discrete"] = @benchmarkable solve($problem, :approx_model=>"nobloating", :property => $pBDS01, :T=>$time_horizon, :δ=>$δ_max, :vars=>[25], :mode=>"check")

# ================
# BLDC01 - BDS01
# ================

n = size(H.modes[1].A, 1)-1
A = H.modes[1].A[1:n, 1:n]
A = Reachability.add_dimension(A) # add an extra zero row and column
S = LinearContinuousSystem(A)
X0 = X0 * U
problemConst = InitialValueProblem(S, X0);

pBLDC01 = LinearConstraintProperty(sparsevec([25], [1.0], n+1), 0.0051) # x25 <= 0.0051

sol = solve(problemConst, :T=>time_horizon, :δ=>δ_max, :vars=>[25], :mode=>"check", :property => pBLDC01, :assume_homogeneous=>true)
SUITE["Build"]["BLDC01-BDS01", "dense"] = @benchmarkable solve($problemConst, :T=>$time_horizon, :δ=>$δ_max, :vars=>[25], :mode=>"check", :property => $pBLDC01, :assume_homogeneous=>true)

sol = solve(problemConst, :T=>time_horizon, :δ=>δ_max, :vars=>[25], :mode=>"check", :property => pBLDC01, :assume_homogeneous=>true)
SUITE["Build"]["BLDC01-BDS01", "discrete"] = @benchmarkable solve($problemConst, :approx_model=>"nobloating", :T=>$time_horizon, :δ=>$δ_max, :vars=>[25], :mode=>"check", :property => $pBLDC01, :assume_homogeneous=>true)