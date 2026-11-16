# ToDoList

**Gerenciador de tarefas desenvolvido em Swift**, com persistência local em JSON, integração demonstrativa com API REST e testes automatizados.

O projeto foi desenvolvido com o objetivo de praticar conceitos de desenvolvimento de software utilizando Swift, explorando organização de código, orientação a objetos, persistência de dados e programação assíncrona.

## Objetivo e escopo

O ToDoList é um projeto individual de aprendizado e portfólio. Sua proposta é implementar um gerenciador de tarefas por linha de comando, com armazenamento local e funcionalidades básicas de gerenciamento.

A integração com uma API externa complementa o projeto como demonstração de consumo de serviços REST.

## Funcionalidades

- Criar tarefas com título e prioridade.
- Listar tarefas cadastradas e seus respectivos status.
- Marcar tarefas como concluídas.
- Excluir tarefas.
- Validar títulos e prioridades.
- Salvar e recuperar tarefas utilizando arquivos JSON.
- Consultar tarefas externas por meio de uma API REST.

## Tecnologias utilizadas

- **Swift 6.4.2** — linguagem de programação.
- **Foundation** — manipulação de arquivos, JSON e requisições HTTP.
- **URLSession** — comunicação com API REST.
- **async/await** — programação assíncrona.
- **Swift Testing** — testes automatizados.
- **Swift Package Manager** — gerenciamento e estruturação do projeto.
- **Git e GitHub** — versionamento de código.
- **SwiftLint** — análise estática e padronização do código.
- **GitHub Actions** — integração contínua (CI).

## Arquitetura

O projeto utiliza uma organização inspirada no padrão MVVM, separando responsabilidades entre interface, gerenciamento de estado e regras de negócio.

```text
Sources/ToDo/
├── ToDoList.swift
├── TaskManager.swift
├── TaskListViewModel.swift
├── ToDoListCLI.swift
├── TaskStorage.swift
├── RemoteTask.swift
├── TaskAPIService.swift
└── main.swift
```

### Principais componentes

| Componente | Responsabilidade |
|---|---|
| ToDoList | Modelo que representa uma tarefa. |
| TaskManager | Gerencia as operações e regras de negócio. |
| TaskListViewModel | Intermediário entre a interface e o gerenciador. |
| ToDoListCLI | Interface de interação pelo terminal. |
| TaskStorage | Persistência local utilizando JSON. |
| TaskStorageProtocol | Abstração para operações de armazenamento. |
| RemoteTask | Modelo dos dados recebidos da API. |
| TaskAPIService | Responsável pelas requisições HTTP. |

O armazenamento utiliza um protocolo, permitindo substituir sua implementação sem modificar diretamente as regras de negócio.

As operações de persistência também contam com tratamento de erros, buscando manter a consistência dos dados durante a execução.

## API REST

O projeto utiliza a [JSONPlaceholder](https://jsonplaceholder.typicode.com/) para demonstrar a comunicação com serviços externos.

Endpoint utilizado:

```text
GET https://jsonplaceholder.typicode.com/todos/1
```

A resposta JSON é convertida para o modelo `RemoteTask` utilizando `Codable`.

A comunicação é realizada com `URLSession` e `async/await`, incluindo verificação da resposta HTTP e tratamento de erros.

## Testes automatizados

O projeto utiliza o framework Swift Testing para verificar o comportamento das funcionalidades.

Atualmente, são **21 testes automatizados**, cobrindo:

- Validação de títulos e prioridades.
- Criação, conclusão e exclusão de tarefas.
- Tratamento de índices inválidos.
- Persistência e recuperação de dados em JSON.
- Comportamento do ViewModel.
- Conversão de JSON em objetos Swift.
- Tratamento de respostas HTTP inválidas e erros de requisição.
- Tratamento de falhas de leitura e escrita.
- Consistência do estado da aplicação quando ocorrem falhas de persistência.

Os testes utilizam mocks para simular dependências e verificar diferentes cenários de execução.

## Integração contínua (CI)

O projeto utiliza GitHub Actions para automatizar verificações de qualidade.

O workflow é executado em um ambiente macOS quando há atualizações na branch `main` ou abertura de Pull Requests direcionados a ela.

As etapas incluem:

1. Preparação do ambiente e instalação do Swift.
2. Execução do SwiftLint em modo estrito.
3. Compilação do projeto com `swift build`.
4. Execução dos testes com `swift test`.

O workflow foi configurado e validado com sucesso.

## Decisões de projeto

A interface de linha de comando foi escolhida para manter o escopo do projeto concentrado nas funcionalidades principais e nos conceitos de programação utilizados.

O desenvolvimento foi realizado em ambiente Windows, sem acesso às ferramentas nativas de desenvolvimento Apple. Por isso, uma interface gráfica com SwiftUI não faz parte da versão atual.

Uma possível evolução seria desenvolver uma interface gráfica, aproveitando a estrutura de gerenciamento de tarefas e persistência já existente.

## Uso de ferramentas de IA

Ferramentas de inteligência artificial foram utilizadas como apoio durante o desenvolvimento, auxiliando na pesquisa de soluções, esclarecimento de dúvidas técnicas, investigação de erros e documentação do projeto. As sugestões foram avaliadas e testadas durante o processo de desenvolvimento.

## Como executar

### Pré-requisitos

- Swift 6.4.2 ou compatível com a versão mínima definida no `Package.swift`.
- Git.

### Clonar o repositório

```bash
git clone https://github.com/LQDias/ToDoList.git
cd ToDoList
```

### Compilar o projeto

```bash
swift build
```

### Executar

```bash
swift run
```

### Executar os testes

```bash
swift test
```
