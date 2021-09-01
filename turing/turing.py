class Machine:
    def __init__(self, states, symbols):
        self.init_moves()
        self.init_states(states)
        self.init_symbols(symbols)
        self.init_quintuples()
        self.state = 'start'

    def __repr__(self):
        quintuples = list(self.quintuples.values())
        quintuples.sort()
        return str(quintuples)

    def init_moves(self):
        self.moves = { -1, 0, 1 }

    def init_states(self, states):
        self.states = { 'start', 'end' }
        self.states.update([ s.lower() for s in states])

    def init_symbols(self, symbols):
        self.symbols = { ' ', '0', '1' }
        self.symbols.update(symbols)
        
    def init_quintuples(self):
        self.quintuples = { }
        
    def add_tuple(self, quintuple):
        quintuple[0] = quintuple[0].lower()
        quintuple[4] = quintuple[4].lower()
        if (val := quintuple[3]) not in self.moves:
            raise ValueError("Illegal move value: %s" %(val))
        if (val := quintuple[1]) not in self.symbols:
            raise ValueError("Illegal tape read value: %s" %(val))
        if (val := quintuple[2]) not in self.symbols:
            raise ValueError("Illegal tape write value: %s" %(val))
        if (val := quintuple[0]) not in self.states:
            raise ValueError("Illegal initial state value: %s" %(val))
        if (val := quintuple[4]) not in self.states:
            raise ValueError("Illegal successor state value: %s" %(val))
        k = quintuple[0], quintuple[1]
        if (k in self.quintuples):
            existing = self.quintuples[k]
            raise ValueError("%s already exists in %s" %(k, exisiting))
        self.quintuples[k] = quintuple
        return True

    def get_quintuple(self, state, symbol):
        return self.quintuples[(state, symbol)]

    def set_tape(self, tapeString):
        self.tape = list(tapeString)
        self.pos = 0

    def get_tape(self):
        return "".join(self.tape)

    def step(self):
        if self.state != 'end':
            q = self.get_quintuple(self.state, tape[self.pos])
            self.tape[self.pos] = q[2]
            self.change_tape(q[3])
            self.state = q[4]

    def change_tape(self, move):
        newpos = self.pos + move
        if newpos < 0:
            self.tape.insert(0, ' ')
            newpos = 0
        elif newpos == len(self.tape):
            self.tape.insert(newpos, ' ')
        self.pos = newpos

        

    def exec_all(self):
        while self.state != 'end':
            self.step()
            
        


class AddingMachine(Machine):
    def __init__(self, states, symbols):
        Machine.__init__(self, states, symbols)


class AddOneDigit(Machine):
    def __init__(self, states, symbols):
        Machine.__init__(self, states, symbols)


