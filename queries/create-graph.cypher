
### queries/create-graph.cypher
```cypher
// Создание узлов (компонентов)
CREATE (api:Component {name: 'APIGateway', type: 'Gateway'})
CREATE (auth:Component {name: 'AuthService', type: 'Service'})
CREATE (student:Component {name: 'StudentService', type: 'Service'})
CREATE (course:Component {name: 'CourseService', type: 'Service'})
CREATE (grades:Component {name: 'GradesService', type: 'Service'})
CREATE (payment:Component {name: 'PaymentService', type: 'Service'})
CREATE (notification:Component {name: 'NotificationService', type: 'Service'})
CREATE (analytics:Component {name: 'AnalyticsService', type: 'Service'})
CREATE (postgres:Component {name: 'PostgreSQL', type: 'Database'})
CREATE (redis:Component {name: 'Redis', type: 'Cache'})
CREATE (elastic:Component {name: 'Elasticsearch', type: 'Search'})
CREATE (kafka:Component {name: 'Kafka', type: 'MessageBroker'})
CREATE (s3:Component {name: 'S3Storage', type: 'Storage'})
CREATE (keycloak:Component {name: 'Keycloak', type: 'AuthProvider'})
CREATE (web:Component {name: 'WebFrontend', type: 'Frontend'})
CREATE (mobile:Component {name: 'MobileApp', type: 'Frontend'})
CREATE (moodle:Component {name: 'MoodleAdapter', type: 'Integration'})
CREATE (canvas:Component {name: 'CanvasAdapter', type: 'Integration'})

// Создание зависимостей
CREATE (web)-[:DEPENDS_ON]->(api)
CREATE (mobile)-[:DEPENDS_ON]->(api)
CREATE (api)-[:ROUTES_TO]->(auth)
CREATE (api)-[:ROUTES_TO]->(student)
CREATE (api)-[:ROUTES_TO]->(course)
CREATE (api)-[:ROUTES_TO]->(grades)
CREATE (api)-[:ROUTES_TO]->(payment)
CREATE (api)-[:ROUTES_TO]->(notification)
CREATE (api)-[:ROUTES_TO]->(analytics)

CREATE (auth)-[:USES]->(postgres)
CREATE (auth)-[:USES]->(redis)
CREATE (auth)-[:USES]->(kafka)
CREATE (auth)-[:INTEGRATES_WITH]->(keycloak)

CREATE (student)-[:USES]->(postgres)
CREATE (student)-[:USES]->(redis)
CREATE (student)-[:USES]->(s3)
CREATE (student)-[:PUBLISHES_TO]->(kafka)

CREATE (course)-[:USES]->(postgres)
CREATE (course)-[:USES]->(redis)
CREATE (course)-[:USES]->(elastic)
CREATE (course)-[:PUBLISHES_TO]->(kafka)

CREATE (grades)-[:USES]->(postgres)
CREATE (grades)-[:USES]->(redis)
CREATE (grades)-[:PUBLISHES_TO]->(kafka)

CREATE (payment)-[:USES]->(postgres)
CREATE (payment)-[:USES]->(redis)

CREATE (notification)-[:USES]->(redis)
CREATE (notification)-[:SUBSCRIBES_TO]->(kafka)

CREATE (analytics)-[:USES]->(postgres)
CREATE (analytics)-[:SUBSCRIBES_TO]->(kafka)

CREATE (moodle)-[:SYNC_WITH]->(student)
CREATE (moodle)-[:SYNC_WITH]->(course)
CREATE (canvas)-[:SYNC_WITH]->(student)
CREATE (canvas)-[:SYNC_WITH]->(course)

CREATE (kafka)-[:NOTIFIES]->(notification)
CREATE (kafka)-[:FEEDS]->(analytics);