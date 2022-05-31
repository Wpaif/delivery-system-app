# Sistema de Entregas

# Tecnologias usadas
<table>
  <tr>
    <td>Ruby</td>
    <td>
      3.1.1
    </td>
  </tr>
  <tr>
    <td>Rails</td>
    <td>
      7.0.3
    </td>
  </tr>
  <tr>
    <td>Banco de dados</td>
    <td>
      SQLite3 1.4.2
    </td>
  </tr>
</table>

# Como executar localmente 

## 1° Clone o repositório e entre na pasta
```zsh
git clone https://github.com/Wpaif/delivery-system-app
cd delivery-system-app
```

## 2° Instale as dependências do projeto
```
bundle install
```

## 3° Execute o projeto

```
rails db:create
rails db:migrate
rails db:seed
rails server
```
Abra seu navegador em <a href="http://localhost:3000">http://localhost:3000</a>

# Como funciona a autenticação
## Área administrativa
<p>
  A área administrativa pode ser acessada por <a href="http://127.0.0.1:3000/admin"> /admin</a> .<br><br>
  Todos os administradores devem possuir um email com o dominio <b>@sistemadefretes.com.br</b>.
</p>

### Sobre as pesquisas de orçamento

<p>
  As pesquisas podem ser acessadas pela página do administrador e só funcionam se o usuário de uma das transportadoras já tiver cadastrado alguma configuração de preço e os prazos de entrega. <br> <br>
  Caso o administrador entre com valores não abrandigos pelas configurações a consulta não sera executada. Caso contrário ela será salva num histórico de pesquisas já feitas pelo administrador autenticado.
</p>

## Área do usuário
<p>
  A área do usuário pode ser acessada por <a href="http://127.0.0.1:3000/user"> /user</a>. <br><br>
  Todos os usuários devem possuir um email com o domínio de alguma transportadora que deve ter sido cadastrada previamente por um adiministrador.
</p>


### Acompanhe o desenvolvimento clicando <a href="https://github.com/users/Wpaif/projects/1">aqui</a>
# Autor
Wilian Ferreira