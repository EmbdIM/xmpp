%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(xep0425).

-compile(export_all).

do_decode(<<"moderated">>,
          <<"urn:xmpp:message-moderate:0">>, El, Opts) ->
    decode_moderated(<<"urn:xmpp:message-moderate:0">>,
                     Opts,
                     El);
do_decode(<<"moderate">>,
          <<"urn:xmpp:message-moderate:0">>, El, Opts) ->
    decode_moderate(<<"urn:xmpp:message-moderate:0">>,
                    Opts,
                    El);
do_decode(<<"retracted">>,
          <<"urn:xmpp:message-moderate:0">>, El, Opts) ->
    decode_retracted(<<"urn:xmpp:message-moderate:0">>,
                     Opts,
                     El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"moderated">>, <<"urn:xmpp:message-moderate:0">>},
     {<<"moderate">>, <<"urn:xmpp:message-moderate:0">>},
     {<<"retracted">>, <<"urn:xmpp:message-moderate:0">>}].

do_encode({retracted, _, _} = Retracted, TopXMLNS) ->
    encode_retracted(Retracted, TopXMLNS);
do_encode({moderate, _} = Moderate, TopXMLNS) ->
    encode_moderate(Moderate, TopXMLNS);
do_encode({moderated, _, _} = Moderated, TopXMLNS) ->
    encode_moderated(Moderated, TopXMLNS).

do_get_name({moderate, _}) -> <<"moderate">>;
do_get_name({moderated, _, _}) -> <<"moderated">>;
do_get_name({retracted, _, _}) -> <<"retracted">>.

do_get_ns({moderate, _}) ->
    <<"urn:xmpp:message-moderate:0">>;
do_get_ns({moderated, _, _}) ->
    <<"urn:xmpp:message-moderate:0">>;
do_get_ns({retracted, _, _}) ->
    <<"urn:xmpp:message-moderate:0">>.

get_els({retracted, _stamp, _sub_els}) -> _sub_els;
get_els({moderate, _sub_els}) -> _sub_els;
get_els({moderated, _by, _sub_els}) -> _sub_els.

set_els({retracted, _stamp, _}, _sub_els) ->
    {retracted, _stamp, _sub_els};
set_els({moderate, _}, _sub_els) ->
    {moderate, _sub_els};
set_els({moderated, _by, _}, _sub_els) ->
    {moderated, _by, _sub_els}.

pp(retracted, 2) -> [stamp, sub_els];
pp(moderate, 1) -> [sub_els];
pp(moderated, 2) -> [by, sub_els];
pp(_, _) -> no.

records() ->
    [{retracted, 2}, {moderate, 1}, {moderated, 2}].

dec_utc(Val) -> xmpp_util:decode_timestamp(Val).

enc_utc(Val) -> xmpp_util:encode_timestamp(Val).

decode_moderated(__TopXMLNS, __Opts,
                 {xmlel, <<"moderated">>, _attrs, _els}) ->
    __Els = decode_moderated_els(__TopXMLNS,
                                 __Opts,
                                 _els,
                                 []),
    By = decode_moderated_attrs(__TopXMLNS,
                                _attrs,
                                undefined),
    {moderated, By, __Els}.

decode_moderated_els(__TopXMLNS, __Opts, [], __Els) ->
    lists:reverse(__Els);
decode_moderated_els(__TopXMLNS, __Opts,
                     [{xmlel, _name, _attrs, _} = _el | _els], __Els) ->
    case proplists:get_bool(ignore_els, __Opts) of
        true ->
            decode_moderated_els(__TopXMLNS,
                                 __Opts,
                                 _els,
                                 [_el | __Els]);
        false ->
            __XMLNS = xmpp_codec:get_attr(<<"xmlns">>,
                                          _attrs,
                                          __TopXMLNS),
            case xmpp_codec:get_mod(_name, __XMLNS) of
                undefined ->
                    decode_moderated_els(__TopXMLNS,
                                         __Opts,
                                         _els,
                                         [_el | __Els]);
                Mod ->
                    decode_moderated_els(__TopXMLNS,
                                         __Opts,
                                         _els,
                                         [Mod:do_decode(_name,
                                                        __XMLNS,
                                                        _el,
                                                        __Opts)
                                          | __Els])
            end
    end;
decode_moderated_els(__TopXMLNS, __Opts, [_ | _els],
                     __Els) ->
    decode_moderated_els(__TopXMLNS, __Opts, _els, __Els).

decode_moderated_attrs(__TopXMLNS,
                       [{<<"by">>, _val} | _attrs], _By) ->
    decode_moderated_attrs(__TopXMLNS, _attrs, _val);
decode_moderated_attrs(__TopXMLNS, [_ | _attrs], By) ->
    decode_moderated_attrs(__TopXMLNS, _attrs, By);
decode_moderated_attrs(__TopXMLNS, [], By) ->
    decode_moderated_attr_by(__TopXMLNS, By).

encode_moderated({moderated, By, __Els}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-moderate:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [xmpp_codec:encode(_el, __NewTopXMLNS)
            || _el <- __Els],
    _attrs = encode_moderated_attr_by(By,
                                      xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                 __TopXMLNS)),
    {xmlel, <<"moderated">>, _attrs, _els}.

decode_moderated_attr_by(__TopXMLNS, undefined) ->
    undefined;
decode_moderated_attr_by(__TopXMLNS, _val) ->
    case catch jid:decode(_val) of
        {'EXIT', _} ->
            erlang:error({xmpp_codec,
                          {bad_attr_value,
                           <<"by">>,
                           <<"moderated">>,
                           __TopXMLNS}});
        _res -> _res
    end.

encode_moderated_attr_by(undefined, _acc) -> _acc;
encode_moderated_attr_by(_val, _acc) ->
    [{<<"by">>, jid:encode(_val)} | _acc].

decode_moderate(__TopXMLNS, __Opts,
                {xmlel, <<"moderate">>, _attrs, _els}) ->
    __Els = decode_moderate_els(__TopXMLNS,
                                __Opts,
                                _els,
                                []),
    {moderate, __Els}.

decode_moderate_els(__TopXMLNS, __Opts, [], __Els) ->
    lists:reverse(__Els);
decode_moderate_els(__TopXMLNS, __Opts,
                    [{xmlel, _name, _attrs, _} = _el | _els], __Els) ->
    case proplists:get_bool(ignore_els, __Opts) of
        true ->
            decode_moderate_els(__TopXMLNS,
                                __Opts,
                                _els,
                                [_el | __Els]);
        false ->
            __XMLNS = xmpp_codec:get_attr(<<"xmlns">>,
                                          _attrs,
                                          __TopXMLNS),
            case xmpp_codec:get_mod(_name, __XMLNS) of
                undefined ->
                    decode_moderate_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        [_el | __Els]);
                Mod ->
                    decode_moderate_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        [Mod:do_decode(_name,
                                                       __XMLNS,
                                                       _el,
                                                       __Opts)
                                         | __Els])
            end
    end;
decode_moderate_els(__TopXMLNS, __Opts, [_ | _els],
                    __Els) ->
    decode_moderate_els(__TopXMLNS, __Opts, _els, __Els).

encode_moderate({moderate, __Els}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-moderate:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [xmpp_codec:encode(_el, __NewTopXMLNS)
            || _el <- __Els],
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                        __TopXMLNS),
    {xmlel, <<"moderate">>, _attrs, _els}.

decode_retracted(__TopXMLNS, __Opts,
                 {xmlel, <<"retracted">>, _attrs, _els}) ->
    __Els = decode_retracted_els(__TopXMLNS,
                                 __Opts,
                                 _els,
                                 []),
    Stamp = decode_retracted_attrs(__TopXMLNS,
                                   _attrs,
                                   undefined),
    {retracted, Stamp, __Els}.

decode_retracted_els(__TopXMLNS, __Opts, [], __Els) ->
    lists:reverse(__Els);
decode_retracted_els(__TopXMLNS, __Opts,
                     [{xmlel, _name, _attrs, _} = _el | _els], __Els) ->
    case proplists:get_bool(ignore_els, __Opts) of
        true ->
            decode_retracted_els(__TopXMLNS,
                                 __Opts,
                                 _els,
                                 [_el | __Els]);
        false ->
            __XMLNS = xmpp_codec:get_attr(<<"xmlns">>,
                                          _attrs,
                                          __TopXMLNS),
            case xmpp_codec:get_mod(_name, __XMLNS) of
                undefined ->
                    decode_retracted_els(__TopXMLNS,
                                         __Opts,
                                         _els,
                                         [_el | __Els]);
                Mod ->
                    decode_retracted_els(__TopXMLNS,
                                         __Opts,
                                         _els,
                                         [Mod:do_decode(_name,
                                                        __XMLNS,
                                                        _el,
                                                        __Opts)
                                          | __Els])
            end
    end;
decode_retracted_els(__TopXMLNS, __Opts, [_ | _els],
                     __Els) ->
    decode_retracted_els(__TopXMLNS, __Opts, _els, __Els).

decode_retracted_attrs(__TopXMLNS,
                       [{<<"stamp">>, _val} | _attrs], _Stamp) ->
    decode_retracted_attrs(__TopXMLNS, _attrs, _val);
decode_retracted_attrs(__TopXMLNS, [_ | _attrs],
                       Stamp) ->
    decode_retracted_attrs(__TopXMLNS, _attrs, Stamp);
decode_retracted_attrs(__TopXMLNS, [], Stamp) ->
    decode_retracted_attr_stamp(__TopXMLNS, Stamp).

encode_retracted({retracted, Stamp, __Els},
                 __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:message-moderate:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [xmpp_codec:encode(_el, __NewTopXMLNS)
            || _el <- __Els],
    _attrs = encode_retracted_attr_stamp(Stamp,
                                         xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                    __TopXMLNS)),
    {xmlel, <<"retracted">>, _attrs, _els}.

decode_retracted_attr_stamp(__TopXMLNS, undefined) ->
    undefined;
decode_retracted_attr_stamp(__TopXMLNS, _val) ->
    case catch dec_utc(_val) of
        {'EXIT', _} ->
            erlang:error({xmpp_codec,
                          {bad_attr_value,
                           <<"stamp">>,
                           <<"retracted">>,
                           __TopXMLNS}});
        _res -> _res
    end.

encode_retracted_attr_stamp(undefined, _acc) -> _acc;
encode_retracted_attr_stamp(_val, _acc) ->
    [{<<"stamp">>, enc_utc(_val)} | _acc].
