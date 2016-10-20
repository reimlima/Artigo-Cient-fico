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

Abaixo um exemplo de como os dados são processados para serem inseridos no Hadoop:

```sh
$ cat 201608/rio2016.20160805.txt | perl tweetMapper.pl | perl tweetDateTimeReducer.pl
05/08/2016 01:32 35
05/08/2016 02:13 17
05/08/2016 02:09 45
05/08/2016 01:33 24
05/08/2016 01:40 39
05/08/2016 03:05 26
05/08/2016 01:22 33
05/08/2016 01:29 41
05/08/2016 02:57 42
05/08/2016 02:54 33

$ cat 201608/rio2016.20160805.txt | perl tweetMapper.pl | perl tweetAccountReducer.pl
 crvgester 1
 JulioInesperado 1
 Mecao1915 1
 edmilsonpapo10 1
 adelaidejulio1 1
 anamararojas1 1
 carlosmataa15 1
 gtcrf_rdb 1
 remetropolitano 8
 venusaquario 3

$ cat 201608/rio2016.20160805.txt | perl tweetMapper.pl | perl tweetTextReducer.pl
 AMANHÃ: Às 20h, cerimônia de abertura dos Jogos Olímpicos #Rio2016 .  1
 RT @Na_Moita: Porto Maravilha - grafite Etnias de Eduardo Kobra. 1
 RT @MarcioGreporter: Torre Skytree, no centro de Tóquio, nas cores do Brasil! #Rio2016 https://t.co/nKwGu2Doxe 3
 Por dentro da Casa Brasil nas Olimpíadas Rio 2016   1
 nigéria e japão tá parecendo partida de handebol... 5 a 3 nigéria.. #Rio2016 1
 Orgulho define &lt;3 #WatchRiseOnVEVO #Rio2016 https://t.co/QGDLxZbXz8 1
 @MichelTemer @Brasil2016 @Rio2016 muito dinheiro jogado fora. Daria para ajudar os pobres de Alagoas. Seria bem melhor para vc Michel 1
 PETROBRAS - Impeachment ou Oportunidade de "Privatizar" o Pré-Sal https://t.co/9XObyC69Sp #Rio2016 Senado #ForaTemer https://t.co/DO8wLilxwq 1
 Menos de 12 minutos de Nigéria x Japão e o jogo já está melhor que o do Brasil. #Rio2016 1
 tinha um oráculo no meio do caminho ✨ #rio2016 @ Rua Marquês de… https://t.co/r1OrjRAXAt 1

$ cat 201608/rio2016.20160805.txt | perl tweetMapper.pl | perl tweetWordCountReducer.pl
Amada 3
erro 2
CATS 6
alguém 2
https://t.co/ThTmh0nDzJ 1
ciências 1
@OdeCarvalho 3
oferece 17
credencial 2
```

### Armazenamento e Indexação

Os dados que foram extraídos, foram armazenados e submetidos ao processo de MapReduce no Hadoop, e finalmente indexados no ElasticSearch usando o script *mrflow* escrito em Shell Script.

[TwitterSearch]: <https://github.com/ckoepp/TwitterSearch>
[Hadoop Streaming with Perl Script]: <https://hadoopavenue.wordpress.com/2014/10/02/hadoop-streaming-with-perl-script/>
