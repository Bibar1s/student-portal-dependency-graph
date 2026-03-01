# Student Portal Dependency Graph

## Быстрый старт
```bash
# 1. Распаковать архив
# 2. Запустить Neo4j
docker-compose up -d

# 3. Установить зависимости
npm install

# 4. Создать граф
node migrate.js

# 5. Посчитать метрики
node metrics.js