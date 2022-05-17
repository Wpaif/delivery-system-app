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
      SQLite3
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

### Acompanhe o desenvolvimento clicando <a href="https://github.com/users/Wpaif/projects/1">aqui</a>
# Autor
Wilian Ferreira