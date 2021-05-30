
-- 1 up

create table if not exists languages
(
    languages_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    lan character varying(10) NOT NULL,
    lan_name character varying(100) NOT NULL,
    CONSTRAINT languages_pkey PRIMARY KEY (languages_pkey)
        USING INDEX TABLESPACE "webshop"
)TABLESPACE "translations";

CREATE TABLE IF NOT EXISTS translations
(
    translations_pkey SERIAL NOT NULL,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    insdatetime timestamp without time zone NOT NULL DEFAULT now(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    moddatetime timestamp without time zone NOT NULL DEFAULT now(),
    languages_fkey integer NOT NULL DEFAULT 0,
    module character varying(100)  NOT NULL,
    tag character varying(100) NOT NULL,
    translation text NOT NULL,
    CONSTRAINT translations_pkey PRIMARY KEY (translations_pkey)
        USING INDEX TABLESPACE webshop,
    CONSTRAINT languages_translations_fkey FOREIGN KEY (languages_fkey)
        REFERENCES languages (languages_pkey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
) TABLESPACE translations;

CREATE UNIQUE INDEX if not exists idx_translations_languages_fkey_module_tag_unique
    ON translations USING btree
        (languages_fkey, module, tag)
    TABLESPACE webshop;

CREATE  INDEX if not exists idx_translations_languages_fkey
    ON translations USING btree
        (languages_fkey)
    TABLESPACE translations;

INSERT INTO languages (lan, lan_name) VALUES ('dan', 'Danish');
INSERT INTO languages (lan, lan_name) VALUES ('fin', 'Finnish');
INSERT INTO languages (lan, lan_name) VALUES ('deu', 'German');
INSERT INTO languages (lan, lan_name) VALUES ('nor', 'Norwegian');
INSERT INTO languages (lan, lan_name) VALUES ('eng', 'English');
INSERT INTO languages (lan, lan_name) VALUES ('swe', 'Swedish');

-- 1 down

DROP TABLE IF EXISTS translations;

-- 2 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Warehouse_grid_fields', 'warehouses_pkey','Primärnyckel'),
(6, 'Warehouse_grid_fields', 'warehouse','Lager'),
(6, 'Warehouse_grid_fields', 'warehouse_name','Lager namn'),
(6, 'Warehouse_grid_fields', 'address1','Address 1'),
(6, 'Warehouse_grid_fields', 'address2','Address 2'),
(6, 'Warehouse_grid_fields', 'address3','Address 3'),
(6, 'Warehouse_grid_fields', 'city','Postort'),
(6, 'Warehouse_grid_fields', 'zipcode','Postnummer'),
(6, 'Warehouse_grid_fields', 'country','Land'),
(6, 'Warehouse_grid_fields', 'company','Företag'),
(6, 'Warehouse_grid_fields', 'company_name','Företagsnamn');

-- 2 down

-- 3 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Purchaseorder_grid_fields', 'order_head_pkey','Primärnyckel'),
(6, 'Purchaseorder_grid_fields', 'order_no','Order'),
(6, 'Purchaseorder_grid_fields', 'orderdate','Orderdatum'),
(6, 'Purchaseorder_grid_fields', 'username','Användare'),
(6, 'Purchaseorder_grid_fields', 'name','Leverantör');

-- 3 down

-- 4 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Companies_grid_fields', 'companies_pkey','Primärnyckel'),
(6, 'Companies_grid_fields', 'company','Företag'),
(6, 'Companies_grid_fields', 'name','Företag namn'),
(6, 'Companies_grid_fields', 'address1','Address 1'),
(6, 'Companies_grid_fields', 'address2','Address 2'),
(6, 'Companies_grid_fields', 'address3','Address 3'),
(6, 'Companies_grid_fields', 'city','Postort'),
(6, 'Companies_grid_fields', 'zipcode','Postnummer'),
(6, 'Companies_grid_fields', 'country','Land'),
(6, 'Companies_grid_fields', 'registrationnumber','Organisationsnummer');

-- 4 down

-- 5 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'companies', 'companies_pkey', 'Primärnyckel'),
(6, 'companies', 'company', 'Företag'),
(6, 'companies', 'name', 'Företag namn'),
(6, 'companies', 'registrationnumber', 'Organisationsnummer'),
(6, 'companies', 'homepage', 'Hemsida'),
(6, 'companies', 'phone', 'Telefon'),
(6, 'companies', 'menu_group','Företagstyp');

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'addresses', 'addresses_pkey', 'Primärnyckel'),
(6, 'addresses', 'name', 'Namn'),
(6, 'addresses', 'address1', 'Address'),
(6, 'addresses', 'address2', 'Address rad 2'),
(6, 'addresses', 'address3', 'Address rad 3'),
(6, 'addresses', 'city', 'Postort'),
(6, 'addresses', 'zipcode', 'Postnummer'),
(6, 'addresses', 'country', 'Land');

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'reference', 'reference_pkey', 'Primärnyckel'),
(6, 'reference', 'reference_name', 'Namn'),
(6, 'reference', 'reference_email', 'Email'),
(6, 'reference', 'reference_phone', 'Telefon');

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'reference_type', 'reference_type_pkey', 'Primärnyckel'),
(6, 'reference_type', 'reference_type', 'Refrenstyp');

-- 5 down

-- 6 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Users_search_grid_fields', 'users_pkey','Primärnyckel'),
(6, 'Users_search_grid_fields', 'userid','Användare'),
(6, 'Users_search_grid_fields', 'username','Namn'),
(6, 'Users_search_grid_fields', 'passwd','Lösenord'),
(6, 'Users_search_grid_fields', 'name','Företag');

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'users', 'users_pkey','Primärnyckel'),
(6, 'users', 'userid','Användare'),
(6, 'users', 'username','Namn'),
(6, 'users', 'passwd','Lösenord');


-- 6 down

-- 7 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'externalids', 'orionid','Kund id i Orion');

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Recyclingsystem', 'recyclingsystem','Demonteringssystem');

-- 7 down

-- 8 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'users', 'active','Aktiv'),
(6, 'Users_search_grid_fields', 'active','Aktiv');

-- 8 down

-- 9 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'order_item', 'order_items_pkey','Primärnyckel'),
(6, 'order_item', 'order_head_fkey','Orderhuvud'),
(6, 'order_item', 'itemno','Rad'),
(6, 'order_item', 'stockitem','Artikel'),
(6, 'order_item', 'description','Beskrivning'),
(6, 'order_item', 'quantity','Antal'),
(6, 'order_item', 'price','Pris'),
(6, 'order_item', 'deliverydate','Leverans'),
(6, 'order_item', 'rfq_note','Offertförfrågan text');

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'basket_item', 'basket_item_pkey','Primärnyckel'),
(6, 'basket_item', 'basket_fkey','Kundkorg'),
(6, 'basket_item', 'itemtype','Radtype'),
(6, 'basket_item', 'itemno','Rad'),
(6, 'basket_item', 'stockitem','Artikel'),
(6, 'basket_item', 'description','Beskrivning'),
(6, 'basket_item', 'quantity','Antal'),
(6, 'basket_item', 'price','Pris'),
(6, 'basket_item', 'externalref','Extern referens'),
(6, 'basket_item', 'expirydate','Utgångsdatum'),
(6, 'basket_item', 'supplier_fkey','Leverantör'),
(6, 'basket_item', 'rfq_note','Offertförfrågan');


-- 9 down

-- 10 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'order_head', 'order_head_pkey','Primärnyckel'),
(6, 'order_head', 'order_type','Order typ'),
(6, 'order_head', 'order_no','Order nummer'),
(6, 'order_head', 'orderdate','Order datum'),
(6, 'order_head', 'users_fkey','Användarnyckel'),
(6, 'order_head', 'companies_fkey','Företagsnyckel');

-- 10 down

-- 11 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'order_addresses', 'order_addresses_pkey','Primärnyckel'),
(6, 'order_addresses', 'name','Namn'),
(6, 'order_addresses', 'address1','Address'),
(6, 'order_addresses', 'address2','Address'),
(6, 'order_addresses', 'address3','Address'),
(6, 'order_addresses', 'city','Postort'),
(6, 'order_addresses', 'zipcode','Postnummer'),
(6, 'order_addresses', 'country','Land');

-- 11 down

-- 12 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'rfqs', 'rfqs_pkey','Primärnyckel'),
(6, 'rfqs', 'rfq_no','Förfrågan nr.'),
(6, 'rfqs', 'rfqstatus','Status'),
(6, 'rfqs', 'requestdate','Frågan datum'),
(6, 'rfqs', 'regplate','Reg. nummer / Bilmodell / Chassienummer'),
(6, 'rfqs', 'note','Delar'),
(6, 'rfqs', 'users_fkey','Användare'),
(6, 'rfqs', 'companies_fkey','Kund'),
(6, 'rfqs', 'supplier_fkey','Leverantör');

-- 12 down

-- 13 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'basket_item', 'freight','Frakt'),
(6, 'Basket_grid_fields', 'freight','Frakt'),
(6, 'order_item', 'freight','Frakt');

-- 13 down

-- 14 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'defaultfreight', 'freights_pkey','Primärnyckel'),
(6, 'defaultfreight', 'freightid','Frakt id'),
(6, 'defaultfreight', 'freight','Standardfrakt'),
(6, 'defaultfreight', 'companies_fkey','Företag'),
(6, 'freights', 'freights_pkey','Primärnyckel'),
(6, 'freights', 'freightid','Frakt id'),
(6, 'freights', 'freight','Frakt'),
(6, 'freights', 'companies_fkey','Företag');                                                                           ;

-- 14 down

-- 15 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Freight_grid_fields', 'freights_pkey','Primärnyckel'),
(6, 'Freight_grid_fields', 'codes_pkey','Primärnyckel'),
(6, 'Freight_grid_fields', 'code','Delkod'),
(6, 'Freight_grid_fields', 'code_text','Del'),
(6, 'Freight_grid_fields', 'freight','Frakt');

-- 15 down

-- 16 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'discounts', 'discount','Rabatt'),
(6, 'debts', 'debts','Får ej beställa');

-- 16 down

-- 17 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'search_document', 'id','Artikel id'),
(6, 'search_document', 'bid','Bud'),
(6, 'search_document', 'vinnumber','Chassienummer'),
(6, 'search_document', 'body','Kaross'),
(6, 'search_document', 'fuel','Drivmedel'),
(6, 'search_document', 'part','Artikelkod'),
(6, 'search_document', 'type','Typ'),
(6, 'search_document', 'year','År'),
(6, 'search_document', 'artno','Artikelnummer'),
(6, 'search_document', 'model','Modell'),
(6, 'search_document', 'orgno','Orginalnummer'),
(6, 'search_document', 'price','Pris'),
(6, 'search_document', 'Colour','Färg'),
(6, 'search_document', 'effect','Effekt'),
(6, 'search_document', 'remark','Anmärkning'),
(6, 'search_document', 'toyear','Till år'),
(6, 'search_document', 'update','Ändrad'),
(6, 'search_document', 'weight','Vikt'),
(6, 'search_document', 'carcode','Bilkod'),
(6, 'search_document', 'gearbox','Växellåda'),
(6, 'search_document', 'quality','Kvalitet'),
(6, 'search_document', 'carmodel','Bilmodell'),
(6, 'search_document', 'clothing','Klädsel'),
(6, 'search_document', 'fromyear','Från år'),
(6, 'search_document', 'warranty','Garanti'),
(6, 'search_document', 'bodycolor','Karossfärg'),
(6, 'search_document', 'kilometer','Kilometer'),
(6, 'search_document', 'modelcode','Modellkod'),
(6, 'search_document', 'stockitem','Artikel'),
(6, 'search_document', 'carbreaker','Demontering'),
(6, 'search_document', 'effectunit','Effektenhet'),
(6, 'search_document', 'dismantleid','Demonteringskort id'),
(6, 'search_document', 'dismantleno','Demonteringsnr.'),
(6, 'search_document', 'lagawarranty','Laga garanti'),
(6, 'search_document', 'wharehouseid','Lager id.'),
(6, 'search_document', 'bodycolorcode','Karossfärgkod'),
(6, 'search_document', 'qualityremark','Kvalitetsanm.'),
(6, 'search_document', 'cardescription','Bilbeskrivning'),
(6, 'search_document', 'originalnumber','Orginalnr'),
(6, 'search_document', 'articlenonumber','Artikelnr. num'),
(6, 'search_document', 'dismantlingdate','Demonteringsdatum'),
(6, 'search_document', 'dismantlingnote','Demonteringsanmärkning'),
(6, 'search_document', 'referencenumber','Referensnr.'),
(6, 'search_document', 'articlenophysical','Fysiskt artnr.'),
(6, 'search_document', 'visiblestockitemid','Visuellt art. nr.'),
(6, 'search_document', 'stockitemdescription','Artikelbeskrivning');


INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'RequestVehicle', 'Body','Kaross'),
(6, 'RequestVehicle', 'CarCode','Bilkod'),
(6, 'RequestVehicle', 'Colour','Färg'),
(6, 'RequestVehicle', 'Effect','Effekt'),
(6, 'RequestVehicle', 'EffectUnit','Effektenhet'),
(6, 'RequestVehicle', 'EngineCode','id'),
(6, 'RequestVehicle', 'FirstRegistration','Registrerad'),
(6, 'RequestVehicle', 'Fuel','Bränsle'),
(6, 'RequestVehicle', 'Fuel2','Bränsle 2'),
(6, 'RequestVehicle', 'GearboxType','Växellåda'),
(6, 'RequestVehicle', 'GroupCode','Gruppkod'),
(6, 'RequestVehicle', 'Length','Längd'),
(6, 'RequestVehicle', 'ManufacturingMonth','Tillverkningsmånad'),
(6, 'RequestVehicle', 'Model','Modell'),
(6, 'RequestVehicle', 'Note','Notering'),
(6, 'RequestVehicle', 'RegPlate','Reg nr.'),
(6, 'RequestVehicle', 'ServiceWeight','Tjänste vikt'),
(6, 'RequestVehicle', 'TireDimension','Däckdimension'),
(6, 'RequestVehicle', 'TotalWeight','Totalvikt'),
(6, 'RequestVehicle', 'VehicleType','Fordonstyp'),
(6, 'RequestVehicle', 'VinNumber','Chassienummer'),
(6, 'RequestVehicle', 'YearModel','Årsmodell');


-- 17 down

-- 18 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'RequestVehicle', 'EngineCodeEffect','Motorkod/Effekt'),
(6, 'RequestVehicle', 'ColourAndCode','Kulör/Färgkod'),
(6, 'RequestVehicle', 'Manufacturingdate','Tillverkad');

-- 18 down

-- 19 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'search_document', 'EngineCodeEffect','Motorkod/Effekt'),
(6, 'search_document', 'ColourAndCode','Kulör/Färgkod'),
(6, 'search_document', 'TireDimension','Däckdimension'),
(6, 'search_document', 'Manufacturingdate','Tillverkad');


-- 19 down

-- 20 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'search_document', 'company_name','Demontering'),
(6, 'search_document', 'company_phone','Telefon'),
(6, 'search_document', 'dissasemblydate','Lagringsdatum'),
(6, 'search_document', 'dissasemblyno','Demonteringsnr.'),
(6, 'search_document', 'company_email','E-post'),
(6, 'search_document', 'company_homepage','Hemsida');

-- 20 down

-- 21 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'search_document', 'regplate','Reg. nr.');

-- 21 down

-- 22 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'search_document', 'EngineTypeFuel','Motortyp/Drivmedel'),
(6, 'search_document', 'YearManufacturingdate','År/Tillverkad');

-- 22 down

-- 23 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'user_settings', 'Delsoek_path','Fenix sökfil'),
(6, 'user_settings', 'Max_Search_Results','Max sökresultat'),
(6, 'user_settings', 'Show_Price_With_Vat','Visa pris med moms'),
(6, 'user_settings', 'Home_route','Default start sida');


-- 23 down

-- 24 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'company_mails', 'company_mails','Företagsmail'),
(6, 'sales_mails', 'sales_mails','Mail försäljning'),
(6, 'request_mails', 'request_mails','Mail förfrågningar'),
(6, 'status_mails', 'status_mails','Mail orderstatus');
-- 24 down

-- 25 up
create table if not exists users
(
    users_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    userid varchar(100) not null,
    username varchar(100),
    passwd varchar(100) not null,
    CONSTRAINT users_pkey PRIMARY KEY (users_pkey)
);

CREATE UNIQUE INDEX  idx_users_userid
    ON public.users USING btree
        (userid );

create table if not exists menu
(
    menu_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    menu varchar not null,
    menu_path varchar not null,
    menu_order bigint not null,
    CONSTRAINT menu_pkey PRIMARY KEY (menu_pkey)
);


INSERT INTO menu (menu, menu_path, menu_order) VALUES ('Användare', '/app/users/list/', 1);

-- 25 down
-- 26 Up
INSERT INTO menu (menu, menu_path, menu_order) VALUES ('Data', '/yancy/', 3);
-- 26 down

-- 27 up


INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Rfqs_grid_fields', 'rfqs_pkey','Primärnyckel'),
(6, 'Rfqs_grid_fields', 'rfq_no','Nummer'),
(6, 'Rfqs_grid_fields', 'rfqstatus','Status'),
(6, 'Rfqs_grid_fields', 'requestdate','Förfrågandatum'),
(6, 'Rfqs_grid_fields', 'regplate','Reg. No.'),
(6, 'Rfqs_grid_fields', 'userid','Användare'),
(6, 'Rfqs_grid_fields', 'company','Företag'),
(6, 'Rfqs_grid_fields', 'supplier','Leverantör'),
(6, 'Rfqs_grid_fields', 'sent','Skickad'),
(6, 'Rfqs_grid_fields', 'sentat','Skickad datum');

-- 27 down

-- 28 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Messenger_grid_fields', 'message_que_pkey','Primärnyckel'),
(6, 'Messenger_grid_fields', 'batchid','Batch id'),
(6, 'Messenger_grid_fields', 'read','Läst'),
(6, 'Messenger_grid_fields', 'read_date','Läst datum'),
(6, 'Messenger_grid_fields', 'deleted','Borttagen'),
(6, 'Messenger_grid_fields', 'payload','Innehåll'),
(6, 'Messenger_grid_fields', 'system','System'),
(6, 'Messenger_grid_fields', 'company','Företag'),
(6, 'Messenger_grid_fields', 'companies_fkey','Företagsnyckel');

-- 28 down

-- 29 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Basket_Text_Messages', 'shoppingcart','Varukorg'),
(6, 'Basket_Text_Messages', 'checkout','Checkout'),
(6, 'Basket_Text_Messages', 'price','Pris'),
(6, 'Basket_Text_Messages', 'freight','Frakt'),
(6, 'Basket_Text_Messages', 'total','Summa excl. moms');

-- 29 down

-- 30 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Basket_Text_Messages', 'purchase','Beställ'),
(6, 'Basket_Text_Messages', 'deliveryaddress','Leveransadress'),
(6, 'Basket_Text_Messages', 'name','Namn'),
(6, 'Basket_Text_Messages', 'address1','Adress'),
(6, 'Basket_Text_Messages', 'address2','Adress'),
(6, 'Basket_Text_Messages', 'address3','Adress'),
(6, 'Basket_Text_Messages', 'city','Post ort'),
(6, 'Basket_Text_Messages', 'zipcode','Postnummer'),
(6, 'Basket_Text_Messages', 'country','Land'),
(6, 'Basket_Text_Messages', 'invoiceaddress','Faktureringsaddress'),
(6, 'Basket_Text_Messages', 'preeview','Förhandsgranska');


-- 30 down

-- 31 up
INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'Salesorder_grid_fields', 'order_type','Order typ'),
(6, 'Salesorder_grid_fields', 'order_no','Order nr.'),
(6, 'Salesorder_grid_fields', 'orderdate','Order datum'),
(6, 'Salesorder_grid_fields', 'userid','Referens'),
(6, 'Salesorder_grid_fields', 'name','Namn');

-- 31 down

-- 32 up

INSERT INTO translations (languages_fkey, module, tag, translation) VALUES
(6, 'purchase_order_head', 'purchase_order_head_pkey','Primärnyckel'),
(6, 'purchase_order_head', 'order_no','Order nummer'),
(6, 'purchase_order_head', 'orderdate','Order datum'),
(6, 'purchase_order_head', 'userid','Användare'),
(6, 'purchase_order_head', 'company','Företag');

-- 32 down
-- 33 up

CREATE TABLE if not exists mail_templates
(
    mail_templates_pkey serial NOT NULL,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    insdatetime timestamp without time zone NOT NULL DEFAULT now(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    moddatetime timestamp without time zone NOT NULL DEFAULT now(),
    mailtemplate VARCHAR NOT NULL UNIQUE,
    CONSTRAINT mail_templates_pkey PRIMARY KEY (mail_templates_pkey)
);

CREATE TABLE if not exists default_mail_templates
(
    default_mail_templates_pkey serial NOT NULL,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    insdatetime timestamp without time zone NOT NULL DEFAULT now(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    moddatetime timestamp without time zone NOT NULL DEFAULT now(),
    mail_templates_fkey bigint NOT NULL,
    header_value TEXT NOT NULL DEFAULT '',
    body_value TEXT NOT NULL DEFAULT '',
    footer_value TEXT NOT NULL DEFAULT '',
    languages_fkey integer NOT NULL DEFAULT 0,
    CONSTRAINT default_mail_templates_pkey PRIMARY KEY (default_mail_templates_pkey),
    CONSTRAINT default_mail_email_templates_fkey FOREIGN KEY (mail_templates_fkey)
        REFERENCES mail_templates (mail_templates_pkey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT default_mailer_mails_translations_fkey FOREIGN KEY (languages_fkey)
        REFERENCES languages (languages_pkey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
) ;

CREATE TABLE if not exists defined_mail_templates
(
    defined_mail_templates_pkey serial NOT NULL,
    editnum bigint NOT NULL DEFAULT 1,
    insby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    insdatetime timestamp without time zone NOT NULL DEFAULT now(),
    modby character varying(25) COLLATE pg_catalog."default" NOT NULL DEFAULT 'System'::character varying,
    moddatetime timestamp without time zone NOT NULL DEFAULT now(),
    mail_templates_fkey bigint NOT NULL,
    header_value TEXT NOT NULL DEFAULT '',
    body_value TEXT NOT NULL DEFAULT '',
    footer_value TEXT NOT NULL DEFAULT '',
    company VARCHAR NOT NULL DEFAULT '',
    userid VARCHAR NOT NULL DEFAULT '',
    languages_fkey integer NOT NULL DEFAULT 0,
    CONSTRAINT defined_mail_templates_pkey PRIMARY KEY (defined_mail_templates_pkey),
    CONSTRAINT default_mailer_mails_mailer_fkey FOREIGN KEY (mail_templates_fkey)
        REFERENCES mail_templates (mail_templates_pkey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE,
    CONSTRAINT defined_mailer_mails_translations_fkey FOREIGN KEY (languages_fkey)
        REFERENCES languages (languages_pkey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        DEFERRABLE
);

-- 33 down