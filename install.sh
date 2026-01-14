#!/bin/bash
# OpenCode Team Setup - Auto Install Script

set -e

echo "=== OpenCode Team Setup ==="
echo ""

# Check if opencode is installed
echo "[1/7] Checking OpenCode installation..."
if command -v opencode &> /dev/null; then
    echo "✓ OpenCode already installed: $(opencode --version 2>/dev/null || echo 'version unknown')"
else
    echo "Installing OpenCode..."
    curl -fsSL https://opencode.ai/install | bash
    echo "✓ OpenCode installed"
fi

# Create config directory
echo "[2/7] Creating config directory..."
mkdir -p ~/.config/opencode

# Install LSP servers
echo "[3/7] Installing LSP servers..."
npm install -g typescript-language-server typescript pyright 2>/dev/null || echo "Warning: npm install failed, skipping LSP"

# Remove old opencode.json to avoid conflicts
echo "[4/7] Cleaning up old configs..."
rm -f ~/.config/opencode/opencode.json

# Write opencode.jsonc
echo "[5/7] Writing opencode.jsonc..."
cat > ~/.config/opencode/opencode.jsonc << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "model": "openai/gpt-5.2",
  "small_model": "google/antigravity-gemini-3-flash",
  "plugin": [
    "oh-my-opencode",
    "opencode-antigravity-auth@1.2.8",
    "opencode-openai-codex-auth",
    "@franlol/opencode-md-table-formatter@0.0.3"
  ],
  "keybinds": {
    "input_paste": "none"
  },
  "provider": {
    "google": {
      "name": "Google",
      "models": {
        "antigravity-gemini-3-pro": {
          "name": "Gemini 3 Pro (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingLevel": "low" },
            "high": { "thinkingLevel": "high" }
          }
        },
        "antigravity-gemini-3-pro-high": {
          "name": "Gemini 3 Pro High (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-gemini-3-pro-low": {
          "name": "Gemini 3 Pro Low (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-gemini-3-flash": {
          "name": "Gemini 3 Flash (Antigravity)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "minimal": { "thinkingLevel": "minimal" },
            "low": { "thinkingLevel": "low" },
            "medium": { "thinkingLevel": "medium" },
            "high": { "thinkingLevel": "high" }
          }
        },
        "antigravity-claude-sonnet-4-5": {
          "name": "Claude Sonnet 4.5 (Antigravity)",
          "attachment": true,
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-claude-sonnet-4-5-thinking": {
          "name": "Claude Sonnet 4.5 Thinking (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
            "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
          }
        },
        "antigravity-claude-opus-4-5-thinking": {
          "name": "Claude Opus 4.5 Thinking (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
            "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
          }
        },
        "gemini-2.5-flash": {
          "name": "Gemini 2.5 Flash (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-2.5-pro": {
          "name": "Gemini 2.5 Pro (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-3-flash-preview": {
          "name": "Gemini 3 Flash Preview (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-3-pro-preview": {
          "name": "Gemini 3 Pro Preview (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        }
      }
    },
    "openai": {
      "name": "OpenAI",
      "options": {
        "reasoningEffort": "high",
        "reasoningSummary": "detailed",
        "textVerbosity": "medium",
        "include": ["reasoning.encrypted_content"],
        "store": false
      },
      "models": {
        "gpt-5.2": {
          "name": "GPT 5.2 (OAuth)",
          "limit": { "context": 272000, "output": 128000 },
          "modalities": { "input": ["text", "image"], "output": ["text"] },
          "variants": {
            "none": { "reasoningEffort": "none", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "low": { "reasoningEffort": "low", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "medium": { "reasoningEffort": "medium", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "high": { "reasoningEffort": "high", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "xhigh": { "reasoningEffort": "xhigh", "reasoningSummary": "detailed", "textVerbosity": "medium" }
          }
        },
        "gpt-5.2-codex": {
          "name": "GPT 5.2 Codex (OAuth)",
          "limit": { "context": 272000, "output": 128000 },
          "modalities": { "input": ["text", "image"], "output": ["text"] },
          "variants": {
            "low": { "reasoningEffort": "low", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "medium": { "reasoningEffort": "medium", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "high": { "reasoningEffort": "high", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "xhigh": { "reasoningEffort": "xhigh", "reasoningSummary": "detailed", "textVerbosity": "medium" }
          }
        },
        "gpt-5.1-codex-max": {
          "name": "GPT 5.1 Codex Max (OAuth)",
          "limit": { "context": 272000, "output": 128000 },
          "modalities": { "input": ["text", "image"], "output": ["text"] },
          "variants": {
            "low": { "reasoningEffort": "low", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "medium": { "reasoningEffort": "medium", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "high": { "reasoningEffort": "high", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "xhigh": { "reasoningEffort": "xhigh", "reasoningSummary": "detailed", "textVerbosity": "medium" }
          }
        }
      }
    }
  }
}
EOF

# Write oh-my-opencode.json
echo "[6/7] Writing oh-my-opencode.json..."
cat > ~/.config/opencode/oh-my-opencode.json << 'EOF'
{
  "$schema": "https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json",
  "google_auth": false,
  "lsp": {
    "typescript-language-server": {
      "command": ["typescript-language-server", "--stdio"],
      "extensions": [".ts", ".tsx", ".js", ".jsx"],
      "priority": 10
    },
    "pyright": {
      "command": ["pyright-langserver", "--stdio"],
      "extensions": [".py"],
      "priority": 10
    }
  },
  "agents": {
    "Sisyphus": {
      "model": "openai/gpt-5.2"
    },
    "oracle": {
      "model": "openai/gpt-5.2"
    },
    "librarian": {
      "model": "google/antigravity-gemini-3-flash"
    },
    "explore": {
      "model": "google/antigravity-gemini-3-flash"
    },
    "frontend-ui-ux-engineer": {
      "model": "google/antigravity-gemini-3-pro-high"
    },
    "document-writer": {
      "model": "google/antigravity-gemini-3-flash"
    },
    "multimodal-looker": {
      "model": "google/antigravity-gemini-3-flash"
    }
  }
}
EOF

echo "[7/7] Installation complete!"
echo ""
echo "=== Installation Complete ==="
echo ""
echo "Next steps - Authenticate providers:"
echo "  1. opencode auth login → Select Google → OAuth with Antigravity"
echo "  2. opencode auth login → Select OpenAI → ChatGPT Plus/Pro (Codex)"
echo ""
echo "Then run: opencode"
