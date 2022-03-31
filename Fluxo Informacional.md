
1. Os dados são enviados pelos participantes do consórcio para nós
2. Nós armazenamos esses dados em uma pasta `data/raw/`,  dentro de um servidor de arquivos estáticos
3. O dado é preprocessado, e o resultado é armazenado na pasta `data/clean`, dentro do mesmo servidor
4. O diretório `data/clean` obedece uma estrutura hierárquica que reflete a hierarquia do próprio consórcio:

Consortium (EBOVAC)
	-> Cohort (Geneva)
		-> Experiment Level (Gene Expression)
			-> Experiment Type (RNA-Seq)
				-> Experiment Data (counts, pheno)

