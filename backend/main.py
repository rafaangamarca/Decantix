from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from backend.database import get_db_connection

app = FastAPI(title="Decantix API")

# Configuración CORS para que el navegador no bloquee los datos
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite peticiones desde cualquier HTML local
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"status": "ok", "message": "Decantix API running successfully"}

@app.get("/api/catalog")
def get_catalog():
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Database connection failed")
    
    try:
        # dictionary=True devuelve los resultados directamente en formato JSON
        cursor = conn.cursor(dictionary=True) 
        
        query = """
            SELECT f.id, f.brand, f.name, f.concentration, dp.size_ml, dp.price 
            FROM fragrances f
            JOIN decant_prices dp ON f.id = dp.fragrance_id
        """
        cursor.execute(query)
        catalog = cursor.fetchall()
        return {"status": "success", "data": catalog}
    
    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()