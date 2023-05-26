%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(deribit_codec).

-compile(export_all).

do_decode(<<"entities">>, <<"urn:xmpp:message-entity">>,
          El, Opts) ->
    decode_message_entities(<<"urn:xmpp:message-entity">>,
                            Opts,
                            El);
do_decode(<<"entity">>, <<"urn:xmpp:message-entity">>,
          El, Opts) ->
    decode_message_entity(<<"urn:xmpp:message-entity">>,
                          Opts,
                          El);
do_decode(<<"bot">>, <<"urn:deribit:system">>, El,
          Opts) ->
    decode_bot(<<"urn:deribit:system">>, Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"entities">>, <<"urn:xmpp:message-entity">>},
     {<<"entity">>, <<"urn:xmpp:message-entity">>},
     {<<"bot">>, <<"urn:deribit:system">>}].

do_encode({bot, _, _, _} = Bot, TopXMLNS) ->
    encode_bot(Bot, TopXMLNS);
do_encode({message_entity, _, _, _} = Entity,
          TopXMLNS) ->
    encode_message_entity(Entity, TopXMLNS);
do_encode({message_entities, _} = Entities, TopXMLNS) ->
    encode_message_entities(Entities, TopXMLNS).

do_get_name({bot, _, _, _}) -> <<"bot">>;
do_get_name({message_entities, _}) -> <<"entities">>;
do_get_name({message_entity, _, _, _}) -> <<"entity">>.

do_get_ns({bot, _, _, _}) -> <<"urn:deribit:system">>;
do_get_ns({message_entities, _}) ->
    <<"urn:xmpp:message-entity">>;
do_get_ns({message_entity, _, _, _}) ->
    <<"urn:xmpp:message-entity">>.

pp(bot, 3) -> [nick, type, parse_mode];
pp(message_entity, 3) -> [type, offset, length];
pp(message_entities, 1) -> [items];
pp(_, _) -> no.

records() ->
    [{bot, 3}, {message_entity, 3}, {message_entities, 1}].

dec_enum(Val, Enums) ->
    AtomVal = erlang:binary_to_existing_atom(Val, utf8),
    case lists:member(AtomVal, Enums) of
        true -> AtomVal
    end.

dec_int(Val, Min, Max) ->
    case erlang:binary_to_integer(Val) of
        Int when Int =< Max, Min == infinity -> Int;
        Int when Int =< Max, Int >= Min -> Int
    end.

enc_enum(Atom) -> erlang:atom_to_binary(Atom, utf8).

enc_int(Int) -> erlang:integer_to_binary(Int).

decode_message_entities(__TopXMLNS, __Opts,
                        {xmlel, <<"entities">>, _attrs, _els}) ->
    Items = decode_message_entities_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        []),
    {message_entities, Items}.

decode_message_entities_els(__TopXMLNS, __Opts, [],
                            Items) ->
    lists:reverse(Items);
decode_message_entities_els(__TopXMLNS, __Opts,
                            [{xmlel, <<"entity">>, _attrs, _} = _el | _els],
                            Items) ->
    case xmpp_codec:get_attr(<<"xmlns">>,
                             _attrs,
                             __TopXMLNS)
        of
        <<"urn:xmpp:message-entity">> ->
            decode_message_entities_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        [decode_message_entity(<<"urn:xmpp:message-entity">>,
                                                               __Opts,
                                                               _el)
                                         | Items]);
        _ ->
            decode_message_entities_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        Items)
    end;
decode_message_entities_els(__TopXMLNS, __Opts,
                            [_ | _els], Items) ->
    decode_message_entities_els(__TopXMLNS,
                                __Opts,
                                _els,
                                Items).

encode_message_entities({message_entities, Items},
                        __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-entity">>,
                                    [],
                                    __TopXMLNS),
    _els =
        lists:reverse('encode_message_entities_$items'(Items,
                                                       __NewTopXMLNS,
                                                       [])),
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                        __TopXMLNS),
    {xmlel, <<"entities">>, _attrs, _els}.

'encode_message_entities_$items'([], __TopXMLNS,
                                 _acc) ->
    _acc;
'encode_message_entities_$items'([Items | _els],
                                 __TopXMLNS, _acc) ->
    'encode_message_entities_$items'(_els,
                                     __TopXMLNS,
                                     [encode_message_entity(Items, __TopXMLNS)
                                      | _acc]).

decode_message_entity(__TopXMLNS, __Opts,
                      {xmlel, <<"entity">>, _attrs, _els}) ->
    {Type, Offset, Length} =
        decode_message_entity_attrs(__TopXMLNS,
                                    _attrs,
                                    undefined,
                                    undefined,
                                    undefined),
    {message_entity, Type, Offset, Length}.

decode_message_entity_attrs(__TopXMLNS,
                            [{<<"type">>, _val} | _attrs], _Type, Offset,
                            Length) ->
    decode_message_entity_attrs(__TopXMLNS,
                                _attrs,
                                _val,
                                Offset,
                                Length);
decode_message_entity_attrs(__TopXMLNS,
                            [{<<"offset">>, _val} | _attrs], Type, _Offset,
                            Length) ->
    decode_message_entity_attrs(__TopXMLNS,
                                _attrs,
                                Type,
                                _val,
                                Length);
decode_message_entity_attrs(__TopXMLNS,
                            [{<<"length">>, _val} | _attrs], Type, Offset,
                            _Length) ->
    decode_message_entity_attrs(__TopXMLNS,
                                _attrs,
                                Type,
                                Offset,
                                _val);
decode_message_entity_attrs(__TopXMLNS, [_ | _attrs],
                            Type, Offset, Length) ->
    decode_message_entity_attrs(__TopXMLNS,
                                _attrs,
                                Type,
                                Offset,
                                Length);
decode_message_entity_attrs(__TopXMLNS, [], Type,
                            Offset, Length) ->
    {decode_message_entity_attr_type(__TopXMLNS, Type),
     decode_message_entity_attr_offset(__TopXMLNS, Offset),
     decode_message_entity_attr_length(__TopXMLNS, Length)}.

encode_message_entity({message_entity,
                       Type,
                       Offset,
                       Length},
                      __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-entity">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_message_entity_attr_length(Length,
                                               encode_message_entity_attr_offset(Offset,
                                                                                 encode_message_entity_attr_type(Type,
                                                                                                                 xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                                                                                            __TopXMLNS)))),
    {xmlel, <<"entity">>, _attrs, _els}.

decode_message_entity_attr_type(__TopXMLNS,
                                undefined) ->
    undefined;
decode_message_entity_attr_type(__TopXMLNS, _val) ->
    case catch dec_enum(_val,
                        [bold,
                         italic,
                         underline,
                         strikethrough,
                         code,
                         pre,
                         text_link,
                         mention,
                         hashtag,
                         monospace,
                         spoiler,
                         bot_command])
        of
        {'EXIT', _} ->
            erlang:error({xmpp_codec,
                          {bad_attr_value,
                           <<"type">>,
                           <<"entity">>,
                           __TopXMLNS}});
        _res -> _res
    end.

encode_message_entity_attr_type(_val, _acc) ->
    [{<<"type">>, enc_enum(_val)} | _acc].

decode_message_entity_attr_offset(__TopXMLNS,
                                  undefined) ->
    0;
decode_message_entity_attr_offset(__TopXMLNS, _val) ->
    case catch dec_int(_val, 0, infinity) of
        {'EXIT', _} ->
            erlang:error({xmpp_codec,
                          {bad_attr_value,
                           <<"offset">>,
                           <<"entity">>,
                           __TopXMLNS}});
        _res -> _res
    end.

encode_message_entity_attr_offset(0, _acc) -> _acc;
encode_message_entity_attr_offset(_val, _acc) ->
    [{<<"offset">>, enc_int(_val)} | _acc].

decode_message_entity_attr_length(__TopXMLNS,
                                  undefined) ->
    0;
decode_message_entity_attr_length(__TopXMLNS, _val) ->
    case catch dec_int(_val, 0, infinity) of
        {'EXIT', _} ->
            erlang:error({xmpp_codec,
                          {bad_attr_value,
                           <<"length">>,
                           <<"entity">>,
                           __TopXMLNS}});
        _res -> _res
    end.

encode_message_entity_attr_length(0, _acc) -> _acc;
encode_message_entity_attr_length(_val, _acc) ->
    [{<<"length">>, enc_int(_val)} | _acc].

decode_bot(__TopXMLNS, __Opts,
           {xmlel, <<"bot">>, _attrs, _els}) ->
    {Nick, Type, Parse_mode} = decode_bot_attrs(__TopXMLNS,
                                                _attrs,
                                                undefined,
                                                undefined,
                                                undefined),
    {bot, Nick, Type, Parse_mode}.

decode_bot_attrs(__TopXMLNS,
                 [{<<"nick">>, _val} | _attrs], _Nick, Type,
                 Parse_mode) ->
    decode_bot_attrs(__TopXMLNS,
                     _attrs,
                     _val,
                     Type,
                     Parse_mode);
decode_bot_attrs(__TopXMLNS,
                 [{<<"type">>, _val} | _attrs], Nick, _Type,
                 Parse_mode) ->
    decode_bot_attrs(__TopXMLNS,
                     _attrs,
                     Nick,
                     _val,
                     Parse_mode);
decode_bot_attrs(__TopXMLNS,
                 [{<<"parse_mode">>, _val} | _attrs], Nick, Type,
                 _Parse_mode) ->
    decode_bot_attrs(__TopXMLNS, _attrs, Nick, Type, _val);
decode_bot_attrs(__TopXMLNS, [_ | _attrs], Nick, Type,
                 Parse_mode) ->
    decode_bot_attrs(__TopXMLNS,
                     _attrs,
                     Nick,
                     Type,
                     Parse_mode);
decode_bot_attrs(__TopXMLNS, [], Nick, Type,
                 Parse_mode) ->
    {decode_bot_attr_nick(__TopXMLNS, Nick),
     decode_bot_attr_type(__TopXMLNS, Type),
     decode_bot_attr_parse_mode(__TopXMLNS, Parse_mode)}.

encode_bot({bot, Nick, Type, Parse_mode}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:deribit:system">>,
                                    [],
                                    __TopXMLNS),
    _els = [],
    _attrs = encode_bot_attr_parse_mode(Parse_mode,
                                        encode_bot_attr_type(Type,
                                                             encode_bot_attr_nick(Nick,
                                                                                  xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                                                             __TopXMLNS)))),
    {xmlel, <<"bot">>, _attrs, _els}.

decode_bot_attr_nick(__TopXMLNS, undefined) -> <<>>;
decode_bot_attr_nick(__TopXMLNS, _val) -> _val.

encode_bot_attr_nick(<<>>, _acc) -> _acc;
encode_bot_attr_nick(_val, _acc) ->
    [{<<"nick">>, _val} | _acc].

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
