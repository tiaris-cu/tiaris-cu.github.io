# Usar la imagen oficial de Ruby 3.1 (compatible con Jekyll 4.2.2)
FROM ruby:3.1-slim

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Instalar yarn para manejar dependencias frontend (opcional pero recomendado)
RUN npm install -g yarn

# Crear directorio de trabajo
WORKDIR /srv/jekyll

# Copiar Gemfile y Gemfile.lock si existen
COPY Gemfile* ./

# Instalar Jekyll 4.2.2 y bundler
RUN gem install jekyll:4.2.2 bundler && \
    if [ -f Gemfile ]; then bundle install; fi

# Exponer el puerto por defecto de Jekyll
EXPOSE 4000

# Configurar el comando por defecto
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--force_polling"]