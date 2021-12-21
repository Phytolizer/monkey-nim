from token import Token

type
  Node* = ref object of RootObj

  Statement* = ref object of Node
  LetStatement* = ref object of Statement
    token*: Token
    name*: Identifier
    value*: Expression

  Expression* = ref object of Node
  Identifier* = ref object of Expression
    token*: Token
    value*: string

  Program* = ref object of Node
    statements*: seq[Statement]

method tokenLiteral(this: Node): string {.base.} =
  raiseAssert "Node.tokenLiteral was called without being overridden"

method tokenLiteral(this: Program): string =
  if this.statements.len > 0:
    this.statements[0].tokenLiteral()
  else:
    ""

method tokenLiteral(this: LetStatement): string = this.token.literal
method tokenLiteral(this: Identifier): string = this.token.literal
