SWIFT_BUILD = swift build
SWIFT_RELEASE_BUILD = $(SWIFT_BUILD) -c release
NAME = langch

build:
	$(SWIFT_RELEASE_BUILD)
	cp .build/release/$(NAME) ./

run: build
	./$(NAME)

clean:
	swift package clean
	rm -rf .build
	rm -rf ./${NAME}
