# 👨‍💻 Aplicativo Power Up Blog

>*Read this in other languages: [Pt-BR](README.md), [English](README.en.md) and [Spanish](README.es.md).*

Este é um aplicativo Flutter que tem como objetivo listar os posts do blog [Power Up](https://powerupblog3.wordpress.com/) provenientes da API do WordPress. O aplicativo possui duas telas principais: a tela inicial (**HomePage**) 🏠 e a tela de detalhes de um post específico (**PostPage**) 📄.

Para a comunicação com a API, é utilizado o pacote [`http`](https://pub.dev/packages/http) 🌐. Além disso, para exibir as imagens dos posts em cache, assim evitando o atraso na exibição das mesmas, é utilizado o pacote [`cached_network_image`](https://pub.dev/packages/cached_network_image) 📸. O pacote [`shimmer`](https://pub.dev/packages/shimmer) ✨ é utilizado para exibir um efeito de loading (conhecido também  como "**Skeleton**") enquanto os dados são carregados.

A classe **HomePage** é um StatefulWidget que representa a tela inicial do aplicativo. Nessa tela, é exibida uma lista de blogs, sendo que cada item é representado por um `Card`. Ao final da lista, é exibido um efeito de loading (utilizando o `shimmer`) enquanto novos blogs são carregados. O usuário pode atualizar a lista de blogs através do gesto de "puxar para baixo".

O método `fetchBlogs` é responsável por buscar os dados na API e atualizar a lista de blogs exibidos na tela. A cada vez que o usuário chega ao final da lista, é feita uma nova requisição para buscar mais blogs (se houver).

Por fim, a tela de detalhes de um blog específico é exibida através da classe `PostPage`. Nessa tela, é exibido o **título** e o **conteúdo** do blog selecionado. Além disso, são exibidas informações adicionais, como o **nome do autor** e a **data de publicação**. A imagem principal do blog é exibida em um [`Hero widget`](https://docs.flutter.dev/development/ui/animations/hero-animations), permitindo uma animação suave entre a transição de telas. 🚀

## Como gerar o APK ou .IPA do projeto

#### Pré-requisitos 🔧

Antes de começar, certifique-se de que as seguintes ferramentas estejam instaladas em sua máquina:

- 🚀 [Flutter SDK](https://flutter.dev/docs/get-started/install)
- 📱 [Android Studio](https://developer.android.com/studio) (para gerar um arquivo APK)
- 🍎 [Xcode](https://developer.apple.com/xcode/) (para gerar um arquivo IPA)

#### Gerando um arquivo APK 📦

Para gerar um arquivo APK de um projeto Flutter existente, siga estas etapas:

1. Abra o terminal e navegue até o diretório do projeto Flutter usando o comando `cd /path/to/project`.

2. Execute o comando `flutter build apk --`. Isso construirá o aplicativo e gerará um arquivo APK no diretório do projeto `build/app/outputs/flutter-apk/app-release.apk`. (Caso não funcione, certifique-se de que todas as dependencias do Flutter foram instaladas. Para verificar, execute `flutter doctor` no terminal).

3. Conecte um dispositivo Android ao computador usando um cabo USB.

4. Execute o comando `flutter devices` para listar os dispositivos Android conectados.

5. Identifique o ID do dispositivo Android que você deseja usar para executar o aplicativo.

6. Execute o comando `flutter run -d <id-do-dispositivo>` para instalar e executar o aplicativo no dispositivo Android conectado.

#### Gerando um arquivo IPA 📦

Para gerar um arquivo IPA de um projeto Flutter existente, siga estas etapas:

1. Abra o terminal e navegue até o diretório do projeto Flutter usando o comando `cd /path/to/project`.

2. Execute o comando `flutter build ios`. Isso construirá o aplicativo e gerará um arquivo IPA no diretório `build/ios/archive`.

3. Abra o arquivo `.xcworkspace` que foi gerado na etapa anterior no Xcode.

4. Conecte um dispositivo iOS ao computador usando um cabo USB.

5. No Xcode, selecione o dispositivo iOS conectado como destino de execução.

6. Clique no botão "Run" para instalar e executar o aplicativo no dispositivo iOS.

Se tiver alguma dúvida ou sugestão, sinta-se à vontade para criar uma _issue_ ou enviar um _pull request_.

Se você gostou deste projeto, por favor, deixe uma ⭐️ para apoiá-lo.

Obrigado novamente por seu interesse e espero vê-lo em breve! 👋

<br><br>

>_Made with :heart: by Lucas Pereira_