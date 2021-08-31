class Machine:
    def __init__(self, states, symbols):
        self.init_moves()
        self.init_states(states)
        self.init_symbols(symbols)
        self.init_quintuples()
        self.state = 'start'

    def __repr__(self):
        return str(self.quintuples)

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
            raise ValueError(f"Illegal move value: {val}")
        if (val := quintuple[1]) not in self.symbols:
            raise ValueError(f"Illegal tape read value: {val}")
        if (val := quintuple[2]) not in self.symbols:
            raise ValueError(f"Illegal tape write value: {val}")
        if (val := quintuple[0]) not in self.states:
            raise ValueError(f"Illegal initial state value: {val}")
        if (val := quintuple[4]) not in self.states:
            raise ValueError(f"Illegal successor state value: {val}")
        k = quintuple[0], quintuple[1]
        if (k in self.quintuples):
            existing = self.quintuples[k]
            raise ValueError(f"{k} already exists in {existing}")
        self.quintuples[k] = quintuple

    def get_quintuple(self, symbol):
        return self.quintuple[(self.state, symbol)]

    def exec(self, tape):
        state = None


class AddingMachine(Machine):
    def __init__(self, states, symbols):
        Machine.__init__(self, states, symbols)


class AddOneDigit(Machine):
    def __init__(self, states, symbols):
        Machine.__init__(self, states, symbols)


