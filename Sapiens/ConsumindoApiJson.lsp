             @Consultor: Pedro Paulo Aleixo@
 
  
  definir alfa TOKEN;
  definir alfa HTTP;
  definir alfa JSON;
  definir alfa JSON2;
  definir alfa login;
  definir alfa url2;
  definir alfa url;
  definir alfa approval_date;
  definir alfa status;
  definir alfa title;
  definir alfa datdes;
  definir alfa tipo;
  definir alfa valor;
  definir alfa obs;
  definir alfa acodapr;
  Definir alfa aTipo;
  definir alfa aMet;
  definir alfa adesmet;
  DEFINIR ALFA APOST;
  DEFINIR ALFA AHTTP;
  DEFINIR ALFA ADATA;
  DEFINIR ALFA AHTTP_TOKEN;
  DEFINIR ALFA ATOKEN;
  DEFINIR ALFA ARETORNO;
  DEFINIR ALFA ARETORNO_BASE;
  DEFINIR ALFA AAUX;
  DEFINIR NUMERO NPOSFIM;
  DEFINIR NUMERO NCASAS;
  DEFINIR NUMERO NCODIGO;
  DEFINIR ALFA AAUTORIZACAO;
  DEFINIR NUMERO NPOSINI_BASE;
  DEFINIR NUMERO NPOSFIM_BASE;
  DEFINIR NUMERO NCASAS_BASE;
  DEFINIR ALFA APOST;
  DEFINIR ALFA AHTTP;
  DEFINIR ALFA ADATA;
  DEFINIR ALFA AHTTP_TOKEN;
  DEFINIR ALFA ATOKEN;
  DEFINIR ALFA ARETORNO;
  DEFINIR ALFA ARETORNO_BASE;
  DEFINIR ALFA AAUX;
  DEFINIR NUMERO NPOSINI;
  DEFINIR NUMERO NPOSFIM;
  DEFINIR NUMERO NCASAS;
  DEFINIR NUMERO NCODIGO;
  DEFINIR ALFA AAUTORIZACAO;
  DEFINIR NUMERO NPOSINI_BASE;
  DEFINIR NUMERO NPOSFIM_BASE;
  DEFINIR NUMERO NCASAS_BASE;
  DEFINIR ALFA APOST;
  DEFINIR ALFA AHTTP;
  DEFINIR ALFA ADATA;
  DEFINIR ALFA AHTTP_TOKEN;
  DEFINIR ALFA ATOKEN;
  DEFINIR ALFA ARETORNO;
  DEFINIR ALFA ARETORNO_BASE;
  DEFINIR ALFA AAUX;
  DEFINIR NUMERO NPOSINI;
  DEFINIR NUMERO NPOSFIM;
  DEFINIR NUMERO NCASAS;
  DEFINIR NUMERO NCODIGO;
  DEFINIR ALFA AAUTORIZACAO;
  DEFINIR NUMERO NPOSINI_BASE;
  DEFINIR NUMERO NPOSFIM_BASE;
  DEFINIR NUMERO NCASAS_BASE;
  definir alfa axpenseid;
  definir alfa adatdes;
  
  acodapr = USU_TCAD_APROV_USU_CODAPROV;
 

  @Definando as rotas e parametros da requisição@
  @URL2 =  "https://api.vexpenses.com/v2/expenses/"+ acodapr;@
  @URL2 =  "https://dev.api.vexpenses.com/v2/reports/"+ acodapr + "?include=expenses";@
  URL2 = "https://api.vexpenses.com/v2/reports/"+acodapr +"?include=expenses"; 
  TOKEN = "2XYLCmXiEANPymOTlRA4xx8bgaqJoV3DxoTAnK1u5cSEqK5NSuAudlRNIVn2";

  @Atribuição verbos HTTP@
  httpObjeto(HTTP);
  HttpAlteraCabecalhoRequisicao(HTTP, "Content-Type", "application/json");
  HttpAlteraCabecalhoRequisicao(HTTP, "Authorization", TOKEN);
  httpGet(HTTP, URL2, JSON2);

/*@Consumindo campos da API reports@
ValorElementoJson(JSON, "data", "approval_date", approval_date);
ValorElementoJson(JSON, "data", "status", status);*/
  
  @Consumindo campos da API Expenses simplificado@
  

  definir numero nLista;
  definir alfa cAchou;
  definir alfa ARRAY;
  definir alfa aObteve;
  definir alfa astatus;
  astatus = "Aprovado";
  
  listaRegraCriarLista(nLista);
  valorElementoJson(JSON2, "data", "expenses", ARRAY);
  listaRegraCarregarJson(nLista, ARRAY, "data", "expense_id;date;title;expense_type_id;value;observation;payment_method_id");
  listaRegraPrimeiro(nLista, cAchou);

  enquanto(cAchou = "S")
  {
        AtualizarTabela("USU_TCAD_APROV"); 
 
      ListaRegraObterValorNumero(nLista, "expense_id"       , expense_id,  aObteve); se(aObteve = "N")  expense_id = 0;
      listaRegraObterValorAlfa  (nLista, "title"            , title     ,  aObteve); se(aObteve = "N")  title = "";
      listaRegraObterValorAlfa  (nLista, "date"             , adatdes   ,  aObteve); se(aObteve = "N")  adatdes = "";       
      listaRegraObterValorAlfa  (nLista, "expense_type_id"  , tipo      ,  aObteve); se(aObteve = "N")  tipo = "";      
      listaRegraObterValorAlfa  (nLista, "value"            , valor     ,  aObteve); se(aObteve = "N")  valor = "";      
      listaRegraObterValorAlfa  (nLista, "observation"      , obs       ,  aObteve); se(aObteve = "N")  obs = "Sem resultado";      
      listaRegraObterValorAlfa  (nLista, "payment_method_id", aMet      ,  aObteve); se(aObteve = "N")  aMet = ""; 
                                  
      
    /*
      USU_TCAD_APROV_USU_TITULO = title;
      USU_TCAD_APROV_USU_DATDES = adatdes;
      USU_TCAD_APROV_USU_VALOR = valor;
      USU_TCAD_APROV_USU_OBS =  obs;
      USU_TCAD_APROV_USU_DatGer = datsis;
      USU_TCAD_APROV_USU_TIPO = tipo;
      USU_TCAD_APROV_USU_DESTIP = atipo;
      USU_TCAD_APROV_USU_CodPag = aMet;  */
      
      
      ExecSql "INSERT INTO USU_TCAD_APROV   \
       (USU_CodAprov,                      \
        USU_Titulo,                         \
        USU_DatDes,                         \  
        USU_Valor,                          \   
        USU_Obs,                            \    
        USU_Tipo,                           \     
        USU_CodPag,                         \  
        USU_EXPENSE_ID,                     \
        USU_STATUS)                         \
       VALUES                               \      
       (:acodapr,                           \          
       :title,                              \       
       :adatdes,                            \           
       :valor,                              \             
       :obs,                                \             
       :tipo,                               \
       :amet,                                \
       :expense_id,                           \
       :astatus)";
       


      ListaRegraProximo(nLista, cAchou); @ITERAÇÃO@
      
  
  }
  
 AtualizarTabela("USU_TCAD_APROV");
    
      
/*  
  ValorElementoJson(JSON2, "data;expenses;data", "expense_id", axpenseid);
  ValorElementoJson(JSON2, "data;expenses;data", "title", title);
  ValorElementoJson(JSON2, "data;expenses;data", "date", adatdes);
  ValorElementoJson(JSON2, "data;expenses;data", "expense_type_id", tipo);
  ValorElementoJson(JSON2, "data;expenses;data", "value", valor);
  ValorElementoJson(JSON2, "data;expenses;data", "observation", obs);
  ValorElementoJson(JSON2, "data;expenses;data", "payment_method_id", aMet); */

  @ValorElementoJson(JSON2, "data;expense;data", "expense_id", axpenseid);@