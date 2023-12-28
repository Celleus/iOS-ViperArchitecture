.PHONY: generate-module
generate-module: # Generate VIPER module
	mint run genesis generate ./Genesis/Templates/GenesisVIPERTemplate/template.yml --options "date:$(shell date +%Y/%m/%d)" --option-path BootstrapOptions.yml

.PHONY: generate-repository-module
generate-module: # Generate VIPER module
	mint run genesis generate ./Genesis/Templates/GenesisVIPERRTemplate/template.yml --options "date:$(shell date +%Y/%m/%d)" --option-path BootstrapOptions.yml