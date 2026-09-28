from fastapi import FastAPI

app = FastAPI(title="Decantix API")

@app.get("/")
def read_root():
    return {"status": "ok", "message": "Decantix API running successfully"}