# Cade Buffet?

## Descrição do Projeto
Ao fazer algum tipo de confraternização em que não desejamos lidar com as diversas necessidades envolvidas, como alimentação, espaço, organização etc., é necessário contratar quem o faça. Buffets são empresas de pequeno até grande porte que organizam festas completas ou oferecem produtos avulsos como alimentos, bebidas ou serviços como garçons e animadores infantis.

Mas, quem precisa organizar festas, casamentos ou eventos corporativos costuma ter dificuldade de encontrar o buffet certo para seu evento. É neste contexto que convocamos você para fazer o projeto Cadê Buffet?.

Donos de buffets vão poder cadastrar suas empresas, listar os serviços oferecidos, cadastrar cardápios e seus respectivos valores e receber contatos de pessoas interessadas em realizar uma festa. Usuários regulares vão poder buscar buffets de acordo com o tipo de evento, com a quantidade de convidados e com a localização. Será possível também fazer um pedido.

# Cade Buffet? API

A API do "Cade Buffet?" dispõe de cinco endpoints que atendem solicitações do tipo <code>get</code> na porta '4000'. Os endpoints são:

### GET /api/v1/buffets
Retorna um array de todos os buffets ou um json vazio caso não haja Buffets cadastrados.
Exemplo de response 200:

```json
[
  {
    "id": 1,
    "user_id": 1,
    "brand_name": "Buffet Estrela do Mar",
    "company_name": "Estrela do Mar Ltda",
    "crn": "28.824.990/0001-00",
    "phone": "333-333-3333",
    "email": "estreladomar@example.com",
    "description": "O Buffet Estrela do Mar oferece uma experiência culinária inesquecível com uma variedade de pratos deliciosos."
  },
  {
    "id": 2,
    "user_id": 2,
    "brand_name": "Buffet Lua Cheia",
    "company_name": "Lua Cheia Ltda",
    "crn": "82.638.014/0001-08",
    "phone": "444-444-4444",
    "email": "luacheia@example.com",
    "description": "O Buffet Lua Cheia oferece uma experiência culinária única com uma variedade de pratos saborosos."
  }
]
```

### GET /api/v1/buffets/:id
Retorna os detalhes de um buffet específico, dado o seu id, em foramto json. Caso o buffet não seja encontrado retorna um json vazio.
Exemplo de response 200:

```json
{
  "id": 2,
  "user_id": 2,
  "brand_name": "Buffet Lua Cheia",
  "phone": "444-444-4444",
  "email": "luacheia@example.com",
  "description": "O Buffet Lua Cheia oferece uma experiência culinária única com uma variedade de pratos saborosos.",
  "address": {
    "id": 2,
    "street_name": "Rua das Orquídeas",
    "neighborhood": "Jardim",
    "house_or_lot_number": "456",
    "state": "Paraíba",
    "city": "Patos",
    "zip": "58700-000",
    "buffet_id": 2
  }
}
```

### GET /api/v1/buffets/search/:query
Retorna um array de buffets aos quais o nome fantasia contém a string fornecida na busca, se nenhum buffet corresponder à consulta retorna um json vazio.
Exemplo de response onde a query foi a letra "r":

```json
[
  {
    "id": 1,
    "user_id": 1,
    "brand_name": "Buffet Estrela do Mar",
    "company_name": "Estrela do Mar Ltda",
    "crn": "28.824.990/0001-00",
    "phone": "333-333-3333",
    "email": "estreladomar@example.com",
    "description": "O Buffet Estrela do Mar oferece uma experiência culinária inesquecível com uma variedade de pratos deliciosos."
  },
  {
    "id": 4,
    "user_id": 4,
    "brand_name": "Buffet Terra Verde",
    "company_name": "Terra Verde Ltda",
    "crn": "54.249.061/0001-16",
    "phone": "666-666-6666",
    "email": "terraverde@example.com",
    "description": "O Buffet Terra Verde oferece uma experiência culinária saudável com uma variedade de pratos orgânicos."
  }
]
```

### GET /api/v1/buffets/:id/events
Retorna um array de todos os eventos e seus detalhes cadastrados em um buffet específico, dado o seu id, se o buffet não for encontrado retorna um json vazio; se não houver eventos cvadastrados retorna um array vazio.
Exemplo de response 200:

```json
[
  {
    "id": 1,
    "name": "Casamento na Praia",
    "description": "Um evento maravilhoso à beira-mar com decoração temática e menu personalizado.",
    "min_guests": 50,
    "max_guests": 200,
    "standard_duration": 600,
    "menu": "Frutos do Mar",
    "offsite_event": true,
    "offers_alcohol": true,
    "offers_decoration": true,
    "offers_valet_parking": true,
    "buffet_id": 1,
    "event_prices": [
      {
        "id": 1,
        "standard_price": 5000,
        "extra_guest_price": 100,
        "extra_hour_price": 200,
        "day_type": "weekday",
        "event_id": 1
      },
      {
        "id": 2,
        "standard_price": 7000,
        "extra_guest_price": 150,
        "extra_hour_price": 300,
        "day_type": "weekend",
        "event_id": 1
      }
    ]
  }
]
```

### GET /api/v1/buffets/:buffet_id/:event_id/:event_date/:total_guests
Verifica a disponibilidade de um evento, em um buffet específico, em uma data específica com um número de convidados.
Caso a data do evento esteja no passado, seja inválida ou o número total de convidados não estiver dentro dos limites do evento, retorna um json contendo um array com os erros correspondentes, o endpoint aceita datas nos formatos "YYYY-mm-dd" e "dd-mm-YYYY"; caso haja um evento confirmado para a mesam data retorna um json com a mensagem "Data indisponível"; com todas as informações corretas e a data disponível, retorna um json contendo com o preço do evento.

Exemplos:
1. Data no passado  e número de convidados excedo o número máximo
```json
{
  "error": [
    "Data do evento não pode estar no passado",
    "Número de convidados deve estar entre 1 e 200"
  ]
}
```

2. Data indisponível
```json
{
  "error": "Data indisponível"
}
```

3. Data disponível:
```json
{
  "price": 29500
}
```

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

Depois disso, você poderá iniciar o servidor Rails com <code>rails s</code> e acessar o aplicativo em <code>localhost:3000</code>.