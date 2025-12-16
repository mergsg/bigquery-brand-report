# bigquery-brand-report
Sistema automatizado de reporting para analizar el rendimiento de una marca dentro de un marketplace de e-commerce. La solución combina BigQuery, SQL parametrizable y Python (pandas + matplotlib) para generar métricas clave, visualizaciones estandarizadas y archivos CSV estructurados en una carpeta.

El objetivo es permitir que cualquier Brand Manager pueda obtener un análisis completo de su marca modificando únicamente tres parámetros: _brand, start_date y end_date_.

El sistema extrae, transforma, analiza y visualiza datos del dataset público _thelook_ecommerce_ de BigQuery.

**Objetivos**
- Reducir el trabajo manual en reporting semanal.
- Estandarizar métricas y visualizaciones.
- Proporcionar un flujo replicable y escalable para múltiples marcas.
- Permitir que el análisis se regenere automáticamente con nuevas fechas o marcas.

**Arquitectura general del sistema**
El proyecto sigue la estructura propuesta en el caso de negocio:
_brand_report/
│
├── sql/
│   └── brand_analysis.sql      # Consulta SQL parametrizable
│
├── brand_report.ipynb          # Notebook principal
│
└── output/                     # Se genera automáticamente
    └── YYYYMMDD_brand_Name/    # CSV + PNG por ejecución_

**Funcionamiento del sistema**

1. Parametrización
El usuario edita únicamente:
_params = {
    "brand": "Allegra K",
    "start_date": "2024-10-01",
    "end_date": "2025-09-30"
}_

2. Consulta SQL dinámica
A partir del archivo _brand_analysis.sql_, la función _load_sql_with_params()_ reemplaza los parámetros y construye la query final.

3. Extracción de datos desde BigQuery
_df = client.query(sql).to_dataframe()_

4. Transformación y creación de métricas
- Revenue
- Órdenes únicas
- Clientes únicos
- Profit
- AOV
-  Crecimiento mensual del revenue

5. Exportación automática
- 4 archivos CSV
- 4 visualizaciones en PNG
- Todo dentro de una carpeta con nombre: _YYYYMMDD_brand_Allegra_K_

**Análisis generados**

1. Monthly Performance — Evolución temporal
- Revenue total por mes
- Órdenes únicas
- Clientes únicos
- Profit total
- AOV
- Tasa de crecimiento mensual (%)
- Gráfico: línea temporal en gris

2. Category Analysis — Top 10 categorías por revenue
- Revenue total
- Órdenes únicas
- Profit
- Gráfico: barras horizontales

3. Geographic Analysis — Top 10 países por revenue
- Revenue
- Clientes únicos
- Órdenes únicas
- Gráfico: barras verticales

4. Price Distribution — Distribución de precios de venta
- Estadísticos descriptivos: min, Q1, mediana, Q3, max, media, std
- Gráfico: histograma con 30 bins

**Tecnologías utilizadas**
- Python: pandas, numpy, matplotlib, os, datetime
- Google BigQuery: extracción de datos y procesamiento distribuido
- SQL parametrizable
- Jupyter Notebook para el flujo analítico
- Estructuración automática de archivos
