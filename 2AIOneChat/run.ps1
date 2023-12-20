# Name of the Conda environment
$condaEnvName = "llm-experiments"

# Start the Flask API in a new PowerShell window
Start-Process -FilePath "powershell" -ArgumentList "-NoExit", "-Command & { conda activate '$condaEnvName'; python .\api\api.py }"

# Change directory to the front folder
cd .\front

# Run the React app
npm start
