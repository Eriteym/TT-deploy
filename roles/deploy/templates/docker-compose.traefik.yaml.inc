  traefik:
    image: traefik
    restart: always
    # Enables the web UI and tells Traefik to listen to docker
    command:
      - "--api.insecure=true"
      - "--entrypoints.web.address=:80"
{% if debug %}
      - "--log.level=DEBUG"
{% endif %}
      - "--providers.docker=true"
      - "--providers.docker.constraints=Label(`traefik.application`,`{{ traefik_application_label }}`)"
      - "--accesslog=true"
    networks:
      - timetracker
    ports:
      - "{{ traefik_http_port }}:80"
      - "{{ traefik_manage_port }}:8080"

    volumes:
{% if use_https %}
      - ./config/traefik/:/certs/:ro
{% endif %}
      # So that Traefik can listen to the Docker events
      - /var/run/docker.sock:/var/run/docker.sock
