{% docs Таблица с моделями самолётов %}
# Table: aircrafts!!!!!
data from select
```sql
select * from {{ source('demo_src', 'aircrafts') }}
```

{% enddocs %}