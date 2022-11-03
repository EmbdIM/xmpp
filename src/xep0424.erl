%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(xep0424).

-compile(export_all).

do_decode(<<"apply-to">>, <<"urn:xmpp:fasten:0">>, El,
          Opts) ->
    decode_apply_to(<<"urn:xmpp:fasten:0">>, Opts, El);
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
    [{<<"apply-to">>, <<"urn:xmpp:fasten:0">>},
     {<<"replace">>, <<"urn:xmpp:message-correct:0">>},
     {<<"retract">>, <<"urn:xmpp:message-retract:0">>}].

do_encode({retract} = Retract, TopXMLNS) ->
    encode_retract(Retract, TopXMLNS);
do_encode({replace, _} = Replace, TopXMLNS) ->
    encode_replace(Replace, TopXMLNS);
do_encode({apply_to, _, _} = Apply_to, TopXMLNS) ->
    encode_apply_to(Apply_to, TopXMLNS).

do_get_name({apply_to, _, _}) -> <<"apply-to">>;
do_get_name({replace, _}) -> <<"replace">>;
do_get_name({retract}) -> <<"retract">>.

do_get_ns({apply_to, _, _}) -> <<"urn:xmpp:fasten:0">>;
do_get_ns({replace, _}) ->
    <<"urn:xmpp:message-correct:0">>;
do_get_ns({retract}) ->
    <<"urn:xmpp:message-retract:0">>.

get_els({apply_to, _id, _sub_els}) -> _sub_els.

set_els({apply_to, _id, _}, _sub_els) ->
    {apply_to, _id, _sub_els}.

pp(retract, 0) -> [];
pp(replace, 1) -> [id];
pp(apply_to, 2) -> [id, sub_els];
pp(_, _) -> no.

records() ->
    [{retract, 0}, {replace, 1}, {apply_to, 2}].

decode_apply_to(__TopXMLNS, __Opts,
                {xmlel, <<"apply-to">>, _attrs, _els}) ->
    __Els = decode_apply_to_els(__TopXMLNS,
                                __Opts,
                                _els,
                                []),
    Id = decode_apply_to_attrs(__TopXMLNS,
                               _attrs,
                               undefined),
    {apply_to, Id, __Els}.

decode_apply_to_els(__TopXMLNS, __Opts, [], __Els) ->
    lists:reverse(__Els);
decode_apply_to_els(__TopXMLNS, __Opts,
                    [{xmlel, _name, _attrs, _} = _el | _els], __Els) ->
    case proplists:get_bool(ignore_els, __Opts) of
        true ->
            decode_apply_to_els(__TopXMLNS,
                                __Opts,
                                _els,
                                [_el | __Els]);
        false ->
            __XMLNS = xmpp_codec:get_attr(<<"xmlns">>,
                                          _attrs,
                                          __TopXMLNS),
            case xmpp_codec:get_mod(_name, __XMLNS) of
                undefined ->
                    decode_apply_to_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        [_el | __Els]);
                Mod ->
                    decode_apply_to_els(__TopXMLNS,
                                        __Opts,
                                        _els,
                                        [Mod:do_decode(_name,
                                                       __XMLNS,
                                                       _el,
                                                       __Opts)
                                         | __Els])
            end
    end;
decode_apply_to_els(__TopXMLNS, __Opts, [_ | _els],
                    __Els) ->
    decode_apply_to_els(__TopXMLNS, __Opts, _els, __Els).

decode_apply_to_attrs(__TopXMLNS,
                      [{<<"id">>, _val} | _attrs], _Id) ->
    decode_apply_to_attrs(__TopXMLNS, _attrs, _val);
decode_apply_to_attrs(__TopXMLNS, [_ | _attrs], Id) ->
    decode_apply_to_attrs(__TopXMLNS, _attrs, Id);
decode_apply_to_attrs(__TopXMLNS, [], Id) ->
    decode_apply_to_attr_id(__TopXMLNS, Id).

encode_apply_to({apply_to, Id, __Els}, __TopXMLNS) ->
    __NewTopXMLNS =
        xmpp_codec:choose_top_xmlns(<<"urn:xmpp:fasten:0">>,
                                    [],
                                    __TopXMLNS),
    _els = [xmpp_codec:encode(_el, __NewTopXMLNS)
            || _el <- __Els],
    _attrs = encode_apply_to_attr_id(Id,
                                     xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
                                                                __TopXMLNS)),
    {xmlel, <<"apply-to">>, _attrs, _els}.

decode_apply_to_attr_id(__TopXMLNS, undefined) -> <<>>;
decode_apply_to_attr_id(__TopXMLNS, _val) -> _val.

encode_apply_to_attr_id(<<>>, _acc) -> _acc;
encode_apply_to_attr_id(_val, _acc) ->
    [{<<"id">>, _val} | _acc].

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
