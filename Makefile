ifeq ($(GOHOSTOS), windows)
	#the `find.exe` is different from `find` in bash/shell.
	#to see https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find.
	#changed to use git-bash.exe to run find cli or other cli friendly, caused of every developer has a Git.
	Git_Bash=$(subst \,/,$(subst cmd\,bin\bash.exe,$(dir $(shell where git))))
	API_PROTO_FILES_MARKSMAN=$(shell $(Git_Bash) -c "find marksman -name '*.proto'")
	API_PROTO_FILES_RABBIT=$(shell $(Git_Bash) -c "find rabbit -name '*.proto'")
	API_PROTO_FILES_MAGICBOX=$(shell $(Git_Bash) -c "find magicbox -name '*.proto'")
	API_PROTO_FILES_GODDESS=$(shell $(Git_Bash) -c "find goddess -name '*.proto'")
else
	API_PROTO_FILES_MARKSMAN=$(shell find marksman -name '*.proto')
	API_PROTO_FILES_RABBIT=$(shell find rabbit -name '*.proto')
	API_PROTO_FILES_MAGICBOX=$(shell find magicbox -name '*.proto')
	API_PROTO_FILES_GODDESS=$(shell find goddess -name '*.proto')
endif


.PHONY: marksman
# generate the marksman api files
marksman:
	@echo "Generating api files"
	protoc --proto_path=./ \
	       --proto_path=./third_party \
 	       --go_out=paths=source_relative:./marksman \
 	       --go-http_out=paths=source_relative:./marksman \
 	       --go-grpc_out=paths=source_relative:./marksman \
	       --openapi_out=fq_schema_naming=true,default_response=false:./marksman\
	       --experimental_allow_proto3_optional \
	       $(API_PROTO_FILES_MARKSMAN)

.PHONY: rabbit
# generate the rabbit api files
rabbit:
	@echo "Generating api files"
	protoc --proto_path=./ \
	       --proto_path=./third_party \
	       --proto_path=./rabbit \
 	       --go_out=paths=source_relative:./rabbit \
 	       --go-http_out=paths=source_relative:./rabbit \
 	       --go-grpc_out=paths=source_relative:./rabbit \
	       --openapi_out=fq_schema_naming=true,default_response=false:./rabbit\
	       --experimental_allow_proto3_optional \
	       $(API_PROTO_FILES_RABBIT)

.PHONY: magicbox
# generate the magicbox api files
magicbox:
	@echo "Generating api files"
	protoc --proto_path=./ \
	       --proto_path=./third_party \
 	       --go_out=paths=source_relative:./magicbox \
 	       --go-http_out=paths=source_relative:./magicbox \
 	       --go-grpc_out=paths=source_relative:./magicbox \
	       --openapi_out=fq_schema_naming=true,default_response=false:./magicbox\
	       --experimental_allow_proto3_optional \
	       $(API_PROTO_FILES_MAGICBOX)

.PHONY: goddess
# generate the goddess api files
goddess:
	@echo "Generating api files"
	protoc --proto_path=./ \
	       --proto_path=./third_party \
 	       --go_out=paths=source_relative:./goddess/ \
 	       --go-http_out=paths=source_relative:./goddess/ \
 	       --go-grpc_out=paths=source_relative:./goddess/ \
	       --openapi_out=fq_schema_naming=true,default_response=false:./goddess\
	       --experimental_allow_proto3_optional \
	       $(API_PROTO_FILES_GODDESS)

.PHONY: all
# generate all api files
all: marksman rabbit magicbox goddess