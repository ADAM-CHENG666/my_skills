# Report Skills

一个轻量的 Codex skill 套件仓库，当前只维护两类 report skill：

- `design-report`
- `engineering-report`

这个仓库的目标很直接：

- 作为这两个 skill 的主维护位置
- 像普通项目一样用 Git 和 GitHub 管理
- 支持跨项目复用
- 支持整包安装或单独安装
- 保持轻量，不引入复杂发布系统

## 仓库边界

第一阶段只收录 report 类 skill，不迁出强依赖某个业务项目上下文的内容。

本仓库刻意不包含：

- `local_data/`
- 项目私有业务资料
- 某个单一仓库的绝对路径约定
- 只对当前项目有效的脚本或流程资产

## 目录结构

```text
skills/
  design-report/
    SKILL.md
    README.md
    agents/
      openai.yaml
  engineering-report/
    SKILL.md
    README.md
    agents/
      openai.yaml
scripts/
  install.sh
```

## 安装

默认安装目标：

```bash
${CODEX_HOME:-$HOME/.codex}/skills
```

整包安装：

```bash
./scripts/install.sh all
```

单独安装：

```bash
./scripts/install.sh design-report
./scripts/install.sh engineering-report
```

指定目标目录：

```bash
./scripts/install.sh all --target /path/to/skills
./scripts/install.sh design-report --target /path/to/skills
```

## 建议使用方式

1. 在这个仓库里维护和迭代 skill。
2. 改完后正常 `git commit`、`git push` 到 GitHub。
3. 需要在其他项目或本机使用时，运行安装脚本同步到 skills 目录。

## 维护原则

- 这里是 `design-report` 和 `engineering-report` 的 source of truth。
- 如果原项目还要继续使用它们，应从本仓库安装或同步，不再把原项目当主编辑位置。
- 公共能力优先沉淀在这里；项目特有内容留在项目仓库内。
