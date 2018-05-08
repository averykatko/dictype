:- begin_tests(dictype).
:- use_module(prolog/dictype).

:- dictype point{x:integer, y:integer}.

test(point_good) :-
	must_be(point, point{x: 5, y: -22}).

test(point_with_floats, error(type_error(integer, 0.5))) :-
	must_be(point, point{x: 0.5, y: 1.5}).

test(point_with_z, error(type_error(point, point{x: 1, y: 2, z: 3}))) :-
	must_be(point, point{x: 1, y: 2, z: 3}).

:- dictype box{tl: point, br: point}.

test(box_good) :-
	must_be(box, box{tl: point{x: 1, y: 2}, br: point{x: 3, y: 4}}).

% commas:

:- dictype
	circle{center: point, radius: integer},
	segment{a: point, b: point}.

test(circle_good) :-
	must_be(circle, circle{center: point{x: 0, y: 0}, radius: 5}).

test(segment_good) :-
	must_be(segment, segment{a: point{x: 1, y: 2}, b: point{x: 3, y: 4}}).

:- end_tests(dictype).
