# Lista de Tarefas Diárias

Projeto desenvolvido para a disciplina de DESENVOLVIMENTO PARA DISPOSITIVOS MÓVEIS. O app foi criado em Flutter e permite organizar as tarefas do dia a dia de forma simples e visual.

---

## O que o app faz

- Cadastro e login de usuário
- Calendário para escolher o dia
- Lista de tarefas por dia
- Adicionar, concluir e remover tarefas
- Tarefas pendentes aparecem primeiro, depois as concluídas — ambas em ordem alfabética

---

## Tecnologias utilizadas

- Flutter
- Dart
- Gerenciamento de estado com StatefulWidget e setState

---

## Estrutura do projeto

```
lib/
├── main.dart               
├── repository.dart         
├── models/
│   └── task.dart           
├── screens/
│   ├── login_screen.dart   
│   ├── register_screen.dart
│   ├── calendar_screen.dart
│   └── task_list_screen.dart
└── widgets/
    └── add_task_dialog.dart
```

---

## Como rodar

1. Clone o repositório:
```bash
git clone https://github.com/IsabellySB/lista-tarefas-flutter.git
```

2. Entre na pasta:
```bash
cd lista-tarefas-flutter
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Rode o app:
```bash
flutter run
```

---

Desenvolvido por [IsabellySB](https://github.com/IsabellySB)
