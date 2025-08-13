# 🎯 项目精简指南

## 📊 当前项目状态
- **项目类型**: Vue 3 + Vite + TypeScript 管理后台
- **当前依赖数量**: 约 40+ 个生产依赖，50+ 个开发依赖
- **目标**: 精简到核心功能，减少包体积和构建时间

## 🗑️ 可移除的依赖

### 生产依赖（如果不需要对应功能）
```bash
# 流程图相关
@logicflow/core @logicflow/extension

# 编辑器相关
codemirror          # 代码编辑器
tinymce            # 富文本编辑器
vditor             # Markdown 编辑器

# 功能组件
cropperjs          # 图片裁剪
echarts            # 图表库
intro.js           # 引导页
xlsx               # Excel 处理
```

### 开发依赖
```bash
# 类型定义（对应移除的生产依赖）
@types/codemirror @types/intro.js @types/qrcode 
@types/showdown @types/sortablejs

# 工具
commitizen conventional-changelog-cli
rollup-plugin-visualizer
```

## 🧹 文件清理

### 配置文件
- `.editorconfig` - 编辑器配置（可选）
- `.gitpod.yml` - Gitpod 配置（如果不用）

### 文档文件
- `CHANGELOG.en_US.md` - 英文更新日志
- `README.md` - 英文说明文档

### 构建产物
- `build/` 目录下的临时文件
- `dist/` 目录（构建输出）

## ⚡ 性能优化

### Vite 配置优化
```typescript
// vite.config.ts
export default defineConfig({
  build: {
    // 启用代码分割
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['vue', 'vue-router', 'pinia'],
          ui: ['ant-design-vue'],
          utils: ['lodash-es', 'dayjs']
        }
      }
    },
    // 压缩配置
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true
      }
    }
  }
})
```

### 按需引入
```typescript
// 使用按需引入替代全量引入
import { Button, Table } from 'ant-design-vue'
// 而不是 import Antd from 'ant-design-vue'
```

## 📱 代码分割策略

### 路由级别分割
```typescript
// 使用动态导入实现路由懒加载
const routes = [
  {
    path: '/dashboard',
    component: () => import('@/views/dashboard/index.vue')
  }
]
```

### 组件级别分割
```typescript
// 大型组件使用动态导入
const HeavyComponent = defineAsyncComponent(() => 
  import('@/components/HeavyComponent.vue')
)
```

## 🔍 依赖分析

### 使用 webpack-bundle-analyzer
```bash
# 分析打包后的文件大小
pnpm add -D webpack-bundle-analyzer
```

### 使用 vite-plugin-inspect
```typescript
// vite.config.ts
import Inspect from 'vite-plugin-inspect'

export default defineConfig({
  plugins: [Inspect()]
})
```

## 📈 精简效果预估

| 项目 | 精简前 | 精简后 | 减少 |
|------|--------|--------|------|
| 生产依赖 | ~40+ | ~25+ | 35% |
| 开发依赖 | ~50+ | ~35+ | 30% |
| 构建时间 | 基准 | -20% | 20% |
| 包体积 | 基准 | -25% | 25% |

## 🚀 执行精简

### 方法1: 使用脚本（推荐）
```bash
chmod +x cleanup-project.sh
./cleanup-project.sh
```

### 方法2: 手动执行
```bash
# 1. 移除依赖
pnpm remove [依赖名]

# 2. 清理文件
rm -f [文件名]

# 3. 重新安装
pnpm install

# 4. 测试构建
pnpm build
```

## ⚠️ 注意事项

1. **功能验证**: 精简后务必测试所有功能是否正常
2. **渐进式精简**: 建议分批精简，避免一次性移除过多依赖
3. **备份**: 精简前建议创建分支备份
4. **团队协调**: 确保团队成员了解精简内容

## 🔄 精简后维护

### 定期检查
- 每月检查一次未使用的依赖
- 使用 `depcheck` 工具检查依赖使用情况

### 新功能添加
- 新功能优先使用现有依赖
- 必须添加新依赖时，考虑是否可替代

---

**精简目标**: 保持功能完整性的前提下，最大化减少项目体积和构建时间。