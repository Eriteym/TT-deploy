  prometheus:
      image: prom/prometheus:v2.32.1
      volumes:
        - ./config/monitoring/Prometheus:/etc/prometheus
        - prometheus_data:/prometheus
      command:
        - '--config.file=/etc/prometheus/prometheus.yml'
        - '--storage.tsdb.path=/prometheus'
        - '--web.console.libraries=/etc/prometheus/console_libraries'
        - '--web.console.templates=/etc/prometheus/consoles'
        - '--storage.tsdb.retention.time=200h'
        - '--web.enable-lifecycle'
      restart: unless-stopped
      ports:
      - "9090:9090"
      networks:
        - timetracker

  grafana:
    image: grafana/grafana:8.3.3
    volumes:
      - grafana_data:/var/lib/grafana
      - ./config/monitoring/grafana/provisioning/dashboards:/etc/grafana/provisioning/dashboards
      - ./config/monitoring/grafana/provisioning/datasources:/etc/grafana/provisioning/datasources
    environment:
      - GF_SECURITY_ADMIN_USER=${ADMIN_USER:-admin}
      - GF_SECURITY_ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}
      - GF_USERS_ALLOW_SIGN_UP=false
    restart: unless-stopped
    ports:
      - "3000:3000"
    networks:
      - timetracker

  postgres_exporter:
    image: bitnami/postgres-exporter:latest
    depends_on:
      - postgresql
    environment:
      - DATA_SOURCE_URI=postgresql:5432/postgres?sslmode=disable
      - DATA_SOURCE_USER=timetracker
      - DATA_SOURCE_PASS={{ postgres_password }}
      #- PG_EXPORTER_EXTEND_QUERY_PATH=/etc/postgres_exporter/queries.yaml
   # volumes:
     # - ./config/monitoring/postgres_exporter:/etc/postgres_exporter
    ports:
      - "9187:9187"
    networks:
      - timetracker

  nginx_exporter:
    image: nginx/nginx-prometheus-exporter:latest
    ports:
      - "9113:9113"
    restart: unless-stopped
    command:
      - -nginx.scrape-uri=http://frontend/metrics
    networks:
      - timetracker
      
volumes:    
    prometheus_data: {}
    grafana_data: {}