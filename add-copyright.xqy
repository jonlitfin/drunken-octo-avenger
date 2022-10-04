xquery version "1.0-ml";
import module namespace cpf = "http://marklogic.com/cpf" 
  at "/MarkLogic/cpf/cpf.xqy";
declare variable $cpf:document-uri as xs:string external;
declare variable $cpf:transition as node() external;
if (cpf:check-transition($cpf:document-uri,$cpf:transition)) then try {
  let $doc := fn:doc( $cpf:document-uri )
  return
      xdmp:node-insert-child( 
        $doc/book,
        <copyright>
          <year>2010</year>
          <holder>The Publisher</holder>
        </copyright>),
      xdmp:log( "add copyright ran OK" ),
      cpf:success( $cpf:document-uri, $cpf:transition, () )
}
catch ($e) {
  cpf:failure( $cpf:document-uri, $cpf:transition, $e, () )
}
else ()
