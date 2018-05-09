/** <module>
dictype - a directive for concise dict type definition
@author Avery Katko
@version 0.0.1
@license MIT
*/
:- module(dictype, [dictype/1, op(1150, fx, dictype)]).

:- use_module(library(error)).
:- use_module(library(mavis)).
:- use_module(library(pairs)).

:- op(1150, fx, dictype).

%! dict_type(Dict:dict, Type:dict).
% body for has_type clauses asserted by dictype directive
dict_type(Dict, Type) :-
	is_dict(Dict, Tag),
	is_dict(Type, Tag),
	dict_pairs(Dict, Tag, DictPairs),
	dict_pairs(Type, Tag, TypePairs),
	keysort(DictPairs, DictSorted),
	keysort(TypePairs, TypeSorted),
	pairs_keys_values(DictSorted, Keys, DictValues),
	pairs_keys_values(TypeSorted, Keys, TypeValues),
	maplist(the, TypeValues, DictValues).

%! dictype(+Spec:compound) is det
% directive to register dict types specified by dicts of the form typename{field1: type1, field2: type2, ...}
dictype Spec :-
	is_dict(Spec, Tag),
	assertz((error:has_type(Tag, Dict) :- dict_type(Dict, Spec))).

dictype Spec1, Spec2 :-
	(dictype Spec1),
	(dictype Spec2).
