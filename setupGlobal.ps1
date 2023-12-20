$filePath = "./models/llama-2-7b-chat.Q5_K_M.gguf"
$downloadUri = "https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGUF/resolve/main/llama-2-7b-chat.Q5_K_M.gguf"

# Check if the file already exists
if (-not (Test-Path $filePath)) {
    # File does not exist, download it
    Invoke-WebRequest -Uri $downloadUri -OutFile $filePath
    Write-Host "File downloaded successfully."
} else {
    Write-Host "File already exists. No need to download."
}

# Name of the Conda environment
$condaEnvName = "llm-experiments"

# Check if the Conda environment already exists
if ((conda info --envs | Select-String -Pattern $condaEnvName) -eq $null) {
    # Environment does not exist, create it
    conda create --name $condaEnvName python=3.11 -y
    Write-Host "Conda environment '$condaEnvName' created successfully."
} else {
    # Environment already exists, ask the user if they want to recreate it
    $response = Read-Host "Conda environment '$condaEnvName' already exists. Do you want to recreate it? (yes/no)"

    if ($response -eq "yes") {
        # Delete the existing environment
        conda deactivate  # deactivate the environment if it's currently active
        conda env remove --name $condaEnvName -y
        Write-Host "Conda environment '$condaEnvName' deleted successfully."

        # Create a new environment
        conda create --name $condaEnvName python=3.11 -y
        Write-Host "Conda environment '$condaEnvName' created successfully."
    } else {
        Write-Host "No changes were made to the existing environment."
    }
}

# Activate the Conda environment
conda activate $condaEnvName

# Install the required modules from requirements.txt in the api folder
pip install -r .\requirements.txt

