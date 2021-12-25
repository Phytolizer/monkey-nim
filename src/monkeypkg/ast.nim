from token import Token

type
  Node* = ref object of RootObj

  Statement* = ref object of Node
  LetStatement* = ref object of Statement
    token*: Token
    name*: Identifier
    value*: Expression
  ReturnStatement* = ref object of Statement
    token*: Token
    returnValue*: Expression
  ExpressionStatement* = ref object of Statement
    token*: Token
    expression*: Expression

  Expression* = ref object of Node
  Identifier* = ref object of Expression
    token*: Token
    value*: string

  Program* = ref object of Node
    statements*: seq[Statement]

method tokenLiteral*(this: Node): string {.base.} =
  raiseAssert "Node.tokenLiteral was called without being overridden"

method toString*(this: Node): string {.base.} =
  raiseAssert "Node.toString was called without being overridden"

method tokenLiteral*(this: Program): string =
  if this.statements.len > 0:
    this.statements[0].tokenLiteral()
  else:
    ""

method tokenLiteral*(this: LetStatement): string = this.token.literal
method tokenLiteral*(this: Identifier): string = this.token.literal
method tokenLiteral*(this: ReturnStatement): string = this.token.literal
method tokenLiteral*(this: ExpressionStatement): string = this.token.literal

method toString*(this: Program): string =
  for s in this.statements:
    result &= s.toString()

method toString*(this: LetStatement): string =
  result = this.tokenLiteral() & " " & this.name.toString() & " = "
  if not this.value.isNil:
    result &= this.value.toString()
  result &= ";"

method toString*(this: ReturnStatement): string =
  result = this.tokenLiteral() & " "
  if not this.returnValue.isNil:
    result &= this.returnValue.toString()
  result &= ";"

method toString*(this: ExpressionStatement): string =
  if not this.expression.isNil:
    result = this.expression.toString()

method toString*(this: Identifier): string =
  this.value
