# FolhaPonto
Script que gera a folha de ponto dos admins da Rede Linux

Eaee pessoal, esse script permite que a gente crie nossa folha de ponto sem ter muito trabalho (com quase nenhum, acredito). Para facillitar a nossa vida, eu vou mostrar como rodar ele. São dois comando por linha de comando sendo um obrigatório e um opcional.

$ ruby FolhaPonto.rb [jornada -- A] [feriados -- B]

A -- jornada -> esse argumento deve assumir como valor o nome do arquivo no qual vocês vão colocar os horários de vocês  (Obrigatório)

B --> feriado -> mesmo tipo de argumento que o A, porém o formato do arquivo é distinto (Opcional)

Como o script usa AWK, eu recomendo que vcs sigam o formato que eu usei. Caso queiram usar um formato mais cômodo para vocês, vão ter que fazer alguma mudanças nas versões pessoais.

Obs:
- Não caprichei muito nos comentários agora, mas posso dar uma melhorada depois. Fiquem a vontade para perguntar o que quiser.
- os arquivos referência podem ter o nome que quiserem

Arquivo A (arquivo jornada -- exemplo)
André Luiz Abdalla Silveira
seg 
ter
qua 10h-12h 14h-16h
qui
sex 14h-16h 

Arquivo B 
04 07
05 07
06 07
07 07
08 07

Nesse caso é só incluir datas de feriados e/ou seus recessos. O meu arquivo feriado foi criado com feriado fictício caso vcs desejem ver qual é o resultado
