# Apostila DE10-Lite com Quartus Prime e VHDL

Este repositório contém uma apostila em LaTeX sobre a criação de um projeto no Quartus Prime Lite para o kit FPGA Terasic DE10-Lite. O roteiro é voltado para VHDL e usa como exemplo um contador decimal exibido nos displays de sete segmentos, com reset e carga paralela pelas chaves da placa.

Autor: Prof. Felipe Walter Dafico Pfrimer

## Conteúdo

- `main.tex`: fonte LaTeX da apostila.
- `main.pdf`: versão compilada da apostila.
- `img/`: imagens usadas no material.
- `projeto/Contador_DE10_Lite.vhd`: top-level em VHDL do exemplo.
- `projeto/projeto.qpf` e `projeto/projeto.qsf`: arquivos do projeto Quartus.
- `projeto/DE10_LITE_Golden_Top.v`: arquivo gerado automaticamente pelo fluxo da DE10-Lite, usado apenas como referência para nomes de portas.

## Objetivo da apostila

A apostila apresenta o fluxo básico para:

- criar um projeto no Quartus Prime Lite;
- selecionar a placa MAX 10 DE10-Lite;
- criar um top-level design em VHDL;
- entender o papel do arquivo `DE10_LITE_Golden_Top.v`;
- configurar ou conferir os pinos do projeto;
- compilar o circuito;
- gravar o arquivo `.sof` na placa usando o Programmer.

## Exemplo implementado

O projeto VHDL implementa um contador decimal de `00` a `99`:

- `KEY(0)`: reset;
- `KEY(1)`: carga paralela;
- `SW(7 downto 0)`: valor BCD carregado;
- `HEX0` e `HEX1`: displays de sete segmentos;
- `LEDR`: indicação visual do valor das chaves;
- `MAX10_CLK1_50`: clock de 50 MHz da placa.

## Compilando a apostila

Para gerar o PDF a partir do LaTeX:

```powershell
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

Rodar duas vezes ajuda a atualizar sumário, referências de figuras, tabelas e códigos.

## Validando o VHDL

Com GHDL instalado, é possível fazer uma checagem de análise do arquivo VHDL:

```powershell
cd projeto
ghdl -a --std=08 Contador_DE10_Lite.vhd
```

Essa verificação não substitui a compilação no Quartus, mas ajuda a encontrar erros de sintaxe em VHDL.

## Observação sobre o Golden Top

O arquivo `DE10_LITE_Golden_Top.v` pode ser criado automaticamente quando a opção `Create top-level design file` permanece marcada durante a criação do projeto no Quartus/Terasic. Nesta apostila, esse arquivo não é usado como descrição do circuito. Ele serve apenas como referência para os nomes das portas da placa, como `SW`, `KEY`, `LEDR`, `HEX0`, `HEX1` e `MAX10_CLK1_50`.

Se o top-level em VHDL usa exatamente os mesmos nomes de portas já atribuídos no projeto, o Quartus pode reaproveitar as configurações de pinos existentes, sem necessidade de refazer manualmente essas atribuições no Pin Planner.

## Licença

Este repositório usa licenciamento duplo:

- apostila, PDF, LaTeX e imagens: Creative Commons Attribution 4.0 International (CC BY 4.0);
- arquivos VHDL e arquivos do projeto Quartus: MIT.

Veja os detalhes em `LICENSE.md`.
