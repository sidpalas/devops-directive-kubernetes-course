# Локализация: правила и глоссарий

Этот документ описывает конвенции русскоязычной локализации курса и глоссарий терминов. Он предназначен для переводчиков и будущих контрибьюторов, чтобы все переводы были единообразными.

## Правила локализации

### Файлы и структура

- Русский перевод каждого файла лежит рядом с оригиналом с суффиксом `.ru`: `README.md` → `README.ru.md`.
- Структура markdown (уровни заголовков, списки, абзацы, таблицы) воспроизводится 1:1 с оригиналом.
- В начале каждого переведённого файла, сразу после заголовка H1, добавляется строка-переключатель языков:
  ```markdown
  > 🌐 [English](README.md) | Русский
  ```

### Что НЕ переводится

- **Код-блоки**: команды, YAML-манифесты, вывод утилит (`kubectl`, `task --list`), примеры конфигурации.
- **URL и пути**: ссылки на внешние ресурсы, относительные пути к файлам и картинкам (`readme-assets/…`).
- **Имена файлов и директорий** в тексте (`03-installation-and-setup/README.md`).
- **Названия инструментов и проектов**: Helm, kubectl, kind, Docker, Tilt, Kustomize, kluctl, CloudNativePG, Trivy, cert-manager, External Secrets Operator, GitHub Actions и т.п.
- **Kubernetes-термины** (см. глоссарий ниже).
- **Эмодзи** (🚨⚠️✅🌐) сохраняются на своих местах.

### Kubernetes-термины

Основные термины Kubernetes остаются на английском без перевода и без дублирования в скобках (стандарт русскоязычной технической документации): **Pod, Deployment, Service, Ingress, Gateway API, ConfigMap, Secret, StatefulSet, DaemonSet, ReplicaSet, Job, CronJob, Namespace, PersistentVolume (PV), PersistentVolumeClaim (PVC), RBAC, CRD, operator, control plane, data plane, sidecar, init container, probe (liveness/readiness/startup), rolling update, resource limits/requests, autoscaling**.

Слова **node, cluster, container** — обычные слова русского технического языка: в прозе они переводятся как **«узел», «кластер», «контейнер»** (например, «узел кластера», «кластер Kubernetes»). Английские формы сохраняются только внутри код-блоков, имен команд и в названиях разделов, где это часть идентификатора.

Прилагательные и причастия от терминов согласуются по-русски: «объект типа Pod», «несколько Deployment'ов» (допустимо «несколько объектов Deployment»).

В backticked-подписях действует правило: если это реальный идентификатор (имя task-задачи, команды) — оставляем английский; если описательный термин — переводим.

### Что переводится

- Заголовки разделов и описания (в заголовках-ссылках переводится текст, путь ссылки сохраняется: `### [01 — История и мотивация](01-history-and-motivation/README.md)`).
- Проза: пояснения, инструкции, описания концепций.
- Пункты маркированных списков, где термин является CLI-командой: команда сохраняется, описание переводится (`helm repo add` — добавляет репозиторий…).

### Стиль русского текста

- Обращение на «вы» (вежливая форма), безличные конструкции предпочтительнее.
- Буква «ё» не обязательна (можно «ее», «все»).
- Буквенно-цифровые списки «01», «02» в номерах разделов сохраняются.
- Не воспроизводить опечатки оригинала (см. ниже).
- Типографика: длинное тире «—» в заголовках-номерах, кавычки «ёлочки» для цитат и названий.

## Глоссарий

Соответствие терминов для единообразия между файлами:

| Русский | English |
|---|---|
| оркестрация | orchestration |
| узел (кластера) | node |
| кластер | cluster |
| контейнер | container |
| образ (контейнера) | image |
| реестр образов | registry |
| развёртывание (процесс) | deployment (process) |
| манифест | manifest |
| пространство имён | namespace |
| аннотация | annotation |
| метка | label |
| селектор | selector |
| том | volume |
| постоянный том | PersistentVolume |
| заявка на том | PersistentVolumeClaim |
| сеть | networking |
| балансировка нагрузки | load balancing |
| обнаружение сервисов | service discovery |
| дрейф (конфигурации) | drift |
| шаблонный код | boilerplate |
| масштабирование | scaling |
| автомасштабирование | autoscaling |
| обновление без простоя | rolling update |
| отказоустойчивость | fault tolerance |
| самовосстановление | self-healing |
| декларативный | declarative |
| императивный | imperative |
| пакетный менеджер | package manager |
| чарт | chart |
| релиз (Helm) | release |
| хук | hook |
| шаблонизация | templating |
| конфигурационные данные | configuration data |
| переменные окружения | environment variables |
| секреты | secrets |
| ролевая модель доступа | RBAC (role-based access control) |
| пользовательские ресурсы | custom resources |
| расширяемость | extensibility |
| многоэтапное окружение | multi-environment |
| наложение конфигураций | overlay |
| непрерывная интеграция | continuous integration (CI) |
| непрерывная поставка | continuous delivery (CD) |
| опыт разработчика | developer experience |
| отладка | debugging |
| обновление кластера | cluster upgrade |

## Замеченные опечатки оригинала

В переводе исправлены (не воспроизводить):

- `04-built-in-resource-types/README.md`: «namesapce» → namespace
- `04-built-in-resource-types/README.md`: «This sections covers» → исправлено по смыслу
- `09-deploying-auxiliary-tooling/README.md`: «Auxillary» в заголовке → Auxiliary (в переводе: «Вспомогательные инструменты»)
- `08-extending-kubernetes/README.md`: «encode those logic» → исправлено по смыслу
- `10-developer-experience/README.md`: «SOPs» (имя инструмента) → SOPS
