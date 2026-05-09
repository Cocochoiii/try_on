.PHONY: all clean test

all:
	@chmod +x client

clean:
	@rm -rf __pycache__ .pytest_cache

test:
	python3 -m py_compile client
