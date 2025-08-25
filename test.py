import os
from supabase import create_client, Client
from supabase.client import ClientOptions

url: str = "https://jkkoibvrkmvyibvqrixl.supabase.co"

key: str = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impra29pYnZya212eWlidnFyaXhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwNTYxODEsImV4cCI6MjA2MDYzMjE4MX0.tJqLPjvOaiPIcqwB6NdulbZfN3OsNRs2BSVct8MFkzI"
supabase: Client = create_client(
    url, 
    key,
    options=ClientOptions(
        postgrest_client_timeout=10,
        storage_client_timeout=10,
        schema="public",
    )
)

print("Connected to supabase")

with open("result.jpg", "rb") as f:
    response = (
        supabase.storage\
        .from_("images")\
        .upload(
            file=f,
            path="result/result.jpg"
        )
    )
    
    response = (
        supabase.storage
            .from_("images")
            .get_public_url(f"result/{f}")
        )
