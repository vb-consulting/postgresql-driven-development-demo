DROP INDEX IF EXISTS public.idx_business_areas_name_normalized;
DROP TABLE IF EXISTS public.business_areas;

CREATE TABLE public.business_areas (
    id smallint NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name character varying NOT NULL,
    name_normalized character varying NOT NULL
);

COMMENT ON TABLE public.business_areas IS 'Business areas that companies may be invloved.';
COMMENT ON COLUMN public.business_areas.name_normalized IS 'lowercased';
CREATE UNIQUE INDEX idx_business_areas_name_normalized ON public.business_areas USING btree (name_normalized);
