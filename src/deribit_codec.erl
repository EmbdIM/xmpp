%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(deribit_codec).

-compile(export_all).

do_decode(<<"entity">>, <<"urn:deribit:system">>, El,
          Opts) ->
    decode_entity(<<"urn:deribit:system">>, Opts, El);
do_decode(<<"bot">>, <<"urn:deribit:system">>, El,
          Opts) ->
    decode_bot(<<"urn:deribit:system">>, Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"entity">>, <<"urn:deribit:system">>},
     {<<"bot">>, <<"urn:deribit:system">>}].

do_encode({bot, _, _, _, _} = Bot, TopXMLNS) ->
    encode_bot(Bot, TopXMLNS);
do_encode({entity, _, _, _} = Entity, TopXMLNS) ->
    encode_entity(Entity, TopXMLNS).

do_get_name({bot, _, _, _, _}) -> <<"bot">>;
do_get_name({entity, _, _, _}) -> <<"entity">>.

do_get_ns({bot, _, _, _, _}) ->
    <<"urn:deribit:system">>;
do_get_ns({entity, _, _, _}) ->
    <<"urn:deribit:system">>.

pp(bot, 4) -> [name, type, entities, parse_mode];
pp(entity, 3) -> [type, offset, length];
pp(_, _) -> no.

records() -> [{bot, 4}, {entity, 3}].

dec_enum(Val, Enums) ->
    AtomVal = erlang:binary_to_existing_atom(Val, utf8),
    case lists:member(AtomVal, Enums) of
        true -> AtomVal
    end.

enc_enum(Atom) -> erlang:atom_to_binary(Atom, utf8).

decode_entity(__TopXMLNS, __Opts,
              {xmlel, <<"entity">>, _attrs, _els}) ->
    {Type, Offset, Length} = decode_entity_attrs(__TopXMLNS,
                                                 _attrs,
                                                 undefined,
                                                 undefined,
                                                 undefined),
    {entity, Type, Offset, Length}.

decode_entity_attrs(__TopXMLNS,
                    [{<<"type">>, _val} | _attrs], _Type, Offset, Length) ->
    decode_entity_attrs(__TopXMLNS,
                        _attrs,
                        _val,
                        Offset,
                        Length);
decode_entity_attrs(__TopXMLNS,
                    [{<<"offset">>, _val} | _attrs], Type, _Offset,
                    Length) ->
    decode_entity_attrs(__TopXMLNS,
                        _attrs,
                        Type,
                        _val,
                        Length);
decode_entity_attrs(__TopXMLNS,
                    [{<<"length">>, _val} | _attrs], Type, Offset,
                    _Length) ->
    decode_entity_attrs(__TopXMLNS,
                        _attrs,
                        Type,
                        Offset,
                        _val);
decode_entity_attrs(__TopXMLNS, [_ | _attrs], Type,
                    Offset, Length) ->
    decode_entity_attrs(__TopXMLNS,
                        _attrs,
                        Type,
                        Offset,
                        Length);
decode_entity_attrs(__TopXMLNS, [], Type, Offset,
                    Length) ->
    {decode_entity_attr_type(__TopXMLNS, Type),
     decode_entity_attr_offset(__TopXMLNS, Offset),
     decode_entity_attr_length(__TopXMLNS, Length)}.

encode_entity({entity, Type, Offset, Length},
              __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:deribit:system">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_entity_attr_length(Length,
                                       encode_entity_attr_offset(Offset,
                                                                 encode_entity_attr_type(Type,
                                                                                         xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                                                                    __TopXMLNS)))),
    {xmlel, <<"entity">>, _attrs, _els}.

decode_entity_attr_type(__TopXMLNS, undefined) -> <<>>;
decode_entity_attr_type(__TopXMLNS, _val) -> _val.

encode_entity_attr_type(<<>>, _acc) -> _acc;
encode_entity_attr_type(_val, _acc) ->
    [{<<"type">>, _val} | _acc].

decode_entity_attr_offset(__TopXMLNS, undefined) ->
    <<>>;
decode_entity_attr_offset(__TopXMLNS, _val) -> _val.

encode_entity_attr_offset(<<>>, _acc) -> _acc;
encode_entity_attr_offset(_val, _acc) ->
    [{<<"offset">>, _val} | _acc].

decode_entity_attr_length(__TopXMLNS, undefined) ->
    <<>>;
decode_entity_attr_length(__TopXMLNS, _val) -> _val.

encode_entity_attr_length(<<>>, _acc) -> _acc;
encode_entity_attr_length(_val, _acc) ->
    [{<<"length">>, _val} | _acc].

decode_bot(__TopXMLNS, __Opts,
           {xmlel, <<"bot">>, _attrs, _els}) ->
    Entities = decode_bot_els(__TopXMLNS, __Opts, _els, []),
    {Name, Type, Parse_mode} = decode_bot_attrs(__TopXMLNS,
                                                _attrs,
                                                undefined,
                                                undefined,
                                                undefined),
    {bot, Name, Type, Entities, Parse_mode}.

decode_bot_els(__TopXMLNS, __Opts, [], Entities) ->
    lists:reverse(Entities);
decode_bot_els(__TopXMLNS, __Opts,
               [{xmlel, <<"entity">>, _attrs, _} = _el | _els],
               Entities) ->
    case xmpp_codec:get_attr(<<"xmlns">>,
                             _attrs,
                             __TopXMLNS)
        of
        <<"urn:deribit:system">> ->
            decode_bot_els(__TopXMLNS,
                           __Opts,
                           _els,
                           [decode_entity(<<"urn:deribit:system">>, __Opts, _el)
                            | Entities]);
        _ -> decode_bot_els(__TopXMLNS, __Opts, _els, Entities)
    end;
decode_bot_els(__TopXMLNS, __Opts, [_ | _els],
               Entities) ->
    decode_bot_els(__TopXMLNS, __Opts, _els, Entities).

decode_bot_attrs(__TopXMLNS,
                 [{<<"name">>, _val} | _attrs], _Name, Type,
                 Parse_mode) ->
    decode_bot_attrs(__TopXMLNS,
                     _attrs,
                     _val,
                     Type,
                     Parse_mode);
decode_bot_attrs(__TopXMLNS,
                 [{<<"type">>, _val} | _attrs], Name, _Type,
                 Parse_mode) ->
    decode_bot_attrs(__TopXMLNS,
                     _attrs,
                     Name,
                     _val,
                     Parse_mode);
decode_bot_attrs(__TopXMLNS,
                 [{<<"parse_mode">>, _val} | _attrs], Name, Type,
                 _Parse_mode) ->
    decode_bot_attrs(__TopXMLNS, _attrs, Name, Type, _val);
decode_bot_attrs(__TopXMLNS, [_ | _attrs], Name, Type,
                 Parse_mode) ->
    decode_bot_attrs(__TopXMLNS,
                     _attrs,
                     Name,
                     Type,
                     Parse_mode);
decode_bot_attrs(__TopXMLNS, [], Name, Type,
                 Parse_mode) ->
    {decode_bot_attr_name(__TopXMLNS, Name),
     decode_bot_attr_type(__TopXMLNS, Type),
     decode_bot_attr_parse_mode(__TopXMLNS, Parse_mode)}.

encode_bot({bot, Name, Type, Entities, Parse_mode},
           __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:deribit:system">>,
                                    [],
                                    __TopXMLNS),
    _els = lists:reverse('encode_bot_$entities'(Entities,
                                                __NewTopXMLNS,
                                                [])),
    _attrs = encode_bot_attr_parse_mode(Parse_mode,
                                        encode_bot_attr_type(Type,
                                                             encode_bot_attr_name(Name,
                                                                                  xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                                                             __TopXMLNS)))),
    {xmlel, <<"bot">>, _attrs, _els}.

'encode_bot_$entities'([], __TopXMLNS, _acc) -> _acc;
'encode_bot_$entities'([Entities | _els], __TopXMLNS,
                       _acc) ->
    'encode_bot_$entities'(_els,
                           __TopXMLNS,
                           [encode_entity(Entities, __TopXMLNS) | _acc]).

decode_bot_attr_name(__TopXMLNS, undefined) -> <<>>;
decode_bot_attr_name(__TopXMLNS, _val) -> _val.

encode_bot_attr_name(<<>>, _acc) -> _acc;
encode_bot_attr_name(_val, _acc) ->
    [{<<"name">>, _val} | _acc].

decode_bot_attr_type(__TopXMLNS, undefined) -> system;
decode_bot_attr_type(__TopXMLNS, _val) -> _val.

encode_bot_attr_type(system, _acc) -> _acc;
encode_bot_attr_type(_val, _acc) ->
    [{<<"type">>, _val} | _acc].

decode_bot_attr_parse_mode(__TopXMLNS, undefined) ->
    none;
decode_bot_attr_parse_mode(__TopXMLNS, _val) ->
    case catch dec_enum(_val, [none, markdown, html]) of
        {'EXIT', _} ->
            erlang:error({xmpp_codec,
                          {bad_attr_value,
                           <<"parse_mode">>,
                           <<"bot">>,
                           __TopXMLNS}});
        _res -> _res
    end.

encode_bot_attr_parse_mode(_val, _acc) ->
    [{<<"parse_mode">>, enc_enum(_val)} | _acc].
