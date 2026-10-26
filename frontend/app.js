async function loadCatalog() {
    try {
        const response = await fetch('http://localhost:8000/api/catalog');
        const result = await response.json();

        if (result.status === "success") {
            const container = document.getElementById('catalog-container');
            
            result.data.forEach(item => {
                const card = document.createElement('div');
                card.className = 'fragrance-card';
                
                card.innerHTML = `
                    <div class="brand">${item.brand}</div>
                    <div class="name">${item.name} (${item.concentration})</div>
                    <div class="details">Decant de ${item.size_ml} ml</div>
                    <div class="price">${item.price} €</div>
                `;
                
                container.appendChild(card);
            });
        }
    } catch (error) {
        console.error("Error al conectar con FastAPI:", error);
        document.getElementById('catalog-container').innerHTML = 
            '<p style="color: red;">Error: No se pudo cargar el catálogo. ¿Está Uvicorn encendido?</p>';
    }
}

loadCatalog();