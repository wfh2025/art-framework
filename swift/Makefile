PROJ_DIR                 := $(abspath $(CURDIR))
VENDOR_DIR               := ${PROJ_DIR}/vendor
BUILD_DIR                := ${PROJ_DIR}/build
SWIFT                    := swift
.DEFAULT_GOAL            := help

help:  ## 打印帮助
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
all: deps build   ## 拉取依赖并构建
build: ## 构建所有子包(entry.sh 自动发现含 Package.swift 的子目录)
	${PROJ_DIR}/entry.sh build
test: ## 跑所有子包的单元测试(swift-testing)
	${PROJ_DIR}/entry.sh test
run: ## 运行 Playground 学习 app(指定课程: make run A="003 005")
	${PROJ_DIR}/entry.sh run $(A)
leetcode: ## 运行 LeetCode 刷题 app(指定题目: make leetcode A="0009 0704")
	${PROJ_DIR}/entry.sh leetcode $(A)
wordcount: ## 运行 WordCount 示例 app(参数: make wordcount A="README.md")
	${PROJ_DIR}/entry.sh wordcount $(A)
format: ## 格式化所有子包代码(swift-format)
	${PROJ_DIR}/entry.sh format
deps: ## 拉取第三方依赖到 vendor/
	${PROJ_DIR}/entry.sh deps
clean:  ## 删除所有子包的临时目录
	${PROJ_DIR}/entry.sh clean
print-%: ## 打印变量
	@echo $* = $($*)
.PHONY: all build test run leetcode wordcount format deps clean
