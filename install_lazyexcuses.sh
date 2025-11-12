#!/usr/bin/env bash
set -e

echo "🚀 LazyExcuses Installer (for Linux)"
echo "==================================="

# Detect shell
if [[ "$SHELL" == *"fish"* ]]; then
    ACTIVATE_PATH="$HOME/.venvs/lazyexcuses/bin/activate.fish"
    SHELL_TYPE="fish"
else
    ACTIVATE_PATH="$HOME/.venvs/lazyexcuses/bin/activate"
    SHELL_TYPE="bash/zsh"
fi

# Step 1: Ensure Python and venv exist
if ! command -v python &>/dev/null; then
    echo "❌ Python not found. Please install Python first."
    exit 1
fi

echo "📦 Creating Python virtual environment..."
python -m venv "$HOME/.venvs/lazyexcuses"

# Step 2: Activate venv and install deps
echo "📚 Installing dependencies (rich, ollama)..."
if [[ "$SHELL_TYPE" == "fish" ]]; then
    source "$ACTIVATE_PATH"
else
    # shellcheck disable=SC1090
    source "$ACTIVATE_PATH"
fi

pip install --upgrade pip >/dev/null
pip install rich ollama >/dev/null

# Step 3: Verify Ollama is installed
if ! command -v ollama &>/dev/null; then
    echo "⚠️  Ollama CLI not found. Installing..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# Step 4: Check if Ollama server is running
if ! curl -s http://127.0.0.1:11434/api/version >/dev/null; then
    echo "🟡 Starting Ollama server in background..."
    nohup ollama serve >/dev/null 2>&1 &
    sleep 2
fi

# Step 5: Create a helper command
echo "⚙️  Creating helper command 'run_excuse'..."
cat <<EOF >"$HOME/.local/bin/run_excuse"
#!/usr/bin/env bash
source "$ACTIVATE_PATH"
python "\$HOME/lazyExcuses.py" "\$@"
EOF

chmod +x "$HOME/.local/bin/run_excuse"

# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$HOME/.bashrc"
    echo "✅ Added ~/.local/bin to PATH (restart shell to apply)."
fi

echo ""
echo "✅ Installation complete!"
echo "--------------------------------"
echo "To run LazyExcuses, just type:"
echo "  run_excuse"
echo ""
echo "Your Python venv: ~/.venvs/lazyexcuses"
echo "Your script: ~/lazyExcuses.py"
