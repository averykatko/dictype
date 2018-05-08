:- module(dictype, [dictype/1, op(1150, fx, dictype)]).

:- use_module(library(error)).
:- use_module(library(mavis)).
:- use_module(library(pairs)).

:- op(1150, fx, dictype).

dict_type(Dict, Type) :-
	is_dict(Dict),
	is_dict(Type),
	dict_pairs(Dict, Tag, DictPairs),
	dict_pairs(Type, Tag, TypePairs),
	keysort(DictPairs, DictSorted),
	keysort(TypePairs, TypeSorted),
	pairs_keys_values(DictSorted, Keys, DictValues),
	pairs_keys_values(TypeSorted, Keys, TypeValues),
	maplist(the, TypeValues, DictValues).

dictype Spec :-
	is_dict(Spec, Tag),
	assertz((error:has_type(Tag, Dict) :- dict_type(Dict, Spec))).

dictype Spec1, Spec2 :-
	(dictype Spec1),
	(dictype Spec2).
