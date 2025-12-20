# Migration Guide: Slash Commands → Skills

## Overview

As of **Claude Code v2.0.73**, "slash commands" have been replaced by "skills". This migration guide will help you transition to the new architecture.

## What Changed?

### Claude Code Terminology Update

| Aspect | Before (v2.0.72 and earlier) | After (v2.0.73+) |
|--------|----------------------------|------------------|
| **Terminology** | "Slash commands" + "Skills" | "Skills" only |
| **Installation Directory** | `~/.claude/commands/` | `~/.claude/skills/` |
| **Invocation** | `/command` syntax | `/skill` syntax (same usage) |
| **Concept** | Separate features | Unified as skills |

### What Stays the Same

✅ **User Experience**: You still type `/build`, `/commit`, `/test`, etc. – the invocation syntax hasn't changed
✅ **Functionality**: All capabilities work identically
✅ **File Format**: `.md` files with YAML frontmatter
✅ **Repository Structure**: Still has `commands/` and `skills/` directories for organization

## For Existing Users

If you previously installed this repository, you need to:

### 1. Update Your Repository

```zsh
cd $HOME/agentic-slash-commands
git pull
```

### 2. Clean Up Old Installation

Remove symlinks from the deprecated `~/.claude/commands/` directory:

```zsh
# List what will be removed (optional - to verify first)
ls -la ~/.claude/commands/

# Remove old symlinks
rm -rf ~/.claude/commands/
```

**Note**: This only removes symlinks, not your source files in the repository.

### 3. Reinstall with New Structure

```zsh
cd $HOME/agentic-slash-commands
./install.sh
```

The installer will now create symlinks in `~/.claude/skills/` instead of `~/.claude/commands/`.

### 4. Verify Installation

Check that skills are properly installed:

```zsh
ls -la ~/.claude/skills/
```

You should see symlinks to files in your `agentic-slash-commands` repository.

## For New Users

No migration needed! Simply follow the installation instructions in README.md:

```zsh
git clone https://github.com/ruchernchong/agentic-slash-commands.git $HOME/agentic-slash-commands
cd $HOME/agentic-slash-commands
chmod +x install.sh
./install.sh
```

## Platform-Specific Notes

### Claude Code

- **Changed**: Installation location from `~/.claude/commands/` to `~/.claude/skills/`
- **Changed**: Terminology from "slash commands" to "skills"
- **Unchanged**: Usage with `/skill-name` syntax

### Codex

- **Unchanged**: Still uses `~/.codex/prompts/`
- **Unchanged**: Still called "prompts"

### Gemini CLI

- **Unchanged**: Still uses `~/.gemini/commands/`
- **Unchanged**: Still called "commands"

## Troubleshooting

### Skills Not Showing Up

If skills don't appear in Claude Code after migration:

1. **Verify installation location**:
   ```zsh
   ls -la ~/.claude/skills/
   ```

2. **Check symlinks are correct**:
   ```zsh
   readlink ~/.claude/skills/build.md
   ```
   Should point to your repository's `commands/build.md` file.

3. **Restart Claude Code** (if running in a persistent session)

### Duplicate Skills

If you see duplicate skills:

1. **Remove old commands directory**:
   ```zsh
   rm -rf ~/.claude/commands/
   ```

2. **Verify only skills directory exists**:
   ```zsh
   ls -d ~/.claude/*/
   ```
   Should only show `~/.claude/skills/` (and possibly other directories like `~/.claude/settings/`)

### Permission Issues

If you get permission errors:

```zsh
chmod +x $HOME/agentic-slash-commands/install.sh
chmod +x $HOME/agentic-slash-commands/scripts/*.sh
```

## FAQ

### Why did Claude Code make this change?

Claude Code unified "slash commands" and "skills" into a single "skills" model to:
- Simplify the mental model (one concept instead of two)
- Enable both explicit invocation (`/skill`) and auto-discovery
- Provide a more flexible architecture for future enhancements

### Do I need to change my skill files?

No! The `.md` file format with YAML frontmatter remains the same. The only change is where they're installed.

### Will my old skills stop working?

Claude Code may maintain backward compatibility with `~/.claude/commands/` for a transition period, but it's recommended to migrate to `~/.claude/skills/` to ensure future compatibility.

### Can I keep both directories?

While technically possible, it's not recommended as it may cause confusion or duplicate skills appearing in Claude Code. Stick with `~/.claude/skills/` only.

### What about my custom skills?

If you have custom skills in `~/.claude/commands/`, move them to `~/.claude/skills/`:

```zsh
# Move custom skills
mv ~/.claude/commands/my-custom-skill.md ~/.claude/skills/

# Or copy if you want to keep backups
cp ~/.claude/commands/my-custom-skill.md ~/.claude/skills/
```

## Repository Structure

This repository maintains a logical separation:

- **`commands/` directory**: User-invocable skills (invoke with `/skill-name`)
- **`skills/` directory**: Helper skills (auto-discovered by Claude Code)

Both install to `~/.claude/skills/` but are kept separate in the repository for organizational clarity.

## Getting Help

If you encounter issues during migration:

1. Check this guide's troubleshooting section
2. Review the [README.md](README.md) for installation details
3. Open an issue on GitHub: https://github.com/ruchernchong/agentic-slash-commands/issues

## Summary

Migration is straightforward:

1. ✅ Pull latest changes: `git pull`
2. ✅ Remove old directory: `rm -rf ~/.claude/commands/`
3. ✅ Reinstall: `./install.sh`
4. ✅ Verify: `ls -la ~/.claude/skills/`

Your skills will continue to work exactly as before, just with updated terminology and installation location!
