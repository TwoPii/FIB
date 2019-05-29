| alu.cmd
| Written 2/6/02 David_Harris@hmc.edu
|
| Simulate the ALU for Lab 3.

| AND setup
l binv
h binvb
l op[1]
h opb[1]
l op[0]
h opb[0]

| 0 & 0 = 0
l a
l b
s 5
assert result 0

| 0 & 1 = 0
l a
h b
s 5
assert result 0

| 1 & 0 = 0
h a
l b
s 5
assert result 0

| 1 & 1 = 1
h a
h b
s 5
assert result 1

| OR setup
l binv
h binvb
l op[1]
h opb[1]
h op[0]
l opb[0]

| 0 | 0 = 0
l a
l b
s 5
assert result 0

| 0 | 1 = 1
l a
h b
s 5
assert result 1

| 1 | 0 = 1
h a
l b
s 5
assert result 1

| 1 | 1 = 1
h a
h b
s 5
assert result 1

| ADD setup
l binv
h binvb
h op[1]
l opb[1]
l op[0]
h opb[0]

| 0 + 0 + 0 = 00
l a
l b
l cin
s 5
assert result 0
assert cout 0

| 0 + 0 + 1 = 01
l a
l b
h cin
s 5
assert result 1
assert cout 0

| 0 + 1 + 0 = 01
l a
h b
l cin
s 5
assert result 1
assert cout 0

| 0 + 1 + 1 = 10
l a
h b
h cin
s 5
assert result 0
assert cout 1

| 1 + 0 + 0 = 01
h a
l b
l cin
s 5
assert result 1
assert cout 0

| 1 + 0 + 1 = 10
h a
l b
h cin
s 5
assert result 0
assert cout 1

| 1 + 1 + 0 = 10
h a
h b
l cin
s 5
assert result 0
assert cout 1

| 1 + 1 + 1 = 11
h a
h b
h cin
s 5
assert result 1
assert cout 1

| SUB setup
h binv
l binvb
h op[1]
l opb[1]
l op[0]
h opb[0]

| 0 + 0b + 0 = 01 (just test one case to verify inversion works)
l a
l b
l cin
s 5
assert result 1
assert cout 0

| SLT setup
l binv
h binvb
h op[1]
l opb[1]
h op[0]
l opb[0]

| less = 0
l less
s 5
assert result 0

| less = 1
h less
s 5
assert result 1