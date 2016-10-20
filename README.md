# Scripts e dados usados para elaboração do Artigo Científico entregue como trabalho final da Pós Graduação em Gestão de TI do IBTA

Neste repositório econtram-se os dados que foram extraídos para a pesquisa e os scripts que foram usados para extração e processamento dos dados.

### Dependências

* Possuir credenciais de Desenvolvedor na APi do Twitter
* Ter um servidor disponível com Hadoop, Elasticsearch e Kibana instalado

### Extração

A extração foi feita de forma agendada e automárica utilizando o script *twitterSearch.sh* que rodava todos os dias as 00:10hrs através do cron:
```sh
10 00 * * * root bash twitterSearch.sh
```
O propósito deste script é chamar outro script, escrito em Python de nome *twitterSearch.py*  para se conectar na API do Twitter e extrair os dados daquele dia e armazenar nos formatos txt (chave = valor), csv, e json.

O Script python foi um *fork* do projeto original [TwitterSearch] desenvolvido por Christian Koepp, acesse este projeto para mais informações de como instalar as dependências do script.

### Processamento

O formato de arquivo que foi usado para o processamento foi o txt, por facilitar a implementação dos scripts de MapReduce.

Para o processamento, foram criados 4 scripts escritos em Perl, abaixo segue a explicação de cada um deles:

* tweetMapper.pl - Responsável por Mapear todos os Campos
* tweetAccountReducer.pl - Responsável por contar a quantidade de vezes cada perfíl de usuário aparece nos dados
* tweetTextReducer.pl - Responsável por contar a quantidade de vezes cada texto aparece nos dados
* tweetWordCountReducer.pl - Responsável por contar a quantidade de vezes cada palavra aparece nos dados

A lógica destes scripts foi desenvolvida com base no artigo *[Hadoop Streaming with Perl Script]*.

### Armazenamento e Indexação

Os dados que foram extraídos, foram armazenados e submetidos ao processo de MapReduce no Hadoop, e finalmente indexados no ElasticSearch usando o script *mrflow* escrito em Shell Script.

[TwitterSearch]: <https://github.com/ckoepp/TwitterSearch>
[Hadoop Streaming with Perl Script]: <https://hadoopavenue.wordpress.com/2014/10/02/hadoop-streaming-with-perl-script/>
