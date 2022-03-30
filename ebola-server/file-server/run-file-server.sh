echo "[STATIC FILE SERVER] Building image..."
docker build -t ebola-file-server .

echo "[STATIC FILE SERVER] Running the image..."
docker run -it --rm -p 3000:3000 ebola-file-server
