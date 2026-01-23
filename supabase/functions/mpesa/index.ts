import { serve } from 'https://deno.land/std/http/server.ts';

serve(async (req) => {
  const { phone, amount } = await req.json();

  // Call Daraja API here
  // Save payment record to Supabase

  return new Response(
    JSON.stringify({ success: true }),
    { headers: { 'Content-Type': 'application/json' } }
  );
});
