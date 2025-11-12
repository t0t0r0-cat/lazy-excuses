import subprocess
import sys

# --- Auto-install missing dependencies ---
def ensure_package(package):
    try:
        __import__(package)
    except ModuleNotFoundError:
        print(f"[bold yellow]🔧 '{package}' not found. Installing it now...[/bold yellow]")
        subprocess.check_call(
            [sys.executable, "-m", "pip", "install", package],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        print(f"[bold green]✅ '{package}' installed successfully![/bold green]")

# Ensure required packages
ensure_package("rich")
ensure_package("ollama")

# --- Imports after ensuring packages ---
from rich import print
import ollama
import json

# --- Main Program ---
print("[bold magenta]what do you need an excuse for...[/bold magenta] \n [italic green]Example: not going to a zoom meeting[/italic green]")
problem = input("> ")

aiprompt = f"make an excuse for {problem} in a short concise sentence"

try:
    response = ollama.generate(model="qwen2.5:0.5b", prompt=aiprompt)
    filtered_excuse = response["response"]
    print(f"[bold orange]{filtered_excuse}[/bold orange]")
except Exception as e:
    print(f"[bold red]❌ Error:[/bold red] {e}")
