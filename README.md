# 👨‍💻 Aplicativo Power Up Blog

>*Read this in other languages: [Pt-BR](README.md), [English](README.en.md) and [Spanish](README.es.md).*

Este é um aplicativo Flutter que tem como objetivo listar os posts do blog [Power Up](https://powerupblog3.wordpress.com/) provenientes da API do WordPress. O aplicativo possui duas telas principais: a tela inicial (**HomePage**) 🏠 e a tela de detalhes de um post específico (**PostPage**) 📄.

Para a comunicação com a API, é utilizado o pacote [`http`](https://pub.dev/packages/http) 🌐. Além disso, para exibir as imagens dos posts em cache, assim evitando o atraso na exibição das mesmas, é utilizado o pacote [`cached_network_image`](https://pub.dev/packages/cached_network_image) 📸. O pacote [`shimmer`](https://pub.dev/packages/shimmer) ✨ é utilizado para exibir um efeito de loading (conhecido também  como "**Skeleton**") enquanto os dados são carregados.

A classe **HomePage** é um StatefulWidget que representa a tela inicial do aplicativo. Ao final da lista, é exibido um efeito de loading (utilizando o `shimmer`) enquanto novos posts são carregados. O usuário pode atualizar a lista de posts através do gesto de "puxar para baixo".

O método `fetchPosts` é responsável por buscar os dados na API e atualizar a lista de posts exibidos na tela. A cada vez que o usuário chega ao final da lista, é feita uma nova requisição para buscar mais posts (se houver).

Por fim, a tela de detalhes de um post específico é exibida através da classe `PostPage`. Nessa tela, é exibido o **título** e o **conteúdo** do post selecionado. Além disso, são exibidas informações adicionais, como o **nome do autor** e a **data de publicação**. 🚀

## Como gerar o APK ou .IPA do projeto

#### Pré-requisitos 🔧

Antes de começar, certifique-se de que as seguintes ferramentas estejam instaladas em sua máquina:

- 🚀 [Flutter SDK](https://flutter.dev/docs/get-started/install)
- 📱 [Android Studio](https://developer.android.com/studio) (para gerar um arquivo APK)
- 🍎 [Xcode](https://developer.apple.com/xcode/) (para gerar um arquivo IPA)

#### Gerando um arquivo APK 📦

>Caso queira baixar o apk direto, entre na [Release](https://github.com/Lucasbjpereira/powerupblog/releases/tag/release) para fazer o download.

>Obs: Certifique-se que você esteja com a opção de instalar aplicativos de fontes desconhecidas ativada no seu dispositivo Android. Para isso, vá em **Configurações > Segurança > Fontes desconhecidas**.

Para gerar um arquivo APK do projeto, siga estas etapas:

1. Abra o terminal e navegue até o diretório do projeto Flutter usando o comando `cd /path/to/project`.

2. Execute o comando `flutter build apk --`. Isso construirá o aplicativo e gerará um arquivo APK no diretório do projeto `build/app/outputs/flutter-apk/app-release.apk`. (Caso não funcione, certifique-se de que todas as dependencias do Flutter foram instaladas. Para verificar, execute `flutter doctor` no terminal).

3. Conecte um dispositivo Android ao computador usando um cabo USB.

4. Execute o comando `flutter devices` para listar os dispositivos Android conectados.

5. Identifique o ID do dispositivo Android que você deseja usar para executar o aplicativo.

6. Execute o comando `flutter run -d <id-do-dispositivo>` para instalar e executar o aplicativo no dispositivo Android conectado.

#### Gerando um arquivo IPA 📦
>Caso queira baixar o .ipa direto, entre na [Release](https://github.com/Lucasbjpereira/powerupblog/releases/tag/release) para fazer o download.

>**Obs:** Já que o app ainda não está na App Store, para o .ipa ser instalado via download em sites externos, o .ipa precisa ser enviado em sites de _Development & In-house_ como o [Diawi](https://www.diawi.com/) por exemplo. 

>E para isso, certifique-se que você esteja com a opção de instalar aplicativos de fontes desconhecidas ativada no seu dispositivo IOS.

Para gerar um arquivo IPA do projeto, siga estas etapas:

1. Abra o terminal e navegue até o diretório do projeto Flutter usando o comando `cd /path/to/project`.

2. Execute o comando `flutter build ios`. Isso construirá o aplicativo e gerará um arquivo IPA no diretório `build/ios/archive` (Caso não funcione, certifique-se de que todas as dependencias do Flutter foram instaladas. Para verificar, execute `flutter doctor` no terminal).
_Obs: Certifique-se que você esteja com a conta de desenvolvedor ativada no xcode_.

3. Conecte um dispositivo iOS ao computador usando um cabo USB.

4. Execute o comando `flutter devices` para listar os dispositivos Android conectados.

5. Identifique o ID do dispositivo Android que você deseja usar para executar o aplicativo.

6. Execute o comando `flutter run -d <id-do-dispositivo>` para instalar e executar o aplicativo no dispositivo Android conectado.

Se tiver alguma dúvida ou sugestão, sinta-se à vontade para criar uma _issue_ ou enviar um _pull request_.

Se você gostou deste projeto, por favor, deixe uma ⭐️ para apoiá-lo.

Obrigado novamente por seu interesse e espero vê-lo em breve! 👋

>_Criado durante o processo seletivo da [_ModalGR_](https://modalgr.com.br/)_

<br><br>
_Made with :heart: by Lucas Pereira_