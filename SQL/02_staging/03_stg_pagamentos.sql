-- View: staging.stg_pagamentos

-- DROP VIEW staging.stg_pagamentos;

CREATE OR REPLACE VIEW staging.stg_pagamentos
 AS
 SELECT pagamento_id,
    data_pagamento,
    valor_pagamento,
    upper(TRIM(BOTH FROM metodo_pagamento)) AS metodo_pagamento
   FROM raw.pagamentos;

ALTER TABLE staging.stg_pagamentos
    OWNER TO postgres;

