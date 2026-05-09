# CS 4700 Project 1: Socket Basics

## High-level approach

This submission implements `client` as a Python 3 command-line program using only the standard library. It opens a TCP connection to the requested host and port, optionally wraps the socket with TLS when `-s` is supplied, sends the required JSON-line `hello` and `guess` messages, reads newline-terminated JSON responses, and prints exactly the flag from a valid `bye` message.

## Guessing strategy

The client loads the official five-letter word list from `project1-words.txt` when that file is present. If the file is not bundled, it attempts to download the official list from the course URL at runtime. For each `retry`, the client replays the full server-provided guess history against every candidate word using Wordle-style duplicate-letter accounting, keeps only candidates that exactly match the marks, and then chooses the remaining candidate with the strongest positional and unique-letter frequency score. This keeps the client stateless with respect to the protocol history while still reducing the candidate set quickly.

## Protocol and error handling

The implementation validates that server messages contain exactly the expected fields for `start`, `retry`, and `bye`, checks mark arrays for the required length and values, reads until `\n` so partial socket reads are handled correctly, and prints diagnostic errors to stderr if the server returns `error` or malformed data.

## Testing

I tested the code with Python bytecode compilation and local unit-style simulations of the Wordle mark/filter logic and argument parser. To retrieve your personal flags, run both:

```bash
./client proj1.4700.network <your-northeastern-username>
./client -s proj1.4700.network <your-northeastern-username>
```

Then place the two returned flags, one per line, in `secret_flags` before submitting to Gradescope.
