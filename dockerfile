FROM python:3.10-slim

# Install necessary build tools
RUN apt-get update && apt-get install -y build-essential

# Install chromadb and pysqlite3-binary
RUN pip install --no-cache-dir chromadb pysqlite3-binary

# Patch sqlite3 with pysqlite3 globally
ENV PYTHONPATH=/patch_sqlite
RUN mkdir -p /patch_sqlite && \
    echo 'import pysqlite3\nimport sys\nsys.modules["sqlite3"] = pysqlite3' > /patch_sqlite/sitecustomize.py

# Expose Chroma HTTP API port
EXPOSE 8000

# Start ChromaDB in HTTP persistent mode
CMD ["chroma", "run", "--host", "0.0.0.0", "--port", "8000", "--path", "/chroma/chroma"]
