# Copyright 2026 cz9dev
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Dockerfile
# Usa la imagen oficial de Jekyll
FROM jekyll/jekyll:latest

# Establece el directorio de trabajo
WORKDIR /srv/jekyll

# Copiar archivos de dependencias primero (mejor aprovechamiento de caché)
COPY Gemfile Gemfile.lock ./

# Copia los archivos del sitio
USER root
COPY --chown=jekyll:jekyll . .

# Instala bundler si es necesario
RUN gem install bundler

# Vuelve al usuario jekyll
USER jekyll

# Instala las dependencias del Gemfile
RUN bundle install

# Construye el sitio estático
RUN jekyll build

# Expone el puerto 4000 (default de Jekyll)
EXPOSE 4000

# Comando para servir el sitio
CMD ["jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]