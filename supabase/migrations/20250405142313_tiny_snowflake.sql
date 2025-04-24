/*
  # Create profiles table and storage
  
  1. New Tables
    - profiles
      - id (uuid, references auth.users)
      - full_name (text)
      - username (text, unique)
      - contact_number (text)
      - gender (text)
      - date_of_birth (date)
      - address (text)
      - avatar_url (text)
      - created_at (timestamptz)
      - updated_at (timestamptz)
  
  2. Storage
    - Create bucket for profile pictures
  
  3. Security
    - Enable RLS
    - Add policies for profile access
*/

-- Create profiles table
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID REFERENCES auth.users(id) PRIMARY KEY,
    full_name TEXT,
    username TEXT UNIQUE,
    contact_number TEXT,
    gender TEXT,
    date_of_birth DATE,
    address TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own profile"
    ON public.profiles
    FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
    ON public.profiles
    FOR UPDATE
    USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile"
    ON public.profiles
    FOR INSERT
    WITH CHECK (auth.uid() = id);

-- Create storage bucket for avatars
INSERT INTO storage.buckets (id, name)
VALUES ('avatars', 'avatars')
ON CONFLICT DO NOTHING;

-- Enable RLS for storage
CREATE POLICY "Avatar images are publicly accessible"
    ON storage.objects
    FOR SELECT
    USING (bucket_id = 'avatars');

CREATE POLICY "Users can upload their own avatar"
    ON storage.objects
    FOR INSERT
    WITH CHECK (
        bucket_id = 'avatars'
        AND auth.uid()::text = (storage.foldername(name))[1]
    );