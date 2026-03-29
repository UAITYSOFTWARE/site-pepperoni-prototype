-- ═══════════════════════════════════════════════════════════
--  Pizzaria Pepperoni — Supabase Setup
--  Execute este SQL no SQL Editor do Supabase Dashboard
-- ═══════════════════════════════════════════════════════════

-- 1. TABELAS

create table if not exists cardapio (
  id uuid default gen_random_uuid() primary key,
  titulo text not null,
  descricao text not null default '',
  imagem_url text not null default '',
  categoria text not null check (categoria in ('salgadas', 'doces', 'massas', 'porcoes', 'bebidas')),
  ordem int default 0,
  created_at timestamptz default now()
);

create table if not exists promocoes (
  id uuid default gen_random_uuid() primary key,
  titulo text not null,
  descricao text not null default '',
  icone text not null default 'sell',
  imagem_url text not null default '',
  created_at timestamptz default now()
);

create table if not exists contato (
  id uuid default gen_random_uuid() primary key,
  endereco text not null default '',
  bairro text not null default '',
  cidade text not null default '',
  estado text not null default '',
  telefone1 text not null default '',
  telefone2 text not null default '',
  whatsapp text not null default '',
  whatsapp_display text not null default '',
  email text not null default '',
  instagram text not null default '',
  instagram_handle text not null default '',
  horario text not null default '',
  dias text not null default '',
  updated_at timestamptz default now()
);

-- 2. RLS (Row Level Security)

alter table cardapio enable row level security;
alter table promocoes enable row level security;
alter table contato enable row level security;

-- Público pode LER tudo
create policy "Público pode ler cardápio" on cardapio for select using (true);
create policy "Público pode ler promoções" on promocoes for select using (true);
create policy "Público pode ler contato" on contato for select using (true);

-- Apenas usuários autenticados podem ESCREVER
create policy "Admin pode inserir cardápio" on cardapio for insert with check (auth.role() = 'authenticated');
create policy "Admin pode editar cardápio" on cardapio for update using (auth.role() = 'authenticated');
create policy "Admin pode deletar cardápio" on cardapio for delete using (auth.role() = 'authenticated');

create policy "Admin pode inserir promoções" on promocoes for insert with check (auth.role() = 'authenticated');
create policy "Admin pode editar promoções" on promocoes for update using (auth.role() = 'authenticated');
create policy "Admin pode deletar promoções" on promocoes for delete using (auth.role() = 'authenticated');

create policy "Admin pode inserir contato" on contato for insert with check (auth.role() = 'authenticated');
create policy "Admin pode editar contato" on contato for update using (auth.role() = 'authenticated');
create policy "Admin pode deletar contato" on contato for delete using (auth.role() = 'authenticated');


-- 3. DADOS INICIAIS — Contato

insert into contato (endereco, bairro, cidade, estado, telefone1, telefone2, whatsapp, whatsapp_display, email, instagram, instagram_handle, horario, dias)
values (
  'Av. Rio Branco, 56',
  'Zona 04',
  'Maringá',
  'Paraná',
  '(44) 3222-5951',
  '(44) 3031-5951',
  '5544991566299',
  '(44) 99156-6299',
  'financeiro01@pizzariapepperoni.com.br',
  'https://www.instagram.com/pizzariapepperonimga',
  '@pizzariapepperonimga',
  '18h30 às 22h30',
  'Todos os dias'
);


-- 4. DADOS INICIAIS — Promoções

insert into promocoes (titulo, descricao, icone, imagem_url) values
  ('Terça da Pizza', 'Todas as terças: crianças até 10 anos pagam meia no rodízio.', 'local_pizza', '/img/promo-pizza.svg'),
  ('Aniversariante', 'No mês do seu aniversário, o rodízio é por nossa conta. Traga seu RG.', 'cake', '/img/promo-pizza.svg'),
  ('Grupo de 10+', 'Grupos acima de 10 pessoas ganham desconto especial. Reserve com antecedência.', 'groups', '/img/mesa-pizza.svg'),
  ('Fidelidade', 'A cada 5 visitas com comprovante, ganhe 1 rodízio grátis para 2 pessoas.', 'loyalty', '/img/promo-pizza.svg');


-- 5. DADOS INICIAIS — Cardápio (Pizzas Salgadas)

insert into cardapio (titulo, descricao, imagem_url, categoria) values
  ('Pepperoni Clássica', 'Molho de Tomate, Mussarela de Búfala e Pepperoni Defumado Importado.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Alho e Óleo', 'Molho de Tomate, Mussarela, Alho e Óleo, Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Alho Poró com Ricota', 'Creme de Ricota, Alho Poró, Pimenta do Reino e Azeite Extra Virgem.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Atum', 'Molho de Tomate, Mussarela, Atum, Cebola Roxa e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Ávola', 'Molho de Tomate, Linguiça Apimentada, Mussarela, Mussarela de Búfala, Mel, Pimenta do Reino e Manjericão.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Bacalhau', 'Molho de Tomate, Mussarela, Bacalhau, Cebola, Tomate Cereja, Ovos, Azeitona Preta e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Bacon', 'Molho de Tomate, Mussarela, Bacon e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Bacon com Milho', 'Molho de Tomate, Mussarela, Bacon, Milho e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Baiana', 'Molho de Tomate, Mussarela, Charque, Carne ao Molho Apimentado e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Brócolis', 'Molho de Tomate, Mussarela, Brócolis, Bacon, Milho e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Burrata', 'Molho de Tomate, Mussarela, Mussarela de Búfala, Tomate Cereja, Burrata, Manjericão, Azeitona Preta e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Calabresa', 'Molho de Tomate, Mussarela, Calabresa Ceratti e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Calzone Baiana', 'Molho de Tomate, Mussarela, Charque, Carne ao Molho Apimentado, Ovos e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Calzone Frango Catupiry', 'Molho de Tomate, Mussarela, Frango, Catupiry e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Camarão', 'Molho de Tomate, Mussarela, Camarão, Creme de Nata e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Cinco Queijos', 'Molho de Tomate, Mussarela, Catupiry, Gorgonzola, Provolone, Cheddar e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Enrolado Grego', 'Geléia de Damasco, Tomate Seco, Azeitona, Bacon, Alho, Mussarela e Brócolis.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Escarola c/ Tomate Seco', 'Molho de Tomate, Mussarela, Escarola, Tomate Seco e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Filézinho', 'Molho de Tomate, Mussarela, Filézinho de Carne, Catupiry, Provolone e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Focaccine', 'Massa Recheada com Mussarela, Gorgonzola, Catupiry, Coberta com Mel e Gergelim.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Frango Caipira', 'Molho de Tomate, Mussarela, Frango Cremoso, Milho, Bacon e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Frango com Catupiry', 'Molho de Tomate, Mussarela, Frango Cremoso, Catupiry e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Lombaxi', 'Molho de Tomate, Mussarela, Lombo Ceratti, Abacaxi e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Lombo c/ Catupiry', 'Molho de Tomate, Mussarela, Lombo Ceratti, Catupiry e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Lombo c/ Geléia de Pimenta', 'Creme de Ricota, Lombo Ceratti, Pimenta do Reino, Alecrim e Geléia de Pimenta.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Marana', 'Molho de Tomate, Mussarela, Provolone, Gorgonzola, Presunto Parma Ceratti, Figo e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Marguerita', 'Molho de Tomate, Mussarela de Búfala, Manjericão, Parmesão Fresco e Azeite.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Marguerita Especial', 'Molho de Tomate, Mussarela de Búfala, Tomate Cereja, Molho Pesto de Manjericão e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Milho', 'Molho de Tomate, Mussarela, Milho e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Mista', 'Molho de Tomate, Mussarela, Presunto, Tomate e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Palmito', 'Molho de Tomate, Mussarela, Palmito, Azeitona, Catupiry e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Pepperoni', 'Molho de Tomate, Mussarela, Pepperoni Ceratti e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Portuguesa', 'Molho de Tomate, Mussarela, Presunto, Ervilha, Ovos, Azeitona Preta, Cebola Roxa e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Quatro Queijos', 'Molho de Tomate, Mussarela, Provolone, Catupiry, Gorgonzola e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Strogonoff de Carne', 'Molho de Tomate, Mussarela, Strogonoff de Carne, Batata Palha e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Tomate Seco', 'Molho de Tomate, Mussarela, Tomate Seco, Rúcula e Orégano.', '/img/pizza-placeholder.svg', 'salgadas'),
  ('Toscana', 'Molho de Tomate, Mussarela, Calabresa ao Molho, Cebola Roxa e Orégano.', '/img/pizza-placeholder.svg', 'salgadas');

-- Pizzas Doces
insert into cardapio (titulo, descricao, imagem_url, categoria) values
  ('Abacaxi', 'Mussarela, Abacaxi, Leite Condensado, Coco e Chocolate Branco.', '/img/doce-placeholder.svg', 'doces'),
  ('Banana com Canela', 'Mussarela, Banana, Leite Condensado e Canela em Pó.', '/img/doce-placeholder.svg', 'doces'),
  ('Banoffee', 'Mussarela, Doce de Leite, Banana e Suspiro.', '/img/doce-placeholder.svg', 'doces'),
  ('Beijinho', 'Mussarela, Chocolate Branco, Leite Condensado e Coco.', '/img/doce-placeholder.svg', 'doces'),
  ('Califórnia', 'Mussarela, Abacaxi, Pêssego, Figo, Cereja e Leite Condensado.', '/img/doce-placeholder.svg', 'doces'),
  ('Calzone Chocopiry', 'Mussarela, Morango e Raspas de Chocolate.', '/img/doce-placeholder.svg', 'doces'),
  ('Calzone Tropical', 'Mussarela, Abacaxi, Pêssego, Cereja, Morango, Chocolate Branco.', '/img/doce-placeholder.svg', 'doces'),
  ('Charge', 'Mussarela, Leite Condensado, Chocolate e Amendoim.', '/img/doce-placeholder.svg', 'doces'),
  ('Chocolate', 'Mussarela e Chocolate ao Leite ou Chocolate Branco.', '/img/doce-placeholder.svg', 'doces'),
  ('Confeti', 'Mussarela, Chocolate ao Leite e Confeti.', '/img/doce-placeholder.svg', 'doces'),
  ('Favo de Mel', 'Mussarela, Sorvete Favo de Mel e Doce de Leite.', '/img/doce-placeholder.svg', 'doces'),
  ('Ovomaltine', 'Mussarela, Creme de Ovomaltine e Chocolate ao Leite Callebaut.', '/img/doce-placeholder.svg', 'doces'),
  ('Prestígio', 'Mussarela, Coco, Leite Condensado e Chocolate.', '/img/doce-placeholder.svg', 'doces'),
  ('Sensação', 'Mussarela, Morango, Leite Condensado e Chocolate.', '/img/doce-placeholder.svg', 'doces');

-- Massas
insert into cardapio (titulo, descricao, imagem_url, categoria) values
  ('Conchiglione de Pepperoni', 'Massa conchiglione recheada com pepperoni.', '/img/massa-placeholder.svg', 'massas'),
  ('Lasanha Bolonhesa', 'Camadas de massa fresca, molho bolonhesa e bechamel gratinado.', '/img/massa-placeholder.svg', 'massas'),
  ('Lasanha Quatro Queijos', 'Camadas de massa com blend de quatro queijos gratinados.', '/img/massa-placeholder.svg', 'massas'),
  ('Nhoque Frito ao Molho Papaline', 'Nhoque frito crocante ao molho papaline cremoso.', '/img/massa-placeholder.svg', 'massas'),
  ('Pappardelle ao Molho Pesto', 'Massa pappardelle com molho pesto de manjericão fresco.', '/img/massa-placeholder.svg', 'massas'),
  ('Penne ao Molho Funghi', 'Penne com funghi seco rehidratado, creme de leite e parmesão.', '/img/massa-placeholder.svg', 'massas'),
  ('Rondelle de Presunto', 'Massa rondelle recheada com presunto.', '/img/massa-placeholder.svg', 'massas'),
  ('Sofiatelli de Frango c/ Catupiry', 'Sofiatelli recheado com frango e catupiry. Opção doce: Dois Amores.', '/img/massa-placeholder.svg', 'massas'),
  ('Spaghetti Alho e Óleo', 'Espaguete com alho dourado, azeite e pimenta.', '/img/massa-placeholder.svg', 'massas'),
  ('Spaghetti Carbonara', 'Espaguete ao molho carbonara com bacon e parmesão.', '/img/massa-placeholder.svg', 'massas'),
  ('Spaghetti Molho Italiano', 'Espaguete com molho italiano de tomates frescos e ervas.', '/img/massa-placeholder.svg', 'massas');

-- Porções
insert into cardapio (titulo, descricao, imagem_url, categoria) values
  ('Batata Frita', 'Porção de batatas fritas crocantes.', '/img/porcao-placeholder.svg', 'porcoes'),
  ('Frango Frito', 'Porção de frango frito empanado.', '/img/porcao-placeholder.svg', 'porcoes'),
  ('Polenta Frita', 'Porção de polenta frita crocante.', '/img/porcao-placeholder.svg', 'porcoes');

-- Bebidas
insert into cardapio (titulo, descricao, imagem_url, categoria) values
  ('Água Mineral', 'Água Mineral com e sem Gás 500ml.', '/img/bebida-placeholder.svg', 'bebidas'),
  ('Batidas', 'Morango, Vinho.', '/img/bebida-placeholder.svg', 'bebidas'),
  ('Caipirinha', 'Caipirinha de Pinga, Vodka Smirnoff.', '/img/bebida-placeholder.svg', 'bebidas'),
  ('Cervejas', 'Heineken 600ml, Heineken Long Neck 330ml, Original 600ml.', '/img/bebida-placeholder.svg', 'bebidas'),
  ('Refrigerantes', 'Coca-Cola, Guaraná Antarctica, Sukita, Soda Limonada, Schweppes Citrus, Água Tônica e H2O Limão. Opção Zero Açúcar.', '/img/bebida-placeholder.svg', 'bebidas'),
  ('Sucos', 'Laranja, Abacaxi com Hortelã, Abacaxi, Acerola, Maracujá, Uva, Morango e Morango com Leite. Opção com água ou leite.', '/img/bebida-placeholder.svg', 'bebidas');
