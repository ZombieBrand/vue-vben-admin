#!/bin/bash

echo "🚀 开始精简项目..."

# 1. 清理依赖
echo "📦 清理不必要的依赖..."
pnpm remove @logicflow/core @logicflow/extension codemirror cropperjs echarts intro.js tinymce vditor xlsx

# 2. 清理开发依赖
echo "🔧 清理开发依赖..."
pnpm remove -D @types/codemirror @types/intro.js @types/qrcode @types/showdown @types/sortablejs commitizen conventional-changelog-cli rollup-plugin-visualizer

# 3. 清理配置文件
echo "⚙️ 清理配置文件..."
rm -f .editorconfig
rm -f .gitpod.yml

# 4. 清理文档文件（保留中文版本）
echo "📚 清理文档文件..."
rm -f CHANGELOG.en_US.md
rm -f README.md

# 5. 清理构建缓存
echo "🧹 清理构建缓存..."
pnpm clean:cache

# 6. 重新安装依赖
echo "📥 重新安装精简后的依赖..."
pnpm install

echo "✅ 项目精简完成！"
echo "📊 精简后的依赖数量："
echo "  生产依赖: $(grep -c "^\s*\".*\":" package.json | head -1)"
echo "  开发依赖: $(grep -c "^\s*\".*\":" package.json | tail -1)"