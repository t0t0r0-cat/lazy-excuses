# Lazy Excuses

A small Python tool that generates clever, concise excuses for any situation. Perfect for when you need a quick way to explain why you can’t attend a meeting, complete a task, or any other dilemma—without the hassle of thinking one up yourself.  

Built with [Rich](https://github.com/Textualize/rich) for colorful terminal output and [Ollama](https://ollama.com/) for AI-powered excuse generation.

---

## Features

- Generates short, witty excuses based on your input.
- Beautiful, color-coded terminal output.
- Works on Linux, macOS, and Windows (via Python).  

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/t0t0r0-cat/lazy-excuses.git
cd lazy-excuses
```
### 2. Create Venv
```bash
python -m venv venv
```
If you use bash:
```bash
source venv/bin/activate
```
Fish:
```fish
source venv/bin/activate.fish
```
### 3. Update pip
```bash
pip install --upgrade pip
```
### 4. Install dependincies
```bash
pip install rich ollama
```
### 5. Create command

```bash
cd /.local/bin
nano lazy_excuse
```
```nano
#!/usr/bin/env bash
source "/home/YOUR-USER-HERE/.venvs/lazyexcuses/bin/activate"
python "$HOME/lazy-excuses/lazyExcuses.py" "$@"
```
### 6. Verify the installation
```bash
lazy_excuse
```
