from app import create_app

app = create_app()

if __name__ == '__main__':
    # O debug=True é ótimo para desenvolvimento, pois reinicia o servidor 
    # automaticamente toda vez que você salva um arquivo.
    app.run(debug=True, host='0.0.0.0', port=5000)