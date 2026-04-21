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

# Dockerfile (versión simplificada que ha funcionado para otros)
FROM jekyll/jekyll:4.2.2

WORKDIR /srv/jekyll

COPY Gemfile* ./

USER root
RUN chown -R jekyll:jekyll /srv/jekyll
USER jekyll

# Instalar gems localmente
RUN bundle install --path vendor/bundle

COPY --chown=jekyll:jekyll . .

# Usar bundle exec con path explícito
#RUN bundle exec --path vendor/bundle jekyll build
RUN bundle exec jekyll build

EXPOSE 4000

CMD ["bundle", "exec", "--path", "vendor/bundle", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]