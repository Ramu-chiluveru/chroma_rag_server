FROM python:3.10-slim

# Install ChromaDB
RUN pip install chromadb

# Expose the HTTP API port
EXPOSE 8000

# Run ChromaDB in HTTP + persistent mode
CMD ["chroma", "run", "--host", "0.0.0.0", "--port", "8000", "--path", "/chroma/chroma"]
