# Pizzaria Pepperoni — Site Institucional

Site institucional da **Pizzaria Pepperoni** (Maringá-PR), com painel administrativo integrado ao Supabase para gestão de cardápio, promoções e informações de contato em tempo real.

## Stack

- **Astro 4** — Static Site Generator
- **Tailwind CSS 3** — Estilização com design tokens (light/dark mode)
- **GSAP + ScrollTrigger** — Animações de scroll
- **Lenis** — Smooth scroll
- **Supabase** — Banco de dados PostgreSQL + autenticação (painel admin)

## Páginas

| Rota | Descrição |
|------|-----------|
| `/` | Home — hero, stats, grid de pizzas, CTA WhatsApp |
| `/sobre` | História da pizzaria, valores, quote |
| `/cardapio` | Cardápio completo com 5 categorias (salgadas, doces, massas, porções, bebidas) |
| `/promocoes` | Promoções ativas e formas de pagamento |
| `/contato` | Informações de contato, mapa, formulário |
| `/admin` | Painel administrativo (requer login) |

## Painel Admin (`/admin`)

O admin conecta diretamente ao Supabase. Alterações feitas pelo admin aparecem instantaneamente para todos os visitantes — sem necessidade de redeploy.

### Funcionalidades
- **Cardápio** — Adicionar, editar e excluir itens (título, descrição, imagem, categoria)
- **Promoções** — CRUD completo com ícone Material Symbols
- **Contato** — Editar endereço, telefones, WhatsApp, e-mail, Instagram, horário
- **Exportar/Importar** — Backup dos dados em JSON

## Setup Local

```bash
# Instalar dependências
npm install

# Criar .env com as chaves do Supabase
cp .env.example .env
# Editar .env com PUBLIC_SUPABASE_URL e PUBLIC_SUPABASE_ANON_KEY

# Rodar em desenvolvimento
npm run dev
```

## Setup do Supabase

1. Criar projeto em [supabase.com](https://supabase.com)
2. Executar `supabase-setup.sql` no **SQL Editor** do dashboard
3. Criar usuário admin em **Authentication → Users → Add User**
4. Copiar **Project URL** e **anon key** de **Settings → API**

## Deploy na Vercel

1. Conectar o repositório na Vercel
2. Adicionar as variáveis de ambiente:
   - `PUBLIC_SUPABASE_URL`
   - `PUBLIC_SUPABASE_ANON_KEY`
3. Deploy automático a cada push

## Design System

Paleta baseada em 4 cores com suporte a light/dark mode:

| Cor | Hex | Uso |
|-----|-----|-----|
| Primary | `#DE3635` | CTAs, destaques, links ativos |
| Secondary | `#EDDE3C` | Acentos |
| Tertiary | `#FFFFFF` | Superfícies claras |
| Neutral | `#000000` | Texto, fundos escuros |

- **Tipografia:** Epilogue (headlines) + Plus Jakarta Sans (body)
- **Ícones:** Material Symbols Outlined
- **Estilo:** Brutalist editorial — sem bordas 1px, separação por shift de cor

## Estrutura

```
src/
├── components/    Nav.astro, Footer.astro
├── layouts/       Layout.astro, AdminLayout.astro
├── pages/         index, sobre, cardapio, promocoes, contato, admin
├── scripts/       supabase.ts, admin-store.ts
├── styles/        global.css (CSS variables light/dark)
public/
├── img/           SVGs placeholder por categoria
├── favicon.svg
```

---

Desenvolvido por [UAITY Software](https://github.com/UAITYSOFTWARE)
