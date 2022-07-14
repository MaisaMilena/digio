# Digio - demo

### Arquitetura 
  VIP: unidirecional e baseada em protocolos

* ViewController: dispara o evento para a Interactor
* Interactor: lida com a lógica e chamadas para a Service. Ao receber a resposta
da Service, faz a chamada especializada (sucesso ou falha) pra a Presenter.
  *Só cheguei a mostrar o erro com o Sentinel por conta de tempo*
* Service: cria os endpoints e os repassa para a API
  - debug: para trabalhar com os mock local
  - sem setar o debug, faz a chamada na API real
* API: lida com toda a lógica por trás da excução de uma chamada em um Endpoint.
* Sentinel: para facilitar lidar com mensagens no App.
* AppOrchestrator: cria a scena VIP e suas dependências
* Coordinator: fazer a coordenação de fluxo de telas

### Dependências
- [SnapKit](https://github.com/SnapKit/SnapKit): acho mais limpo para lidar com constraints

### Framework
- [swiftgen](https://github.com/SwiftGen/SwiftGen): facilitar para gerar assets como Strings e images
- [swiftlint](https://github.com/realm/SwiftLint): ajudar a manter o código limpo e organizado

### Comentários adicionais
**TL;DR;** não tive tempo pra conseguir terminar o projeto
- A parte de layout não está finalizada, mas a estrutura de dados e passagem dos
mesmo está preparada pra isso
- A estrutura do carrossel é dinâmica, para lidar com o tipo `ImagePresentationViewModel`
- Parte visual não é o meu forte, por isso foquei mais onde gosto: arquitetura,
patterns e clean code
- Na minha máquina dos testes não rodaram (problema de 0 testes executados com 0 erros)