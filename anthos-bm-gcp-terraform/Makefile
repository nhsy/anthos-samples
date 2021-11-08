define header
	$(info Running >>> $(1)$(END))
endef

.PHONY: init
init:
	$(call header,$@)
	@scripts/tf-wrapper.sh $@

.PHONY: validate
validate:
	$(call header,$@)
	@scripts/tf-wrapper.sh $@

.PHONY: plan
plan: init validate
	$(call header,$@)
	@scripts/tf-wrapper.sh $@

.PHONY: apply
apply: init
	$(call header,$@)
	@scripts/tf-wrapper.sh $@ -auto-approve

.PHONY: destroy
destroy: init validate
	$(call header,$@)
	@scripts/tf-wrapper.sh $@ -auto-approve


.PHONY: clean
clean:
	$(call header,$@)
	@scripts/clean.sh

.PHONY: all
all: init validate apply
