import { supabase } from './supabase';

// ═══════════════════════════════════════
//  TYPES
// ═══════════════════════════════════════

export interface MenuItem {
  id?: string;
  titulo: string;
  descricao: string;
  imagem_url: string;
  categoria: 'salgadas' | 'doces' | 'massas' | 'porcoes' | 'bebidas';
  ordem?: number;
}

export interface Promocao {
  id?: string;
  titulo: string;
  descricao: string;
  icone: string;
  imagem_url: string;
}

export interface ContatoInfo {
  id?: string;
  endereco: string;
  bairro: string;
  cidade: string;
  estado: string;
  telefone1: string;
  telefone2: string;
  whatsapp: string;
  whatsapp_display: string;
  email: string;
  instagram: string;
  instagram_handle: string;
  horario: string;
  dias: string;
}

// ═══════════════════════════════════════
//  AUTH (Supabase Auth)
// ═══════════════════════════════════════

export async function signIn(email: string, password: string) {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  return { user: data?.user, error };
}

export async function signOut() {
  await supabase.auth.signOut();
}

export async function getSession() {
  const { data } = await supabase.auth.getSession();
  return data.session;
}

// ═══════════════════════════════════════
//  CARDÁPIO
// ═══════════════════════════════════════

export async function getCardapio(): Promise<MenuItem[]> {
  const { data, error } = await supabase
    .from('cardapio')
    .select('*')
    .order('categoria')
    .order('titulo');
  if (error) { console.error('getCardapio:', error); return []; }
  return data ?? [];
}

export async function addCardapioItem(item: Omit<MenuItem, 'id'>): Promise<boolean> {
  const { error } = await supabase.from('cardapio').insert(item);
  if (error) { console.error('addCardapioItem:', error); return false; }
  return true;
}

export async function updateCardapioItem(id: string, item: Partial<MenuItem>): Promise<boolean> {
  const { error } = await supabase.from('cardapio').update(item).eq('id', id);
  if (error) { console.error('updateCardapioItem:', error); return false; }
  return true;
}

export async function deleteCardapioItem(id: string): Promise<boolean> {
  const { error } = await supabase.from('cardapio').delete().eq('id', id);
  if (error) { console.error('deleteCardapioItem:', error); return false; }
  return true;
}

// ═══════════════════════════════════════
//  PROMOÇÕES
// ═══════════════════════════════════════

export async function getPromocoes(): Promise<Promocao[]> {
  const { data, error } = await supabase
    .from('promocoes')
    .select('*')
    .order('titulo');
  if (error) { console.error('getPromocoes:', error); return []; }
  return data ?? [];
}

export async function addPromocao(promo: Omit<Promocao, 'id'>): Promise<boolean> {
  const { error } = await supabase.from('promocoes').insert(promo);
  if (error) { console.error('addPromocao:', error); return false; }
  return true;
}

export async function updatePromocao(id: string, promo: Partial<Promocao>): Promise<boolean> {
  const { error } = await supabase.from('promocoes').update(promo).eq('id', id);
  if (error) { console.error('updatePromocao:', error); return false; }
  return true;
}

export async function deletePromocao(id: string): Promise<boolean> {
  const { error } = await supabase.from('promocoes').delete().eq('id', id);
  if (error) { console.error('deletePromocao:', error); return false; }
  return true;
}

// ═══════════════════════════════════════
//  CONTATO
// ═══════════════════════════════════════

export async function getContato(): Promise<ContatoInfo | null> {
  const { data, error } = await supabase
    .from('contato')
    .select('*')
    .limit(1)
    .single();
  if (error) { console.error('getContato:', error); return null; }
  return data;
}

export async function upsertContato(info: Omit<ContatoInfo, 'id'>): Promise<boolean> {
  // Get existing record
  const { data: existing } = await supabase.from('contato').select('id').limit(1).single();
  let error;
  if (existing?.id) {
    ({ error } = await supabase.from('contato').update(info).eq('id', existing.id));
  } else {
    ({ error } = await supabase.from('contato').insert(info));
  }
  if (error) { console.error('upsertContato:', error); return false; }
  return true;
}

// ═══════════════════════════════════════
//  EXPORT / IMPORT
// ═══════════════════════════════════════

export async function exportAll(): Promise<string> {
  const [cardapio, promocoes, contato] = await Promise.all([
    getCardapio(),
    getPromocoes(),
    getContato(),
  ]);
  return JSON.stringify({ cardapio, promocoes, contato }, null, 2);
}

export async function importAll(json: string): Promise<void> {
  const data = JSON.parse(json);

  if (data.cardapio?.length) {
    // Clear existing and insert new
    await supabase.from('cardapio').delete().neq('id', '00000000-0000-0000-0000-000000000000');
    await supabase.from('cardapio').insert(
      data.cardapio.map((item: any) => ({
        titulo: item.titulo,
        descricao: item.descricao,
        imagem_url: item.imagem_url || item.imagemUrl || '',
        categoria: item.categoria,
      }))
    );
  }

  if (data.promocoes?.length) {
    await supabase.from('promocoes').delete().neq('id', '00000000-0000-0000-0000-000000000000');
    await supabase.from('promocoes').insert(
      data.promocoes.map((p: any) => ({
        titulo: p.titulo,
        descricao: p.descricao,
        icone: p.icone,
        imagem_url: p.imagem_url || p.imagemUrl || '',
      }))
    );
  }

  if (data.contato) {
    const c = data.contato;
    await upsertContato({
      endereco: c.endereco,
      bairro: c.bairro,
      cidade: c.cidade,
      estado: c.estado,
      telefone1: c.telefone1,
      telefone2: c.telefone2,
      whatsapp: c.whatsapp,
      whatsapp_display: c.whatsapp_display || c.whatsappDisplay || '',
      email: c.email,
      instagram: c.instagram,
      instagram_handle: c.instagram_handle || c.instagramHandle || '',
      horario: c.horario,
      dias: c.dias,
    });
  }
}
