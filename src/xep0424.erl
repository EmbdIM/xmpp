%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(xep0424).

-compile(export_all).

do_decode(<<"replace">>,
          <<"urn:xmpp:message-correct:0">>, El, Opts) ->
    decode_replace(<<"urn:xmpp:message-correct:0">>,
                   Opts,
                   El);
do_decode(<<"retract">>,
          <<"urn:xmpp:message-retract:0">>, El, Opts) ->
    decode_retract(<<"urn:xmpp:message-retract:0">>,
                   Opts,
                   El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"replace">>, <<"urn:xmpp:message-correct:0">>},
     {<<"retract">>, <<"urn:xmpp:message-retract:0">>}].

do_encode({retract} = Retract, TopXMLNS) ->
    encode_retract(Retract, TopXMLNS);
do_encode({replace, _} = Replace, TopXMLNS) ->
    encode_replace(Replace, TopXMLNS).

do_get_name({replace, _}) -> <<"replace">>;
do_get_name({retract}) -> <<"retract">>.

do_get_ns({replace, _}) ->
    <<"urn:xmpp:message-correct:0">>;
do_get_ns({retract}) ->
    <<"urn:xmpp:message-retract:0">>.

pp(retract, 0) -> [];
pp(replace, 1) -> [id];
pp(_, _) -> no.

records() -> [{retract, 0}, {replace, 1}].

decode_replace(__TopXMLNS, __Opts,
               {xmlel, <<"replace">>, _attrs, _els}) ->
    Id = decode_replace_attrs(__TopXMLNS,
                              _attrs,
                              undefined),
    {replace, Id}.

decode_replace_attrs(__TopXMLNS,
                     [{<<"id">>, _val} | _attrs], _Id) ->
    decode_replace_attrs(__TopXMLNS, _attrs, _val);
decode_replace_attrs(__TopXMLNS, [_ | _attrs], Id) ->
    decode_replace_attrs(__TopXMLNS, _attrs, Id);
decode_replace_attrs(__TopXMLNS, [], Id) ->
    decode_replace_attr_id(__TopXMLNS, Id).

encode_replace({replace, Id}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-correct:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_replace_attr_id(Id,
                                    xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                               __TopXMLNS)),
    {xmlel, <<"replace">>, _attrs, _els}.

decode_replace_attr_id(__TopXMLNS, undefined) -> <<>>;
decode_replace_attr_id(__TopXMLNS, _val) -> _val.

encode_replace_attr_id(<<>>, _acc) -> _acc;
encode_replace_attr_id(_val, _acc) ->
    [{<<"id">>, _val} | _acc].

decode_retract(__TopXMLNS, __Opts,
               {xmlel, <<"retract">>, _attrs, _els}) ->
    {retract}.

encode_retract({retract}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-retract:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                        __TopXMLNS),
    {xmlel, <<"retract">>, _attrs, _els}.
