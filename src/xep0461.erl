%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(xep0461).

-compile(export_all).

do_decode(<<"fallback">>,
          <<"urn:xmpp:feature-fallback:0">>, El, Opts) ->
    decode_fallback(<<"urn:xmpp:feature-fallback:0">>,
                    Opts,
                    El);
do_decode(<<"reply">>, <<"urn:xmpp:reply:0">>, El,
          Opts) ->
    decode_reply(<<"urn:xmpp:reply:0">>, Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"fallback">>, <<"urn:xmpp:feature-fallback:0">>},
     {<<"reply">>, <<"urn:xmpp:reply:0">>}].

do_encode({reply, _, _} = Reply, TopXMLNS) ->
    encode_reply(Reply, TopXMLNS);
do_encode({fallback, _} = Fallback, TopXMLNS) ->
    encode_fallback(Fallback, TopXMLNS).

do_get_name({fallback, _}) -> <<"fallback">>;
do_get_name({reply, _, _}) -> <<"reply">>.

do_get_ns({fallback, _}) ->
    <<"urn:xmpp:feature-fallback:0">>;
do_get_ns({reply, _, _}) -> <<"urn:xmpp:reply:0">>.

pp(reply, 2) -> [id, to];
pp(fallback, 1) -> [for];
pp(_, _) -> no.

records() -> [{reply, 2}, {fallback, 1}].

decode_fallback(__TopXMLNS, __Opts,
                {xmlel, <<"fallback">>, _attrs, _els}) ->
    For = decode_fallback_attrs(__TopXMLNS,
                                _attrs,
                                undefined),
    {fallback, For}.

decode_fallback_attrs(__TopXMLNS,
                      [{<<"for">>, _val} | _attrs], _For) ->
    decode_fallback_attrs(__TopXMLNS, _attrs, _val);
decode_fallback_attrs(__TopXMLNS, [_ | _attrs], For) ->
    decode_fallback_attrs(__TopXMLNS, _attrs, For);
decode_fallback_attrs(__TopXMLNS, [], For) ->
    decode_fallback_attr_for(__TopXMLNS, For).

encode_fallback({fallback, For}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:feature-fallback:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_fallback_attr_for(For,
                                      xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                 __TopXMLNS)),
    {xmlel, <<"fallback">>, _attrs, _els}.

decode_fallback_attr_for(__TopXMLNS, undefined) -> <<>>;
decode_fallback_attr_for(__TopXMLNS, _val) -> _val.

encode_fallback_attr_for(<<>>, _acc) -> _acc;
encode_fallback_attr_for(_val, _acc) ->
    [{<<"for">>, _val} | _acc].

decode_reply(__TopXMLNS, __Opts,
             {xmlel, <<"reply">>, _attrs, _els}) ->
    {Id, To} = decode_reply_attrs(__TopXMLNS,
                                  _attrs,
                                  undefined,
                                  undefined),
    {reply, Id, To}.

decode_reply_attrs(__TopXMLNS,
                   [{<<"id">>, _val} | _attrs], _Id, To) ->
    decode_reply_attrs(__TopXMLNS, _attrs, _val, To);
decode_reply_attrs(__TopXMLNS,
                   [{<<"to">>, _val} | _attrs], Id, _To) ->
    decode_reply_attrs(__TopXMLNS, _attrs, Id, _val);
decode_reply_attrs(__TopXMLNS, [_ | _attrs], Id, To) ->
    decode_reply_attrs(__TopXMLNS, _attrs, Id, To);
decode_reply_attrs(__TopXMLNS, [], Id, To) ->
    {decode_reply_attr_id(__TopXMLNS, Id),
     decode_reply_attr_to(__TopXMLNS, To)}.

encode_reply({reply, Id, To}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:reply:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_reply_attr_to(To,
                                  encode_reply_attr_id(Id,
                                                       xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                                  __TopXMLNS))),
    {xmlel, <<"reply">>, _attrs, _els}.

decode_reply_attr_id(__TopXMLNS, undefined) -> <<>>;
decode_reply_attr_id(__TopXMLNS, _val) -> _val.

encode_reply_attr_id(<<>>, _acc) -> _acc;
encode_reply_attr_id(_val, _acc) ->
    [{<<"id">>, _val} | _acc].

decode_reply_attr_to(__TopXMLNS, undefined) -> <<>>;
decode_reply_attr_to(__TopXMLNS, _val) -> _val.

encode_reply_attr_to(<<>>, _acc) -> _acc;
encode_reply_attr_to(_val, _acc) ->
    [{<<"to">>, _val} | _acc].
