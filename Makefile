# Copyright 2014 The kv Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

.PHONY: all editor todo clean nuke

grep=--include=*.go --include=*.run --include=*.y

all: editor
	go build
	go vet
	golint .
	go install
	make todo

clean:
	go clean
	rm -f *~ _testdata/temp*

editor:
	go fmt
	go test -i
	go test

nuke: clean
	go clean -i
todo:
	@grep -nr $(grep) ^[[:space:]]*_[[:space:]]*=[[:space:]][[:alpha:]][[:alnum:]]* * || true
	@grep -nrw $(grep) BUG * || true
	@grep -nrw $(grep) LATER * || true
	@grep -nrw $(grep) MAYBE * || true
	@grep -nrw $(grep) TODO * || true
	@grep -nrw $(grep) println * || true
