from __future__ import annotations

import platform
import sys
from pathlib import Path

from inline_snapshot import snapshot


def test_pyinstaller_datas():
    from codrus_cli.utils.pyinstaller import datas

    project_root = Path(__file__).parent.parent.parent
    python_version = f"{sys.version_info.major}.{sys.version_info.minor}"
    site_packages = f".venv/lib/python{python_version}/site-packages"
    rg_binary = "rg.exe" if platform.system() == "Windows" else "rg"
    has_rg_binary = (project_root / "src/codrus_cli/deps/bin" / rg_binary).exists()
    datas = [
        (
            Path(path)
            .relative_to(project_root)
            .as_posix()
            .replace(".venv/Lib/site-packages", site_packages),
            Path(dst).as_posix(),
        )
        for path, dst in datas
    ]

    datas = [(p, d) for p, d in datas if "web/static" not in d and "vis/static" not in d]

    expected_datas = [
        (
            f"{site_packages}/dateparser/data/dateparser_tz_cache.pkl",
            "dateparser/data",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/INSTALLER",
            "fastmcp/../fastmcp-3.2.4.dist-info",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/METADATA",
            "fastmcp/../fastmcp-3.2.4.dist-info",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/RECORD",
            "fastmcp/../fastmcp-3.2.4.dist-info",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/REQUESTED",
            "fastmcp/../fastmcp-3.2.4.dist-info",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/WHEEL",
            "fastmcp/../fastmcp-3.2.4.dist-info",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/entry_points.txt",
            "fastmcp/../fastmcp-3.2.4.dist-info",
        ),
        (
            f"{site_packages}/fastmcp/../fastmcp-3.2.4.dist-info/licenses/LICENSE",
            "fastmcp/../fastmcp-3.2.4.dist-info/licenses",
        ),
        (
            "src/codrus_cli/CHANGELOG.md",
            "codrus_cli",
        ),
        ("src/codrus_cli/agents/default/agent.yaml", "codrus_cli/agents/default"),
        ("src/codrus_cli/agents/default/coder.yaml", "codrus_cli/agents/default"),
        ("src/codrus_cli/agents/default/explore.yaml", "codrus_cli/agents/default"),
        ("src/codrus_cli/agents/default/plan.yaml", "codrus_cli/agents/default"),
        ("src/codrus_cli/agents/default/system.md", "codrus_cli/agents/default"),
        ("src/codrus_cli/agents/okabe/agent.yaml", "codrus_cli/agents/okabe"),
        ("src/codrus_cli/prompts/compact.md", "codrus_cli/prompts"),
        ("src/codrus_cli/prompts/init.md", "codrus_cli/prompts"),
        (
            "src/codrus_cli/skills/codrus-cli-help/SKILL.md",
            "codrus_cli/skills/codrus-cli-help",
        ),
        (
            "src/codrus_cli/skills/skill-creator/SKILL.md",
            "codrus_cli/skills/skill-creator",
        ),
        ("src/codrus_cli/tools/agent/description.md", "codrus_cli/tools/agent"),
        ("src/codrus_cli/tools/ask_user/description.md", "codrus_cli/tools/ask_user"),
        (
            "src/codrus_cli/tools/dmail/dmail.md",
            "codrus_cli/tools/dmail",
        ),
        ("src/codrus_cli/tools/background/list.md", "codrus_cli/tools/background"),
        ("src/codrus_cli/tools/background/output.md", "codrus_cli/tools/background"),
        ("src/codrus_cli/tools/background/stop.md", "codrus_cli/tools/background"),
        (
            "src/codrus_cli/tools/file/glob.md",
            "codrus_cli/tools/file",
        ),
        (
            "src/codrus_cli/tools/file/grep.md",
            "codrus_cli/tools/file",
        ),
        (
            "src/codrus_cli/tools/file/read.md",
            "codrus_cli/tools/file",
        ),
        (
            "src/codrus_cli/tools/file/read_media.md",
            "codrus_cli/tools/file",
        ),
        (
            "src/codrus_cli/tools/file/replace.md",
            "codrus_cli/tools/file",
        ),
        (
            "src/codrus_cli/tools/file/write.md",
            "codrus_cli/tools/file",
        ),
        ("src/codrus_cli/tools/plan/description.md", "codrus_cli/tools/plan"),
        ("src/codrus_cli/tools/plan/enter_description.md", "codrus_cli/tools/plan"),
        ("src/codrus_cli/tools/shell/bash.md", "codrus_cli/tools/shell"),
        (
            "src/codrus_cli/tools/think/think.md",
            "codrus_cli/tools/think",
        ),
        (
            "src/codrus_cli/tools/todo/set_todo_list.md",
            "codrus_cli/tools/todo",
        ),
        (
            "src/codrus_cli/tools/web/fetch.md",
            "codrus_cli/tools/web",
        ),
        (
            "src/codrus_cli/tools/web/search.md",
            "codrus_cli/tools/web",
        ),
    ]
    if has_rg_binary:
        expected_datas.append((f"src/codrus_cli/deps/bin/{rg_binary}", "codrus_cli/deps/bin"))

    assert sorted(datas) == sorted(expected_datas)


def test_pyinstaller_hiddenimports():
    from codrus_cli.utils.pyinstaller import hiddenimports

    assert sorted(hiddenimports) == snapshot(
        [
            "codrus_cli._build_info",
            "codrus_cli.cli.export",
            "codrus_cli.cli.info",
            "codrus_cli.cli.mcp",
            "codrus_cli.cli.plugin",
            "codrus_cli.cli.vis",
            "codrus_cli.cli.web",
            "codrus_cli.tools",
            "codrus_cli.tools.agent",
            "codrus_cli.tools.ask_user",
            "codrus_cli.tools.background",
            "codrus_cli.tools.display",
            "codrus_cli.tools.dmail",
            "codrus_cli.tools.file",
            "codrus_cli.tools.file.glob",
            "codrus_cli.tools.file.grep_local",
            "codrus_cli.tools.file.plan_mode",
            "codrus_cli.tools.file.read",
            "codrus_cli.tools.file.read_media",
            "codrus_cli.tools.file.replace",
            "codrus_cli.tools.file.utils",
            "codrus_cli.tools.file.write",
            "codrus_cli.tools.plan",
            "codrus_cli.tools.plan.enter",
            "codrus_cli.tools.plan.heroes",
            "codrus_cli.tools.shell",
            "codrus_cli.tools.test",
            "codrus_cli.tools.think",
            "codrus_cli.tools.todo",
            "codrus_cli.tools.utils",
            "codrus_cli.tools.web",
            "codrus_cli.tools.web.fetch",
            "codrus_cli.tools.web.search",
            "setproctitle",
        ]
    )


def test_pyinstaller_hiddenimports_include_lazy_cli_subcommands():
    from codrus_cli.cli._lazy_group import LazySubcommandGroup
    from codrus_cli.utils.pyinstaller import hiddenimports

    expected_hiddenimports = {
        module_name
        for module_name, _attribute_name, _help_text in LazySubcommandGroup.lazy_subcommands.values()
    }

    assert expected_hiddenimports <= set(hiddenimports)
