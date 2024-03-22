# Imagem Docker: erickdavi/zeroplus

Esta imagem Docker está disponível no DockerHub sob o nome [erickdavi/zeroplus](https://hub.docker.com/r/erickdavi/zeroplus) e possui a tag `1.0`.

## Tamanho da Imagem

A imagem `erickdavi/zeroplus:1.0` possui um tamanho de apenas **2.6MB**, o que a torna extremamente leve e ideal para ambientes com restrições de recursos.

## Descrição

Esta imagem foi criada do zero utilizando o `scratch` como base, o que significa que não há nenhum sistema operacional subjacente. Ela foi construída para fornecer um ambiente mínimo com um terminal e um conjunto básico de comandos built-in. O Busybox foi utilizado apenas como um emulador de terminal para este propósito.

## Camadas da Imagem

A imagem consiste em três camadas:

1. **CMD ["/bin/busybox" "sh"]**: A camada mais recente, que define o comando para iniciar um terminal usando o Busybox como shell.
2. **ENV PATH=/usr/local/sbin:/usr/local/bin:/usr…**: Define a variável de ambiente PATH para o shell.
3. **COPY /opt/ / # buildkit**: Copia os arquivos do diretório /opt/ para a raiz do sistema de arquivos na imagem.

## Análise de Vulnerabilidades

A imagem foi analisada em busca de vulnerabilidades usando o Docker Scout. Não foram detectadas vulnerabilidades nos pacotes incluídos na imagem.

## Próximas Versões

Estamos trabalhando para incluir um gerenciador de pacotes nas próximas versões da imagem, para oferecer mais funcionalidades e flexibilidade. Atualmente, a ênfase é na simplicidade e no mínimo necessário para um ambiente funcional.