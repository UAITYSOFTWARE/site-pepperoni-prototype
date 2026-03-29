import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('[Supabase] PUBLIC_SUPABASE_URL ou PUBLIC_SUPABASE_ANON_KEY não configurados.');
}

export const supabase = createClient(supabaseUrl || '', supabaseAnonKey || '');
