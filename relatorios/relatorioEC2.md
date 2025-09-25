# Relatório - Deploy EC2 e ServeRest

## Passo-a-passo para subir o EC2

### 1. Configuração da Instância EC2
- Acesso ao console AWS
- Seleção da AMI (Amazon Linux 2)
- Escolha do tipo de instância (t2.micro)
- Configuração de security groups (portas 22, 3000)
- Criação/seleção de key pair

### 2. Conexão com a Instância
- Download da chave privada (.pem)
- Conexão via SSH: `ssh -i "chave.pem" ec2-user@ip-publico`

## Comandos Utilizados (Executados um de cada vez)

### 1. Atualização do Sistema
```bash
sudo yum update -y
```

### 2. Instalação de Dependências
```bash
sudo yum install gcc-c++ make -y
```

### 3. Verificação do cURL
```bash
curl --version
```

### 4. Instalação do cURL (caso necessário)
```bash
sudo yum install curl
```

### 5. Criação do Diretório
```bash
mkdir serverestApi
cd serverestApi
```

### 6. Instalação do Node.js
**Comando inicial (não funcionou no Amazon Linux):**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo yum install -y nodejs
```

**Comando alternativo utilizado:**
```bash
sudo yum install -y nodejs
```

### 7. Execução da ServeRest
```bash
npx serverest@latest
```

## Desafios Superados

### 1. Incompatibilidade de Comando Node.js
**Problema:** O comando `curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo yum install -y nodejs` não funcionou pois é específico para distribuições Debian/Ubuntu, mas estávamos usando Amazon Linux

**Solução:** Com o auxílio da squad, encontramos a solução utilizando apenas `sudo yum install -y nodejs`, que é o comando correto para sistemas baseados em Red Hat/Amazon Linux

## Verificação Final
- ServeRest executando com sucesso
- API acessível via browser
- Todos os endpoints funcionando corretamente