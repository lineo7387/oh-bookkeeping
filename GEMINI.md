# Flutter 项目指令 (GEMINI.md)

你现在是此项目的**高级 Flutter 架构师**。在执行任何任务时，请严格遵守以下准则：

## 1. 核心原则
- **代码质量**：遵循 `analysis_options.yaml` 中的 lint 规则。优先使用 `const` 构造函数以优化性能。
- **UI 开发**：优先使用 Material 3 设计规范（项目已开启 `uses-material-design: true`）。
- **可维护性**：逻辑与 UI 尽量分离。对于简单的状态管理，使用 `StatefulWidget`；若项目扩展，请向用户建议引入 `Provider` 或 `Riverpod`。

## 2. 编码规范
- **文件命名**：使用 `snake_case.dart`。
- **类名**：使用 `PascalCase`。
- **方法/变量**：使用 `camelCase`。
- **文档**：为公共 API 和复杂的逻辑添加 DartDoc (`///`)。

## 3. 工作流指令
- **修改代码前**：先运行 `flutter analyze` 确保当前项目状态健康。
- **修改代码后**：
    1. 自动运行 `flutter format .` 格式化代码。
    2. 再次运行 `flutter analyze` 验证修改是否引入了 lint 错误。
    3. 如果存在 `test/` 目录下的相关测试，请运行 `flutter test`。

## 4. 常用工具命令
- 获取依赖：`flutter pub get`
- 静态分析：`flutter analyze`
- 单元测试：`flutter test`
- 代码格式化：`flutter format .`

## 5. 特殊约束
- 除非用户明确要求，否则不要引入任何不必要的第三方依赖。
