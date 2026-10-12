#!/usr/bin/env bash
# Compila o app Cacheta (Android) e gera Cacheta.apk assinado na raiz do repositório.
set -euo pipefail
etapa(){ echo; echo "=== $* ==="; }

etapa "Ambiente"
node -v; npm -v; java -version 2>&1 | head -1
echo "ANDROID_HOME=${ANDROID_HOME:-}"

etapa "Instalar dependências"
npm install --no-audit --no-fund --legacy-peer-deps

etapa "Embutir a biblioteca de conexão"
cp node_modules/peerjs/dist/peerjs.min.js www/

etapa "Criar projeto Android"
rm -rf android
npx cap add android

etapa "Manter a tela ligada"
MA="$(find android/app/src/main/java -name MainActivity.java | head -1)"
echo "MainActivity: $MA"
cp android-extra/MainActivity.java "$MA"

etapa "Gerar ícones"
npx --yes @capacitor/assets@3 generate --android \
  --iconBackgroundColor '#0a0a0b' --iconBackgroundColorDark '#0a0a0b' \
  || echo "AVISO: não deu para gerar os ícones; o app usa o ícone padrão."

etapa "Numerar a versão"
N="${RUN_NUMBER:-1}"
sed -i -E "s/versionCode [0-9]+/versionCode $N/" android/app/build.gradle
sed -i -E "s/versionName \"[^\"]*\"/versionName \"1.$N\"/" android/app/build.gradle
grep -nE "versionCode|versionName" android/app/build.gradle

etapa "Sincronizar"
npx cap sync android

etapa "Compilar"
( cd android && chmod +x gradlew && ./gradlew assembleRelease --no-daemon --stacktrace )

etapa "Assinar"
UNSIGNED="$(find android/app/build/outputs/apk/release -name '*.apk' | head -1)"
echo "APK gerado: $UNSIGNED"
BT="$ANDROID_HOME/build-tools/$(ls "$ANDROID_HOME/build-tools" | sort -V | tail -1)"
echo "build-tools: $BT"
"$BT/zipalign" -p -f 4 "$UNSIGNED" alinhado.apk
"$BT/apksigner" sign \
  --ks keystore/cacheta.p12 --ks-type PKCS12 \
  --ks-pass pass:cacheta-amigos --key-pass pass:cacheta-amigos \
  --ks-key-alias cacheta \
  --out Cacheta.apk alinhado.apk
"$BT/apksigner" verify Cacheta.apk
ls -la Cacheta.apk
etapa "Pronto"
