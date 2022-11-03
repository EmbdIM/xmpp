%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(deribit_codec).

-compile(export_all).

do_decode(<<"bot">>, <<"urn:deribit:system">>, El,
          Opts) ->
    decode_bot(<<"urn:deribit:system">>, Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() -> [{<<"bot">>, <<"urn:deribit:system">>}].

do_encode({bot, _} = Bot, TopXMLNS) ->
    encode_bot(Bot, TopXMLNS).

do_get_name({bot, _}) -> <<"bot">>.

do_get_ns({bot, _}) -> <<"urn:deribit:system">>.

pp(bot, 1) -> [name];
pp(_, _) -> no.

records() -> [{bot, 1}].

decode_bot(__TopXMLNS, __Opts,
           {xmlel, <<"bot">>, _attrs, _els}) ->
    Name = decode_bot_attrs(__TopXMLNS, _attrs, undefined),
    {bot, Name}.

decode_bot_attrs(__TopXMLNS,
                 [{<<"name">>, _val} | _attrs], _Name) ->
    decode_bot_attrs(__TopXMLNS, _attrs, _val);
decode_bot_attrs(__TopXMLNS, [_ | _attrs], Name) ->
    decode_bot_attrs(__TopXMLNS, _attrs, Name);
decode_bot_attrs(__TopXMLNS, [], Name) ->
    decode_bot_attr_name(__TopXMLNS, Name).

encode_bot({bot, Name}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:deribit:system">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_bot_attr_name(Name,
                                  xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                             __TopXMLNS)),
    {xmlel, <<"bot">>, _attrs, _els}.

decode_bot_attr_name(__TopXMLNS, undefined) -> <<>>;
decode_bot_attr_name(__TopXMLNS, _val) -> _val.

encode_bot_attr_name(<<>>, _acc) -> _acc;
encode_bot_attr_name(_val, _acc) ->
    [{<<"name">>, _val} | _acc].
