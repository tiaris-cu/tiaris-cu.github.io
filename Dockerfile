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
FROM jekyll/jekyll:4.2.2

# Establece el directorio de trabajo
WORKDIR /srv/jekyll

# Copiar archivos de dependencias primero (mejor aprovechamiento de caché)
COPY Gemfile Gemfile.lock ./

# Configurar Bundler para instalar gems LOCALMENTE en vendor/bundle
RUN bundle config set --local path 'vendor/bundle' && \
    bundle install

# Copiar el resto del código fuente
COPY --chown=jekyll:jekyll . .

# Construir el sitio
RUN bundle exec jekyll build

EXPOSE 4000

# Servir el sitio usando bundle exec
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]