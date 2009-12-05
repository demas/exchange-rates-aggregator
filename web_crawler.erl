-module(web_crawler).
-import(xml_agregator).
-export([download_xml/1]).

download_xml(Url)->
    ibrowse:start(),
    io:format("~p~n", [Url]),
    {ok, _StatusCode, _Headers, WebPageText} = ibrowse:send_req(Url, [], get),
    Result = xml_agregator:process_xml(WebPageText),
    io:format("~p~n", [Result]).

