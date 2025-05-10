extends Node
class_name Global

enum CommandFunc {
	AND2 = 0,
	OR2 = 1,
	NOT = 2,
	VAR = 3,
	OUT = 4
}

enum ContactKind {
	IN = 0,
	OUT = 1
}

const CommandNames := {
	CommandFunc.AND2: "2AND",
	CommandFunc.OR2: "2OR",
	CommandFunc.NOT: "NOT",
	CommandFunc.VAR: "VAR",
	CommandFunc.OUT: "OUT",
}

var CommandColors := {
	CommandFunc.AND2: Color.hex(0x4287f5ff),
	CommandFunc.OR2: Color.hex(0xb0f542ff),
	CommandFunc.NOT: Color.hex(0xf59e42ff),
	CommandFunc.VAR: Color.hex(0xf5428dff),
	CommandFunc.OUT: Color.hex(0x42f5a7ff)
}
