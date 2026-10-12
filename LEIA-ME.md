# Cacheta: app Android

Jogo de cacheta para até 6 amigos, cada um no próprio celular. Não precisa de conta.

## Como gerar o APK (uma vez só)

1. Crie uma conta em github.com e um repositório **público** chamado `cacheta`.
2. Toque em **Add file → Upload files** e envie todo o conteúdo desta pasta, menos a pasta `.github`.
3. Toque em **Add file → Create new file**. No nome, escreva `.github/workflows/gerar-apk.yml` e cole o conteúdo do arquivo com esse nome. Salve com **Commit changes**.
4. Abra a aba **Actions**. A compilação começa sozinha e leva uns 5 minutos.
5. Quando ficar verde, abra a página inicial do repositório e toque em **Releases**. O arquivo `Cacheta.apk` estará lá.

## Como instalar nos celulares

1. Mande o link da página de Releases (ou o próprio APK) pelo WhatsApp.
2. Ao abrir o APK, o Android pede para **permitir instalar apps desta fonte**. Permita.
3. O Play Protect pode avisar que o app é desconhecido. Toque em **Instalar mesmo assim**.

## Atualizações

Qualquer mudança enviada ao repositório gera um APK novo em Releases. Ele instala por cima do antigo, sem perder nada.

## Como jogar

- Um amigo toca em **Criar mesa nova** e vira o anfitrião. A partida roda no celular dele.
- Os outros tocam em **Entrar** e digitam o código de 5 letras.
- O app mantém a tela ligada enquanto está aberto. O anfitrião não deve fechar o app durante a partida.
