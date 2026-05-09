# CS 4700 Project 1: Socket Basics

## High-level approach

This submission implements the required command-line program named `client` in
Python 3. The client opens a TCP connection to the host and port from the command
line, sends the required newline-terminated JSON `hello` message, receives the
server's `start` message, and then repeatedly sends `guess` messages until the
server returns `bye`. The program prints exactly the flag from the server's
`bye` message on standard output.

The `-p` option overrides the port. Without `-p`, the program uses port `27993`
for plain TCP and port `27994` when `-s` is present. When `-s` is supplied, the
same JSON protocol is run over a TLS socket created with Python's standard
`ssl` library.

## Guessing strategy

The client loads the official Project 1 word list from the course URL into
memory and only guesses lowercase five-letter words from that list. It does not
write the word list or any flags to disk.

After every `retry`, the server provides the complete guess history. The client
uses that history to filter the word list to candidate secrets that would have
produced exactly the same marks for every previous guess. The mark-computation
function handles duplicate letters using the standard two-pass Wordle algorithm:
first mark exact matches, then mark misplaced letters only while unmatched copies
of that letter remain in the candidate secret.

Among the remaining candidates, the client chooses a word with high positional
letter frequency and broad unique-letter coverage. This keeps the strategy simple
while reducing the candidate set quickly and staying well below the server's
500-incorrect-guess limit in normal play.

## Challenges

The most important details were reading from the socket until a newline instead
of assuming one `recv` call contains a whole JSON object, preserving the full
server-provided game ID, supporting both plain TCP and TLS, and treating repeated
letters correctly when comparing server marks to local candidate marks.

## Testing

I tested the implementation with Python syntax checks and local unit-style checks
for argument parsing, duplicate-letter scoring, candidate filtering, and guess
selection. The code uses only Python standard-library modules, so the Makefile
only ensures the `client` script is executable.

## Secret flags

Run the following commands with your Northeastern username and copy the two
printed flags into the `secret_flags` file, one flag per line:

```bash
./client proj1.4700.network <Northeastern-username>
./client -s proj1.4700.network <Northeastern-username>
```
