# Cade Buffet?

## Descrição do Projeto
Ao fazer algum tipo de confraternização em que não desejamos lidar com as diversas necessidades envolvidas, como alimentação, espaço, organização etc., é necessário contratar quem o faça. Buffets são empresas de pequeno até grande porte que organizam festas completas ou oferecem produtos avulsos como alimentos, bebidas ou serviços como garçons e animadores infantis.

Mas, quem precisa organizar festas, casamentos ou eventos corporativos costuma ter dificuldade de encontrar o buffet certo para seu evento. É neste contexto que convocamos você para fazer o projeto Cadê Buffet?.

Donos de buffets vão poder cadastrar suas empresas, listar os serviços oferecidos, cadastrar cardápios e seus respectivos valores e receber contatos de pessoas interessadas em realizar uma festa. Usuários regulares vão poder buscar buffets de acordo com o tipo de evento, com a quantidade de convidados e com a localização. Será possível também fazer um pedido.

# API

A API do "Cade Buffet?" dispõe de cinco end-points que atendem solicitaçõesd do tipo <code>get</code> na porta 'http://localhost:4000'. Os endpoints são:

## GET /api/v1/buffets
Retorna uma lista de todos os buffets ou uma lista vazia caso não haja Buffets cadastrados.

## GET /api/v1/buffets/:id
Retorna os detalhes de um buffet específico, se o buffet não for encontrado retorna um status 404.

## GET /api/v1/buffets/:query
Retorna uma lista de buffets que correspondem à consulta fornecida, se nenhum buffet corresponder à consulta, retorna um status 404.

## GET /api/v1/buffets/:id/events
Retorna uma lista de todos os eventos para um buffet específico, se o buffet não for encontrado, retorna um status 404.

## GET /api/v1/buffets/:buffet_id/:event_id/:event_date/:total_guests
Verifica a disponibilidade de um evento específico para um buffet específico em uma data específica com o número total de convidados, se a data do evento estiver no passado ou o número total de convidados não estiver dentro dos limites do evento, retorna um status 412 com a mensagem de erro correspondente; se houver um pedido no mesmo dia, retorna um status 200 com a mensagem de erro "Data indisponível". Caso contrário, retorna um status 200 com o preço do pedido.

# Como rodar o projeto

1. No terminal, clone o projeto:

```bash
git clone https://github.com/3runoAM/Cade-Buffet
```
2. Navegue até o diretório do projeto:

```bash
cd Cade-Buffet
```

3. Instale as dependências:

```bash
bundle install
```

4. Crie o banco de dados:
```bash
rails db:create
```

5. Execute as migrations:
```bash
rails db:migrate
```
6. Execute o arquivo seeds.rb para popular o banco com instâncias de exemplo:
```bash
rails db:seeds
```

Depois disso, você deve ser capaz de iniciar o servidor Rails com <code>rails s</code> e acessar o aplicativo em <code>localhost:3000</code>.

