# 🏊 Swim Pace

Aplicativo mobile desenvolvido em **Flutter** para cálculo de ritmo (pace) de nadadores. O pace na natação é medido em **min/100m**, representando o tempo médio que o nadador leva para percorrer cada 100 metros. Por exemplo, em uma prova de 1km, o atleta pode calcular exatamente qual foi seu ritmo a cada 100m com base no tempo total e na distância percorrida.

---

## 📱 Funcionalidades

- Cálculo automático de **pace (min/100m)** e **velocidade (km/h)** com base em distância e tempo
- Autenticação completa com **cadastro e login**
- Histórico de atividades salvas por usuário
- Edição e visualização de **perfil do usuário**
- Página de ajuda com descrição das funcionalidades
- Persistência de dados em banco de dados relacional na nuvem

---

## 🏗️ Arquitetura

O projeto foi desenvolvido seguindo o padrão **MVVM (Model-View-ViewModel)**, separando as responsabilidades em três camadas:

```
lib/
├── shared/
│   ├── models/          # Modelos de dados (SavesModel, ProfileModel)
│   └── widgets/         # Componentes reutilizáveis (SavesCard, ResultCard, TimeCard, AppButton, WaveClipper)
├── services/            # Camada de acesso à API (AuthService, ActivityService, ProfileService)
├── login/
│   ├── login_view.dart
│   └── login_view_model.dart
├── register/
│   ├── register_view.dart
│   └── register_view_model.dart
├── home/
│   ├── home_view.dart
│   └── home_view_model.dart
├── save/
│   ├── save_view.dart
│   └── save_view_model.dart
├── profile/
│   ├── profile_view.dart
│   └── profile_view_model.dart
└── help/
    └── help_view.dart
```

### Camadas do MVVM

| Camada | Responsabilidade |
|--------|-----------------|
| **Model** | Estrutura dos dados, deserialização do JSON via `fromJson` |
| **ViewModel** | Lógica de negócio, estado da UI, chamadas aos serviços |
| **View** | Renderização da interface, consumo do ViewModel via `context.watch` |

---

## 🛠️ Stack Tecnológica

### Frontend — Flutter

| Tecnologia | Uso |
|------------|-----|
| **Flutter** | Framework principal para desenvolvimento mobile |
| **Provider** | Gerenciamento de estado via `ChangeNotifier` e `ChangeNotifierProvider` |
| **Dio** | Cliente HTTP para consumo da API REST |
| **Shared Preferences** | Armazenamento local do token JWT |

### Backend — Node.js

| Tecnologia | Uso |
|------------|-----|
| **Node.js + Express** | Servidor HTTP e roteamento da API REST |
| **node-postgres (pg)** | Driver para comunicação com o PostgreSQL |
| **bcryptjs** | Hash e verificação de senhas com salt |
| **jsonwebtoken (JWT)** | Geração e validação de tokens de autenticação |
| **dotenv** | Gerenciamento de variáveis de ambiente |
| **cors** | Configuração de Cross-Origin Resource Sharing |

### Banco de Dados

| Tecnologia | Uso |
|------------|-----|
| **PostgreSQL** | Banco de dados relacional |
| **NeonDB** | Hospedagem serverless do PostgreSQL na nuvem |

---

## 🗄️ Modelo de Dados

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE saves (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(150) NOT NULL,
  distance VARCHAR(50),
  time VARCHAR(50),
  pace VARCHAR(50),
  speed VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 🔐 Autenticação

O sistema utiliza autenticação stateless com **JWT (JSON Web Token)**:

1. O usuário realiza login com email e senha
2. A senha é comparada com o hash armazenado via `bcrypt.compare`
3. Em caso de sucesso, o servidor gera um token JWT assinado com `JWT_SECRET` e validade de **7 dias**
4. O token é armazenado localmente via `SharedPreferences`
5. Todas as rotas protegidas recebem o token no header `Authorization: Bearer <token>`
6. O middleware `verificaToken` valida o token e injeta o `usuario.id` no `req` para uso nos controllers

---

## 🌐 Endpoints da API

### Auth
| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| POST | `/api/auth/register` | Cadastro de usuário | ❌ |
| POST | `/api/auth/login` | Login e geração do token | ❌ |

### Saves (Atividades)
| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/api/activity/saves` | Lista saves do usuário logado | ✅ |
| POST | `/api/activity/saves` | Cria um novo save | ✅ |
| DELETE | `/api/activity/saves/:id` | Remove um save por ID | ✅ |

### Profile
| Método | Rota | Descrição | Auth |
|--------|------|-----------|------|
| GET | `/api/profile` | Retorna dados do perfil | ✅ |
| PUT | `/api/profile/edit` | Atualiza nome e email | ✅ |

---

## 🧩 Widgets Reutilizáveis

| Widget | Descrição |
|--------|-----------|
| `WaveClipper` | `CustomClipper` que gera o efeito de onda nas telas de login e cadastro |
| `TimeCard` | Campo de texto com label superior para horas, minutos e segundos |
| `AppButton` | Botão primário padronizado com ícone e texto |
| `ResultCard` | Card de exibição do pace e velocidade calculados |
| `SavesCard` | Card do histórico com título, métricas, distância, tempo e data |

---

## 🧮 Fórmula de Cálculo

```dart
// Pace (min/100m)
double pacePer100m = totalSeconds / (distanceKm * 10);
int paceMin = (pacePer100m / 60).floor();
int paceSec = (pacePer100m % 60).round();

// Velocidade (km/h)
double speed = distanceKm / (totalSeconds / 3600);
```
