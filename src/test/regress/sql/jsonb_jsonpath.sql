select jsonb '{"a": 12}' @? '$';
select jsonb '{"a": 12}' @? '1';
select jsonb '{"a": 12}' @? '$.a.b';
select jsonb '{"a": 12}' @? '$.b';
select jsonb '{"a": 12}' @? '$.a + 2';
select jsonb '{"a": 12}' @? '$.b + 2';
select jsonb '{"a": {"a": 12}}' @? '$.a.a';
select jsonb '{"a": {"a": 12}}' @? '$.*.a';
select jsonb '{"b": {"a": 12}}' @? '$.*.a';
select jsonb '{"b": {"a": 12}}' @? '$.*.b';
select jsonb '{"b": {"a": 12}}' @? 'strict $.*.b';
select jsonb '{}' @? '$.*';
select jsonb '{"a": 1}' @? '$.*';
select jsonb '{"a": {"b": 1}}' @? 'lax $.**{1}';
select jsonb '{"a": {"b": 1}}' @? 'lax $.**{2}';
select jsonb '{"a": {"b": 1}}' @? 'lax $.**{3}';
select jsonb '[]' @? '$[*]';
select jsonb '[1]' @? '$[*]';
select jsonb '[1]' @? '$[1]';
select jsonb '[1]' @? 'strict $[1]';
select jsonb_path_query('[1]', 'strict $[1]');
select jsonb_path_query('[1]', 'strict $[1]', silent => true);
select jsonb '[1]' @? 'lax $[10000000000000000]';
select jsonb '[1]' @? 'strict $[10000000000000000]';
select jsonb_path_query('[1]', 'lax $[10000000000000000]');
select jsonb_path_query('[1]', 'strict $[10000000000000000]');
select jsonb '[1]' @? '$[0]';
select jsonb '[1]' @? '$[0.3]';
select jsonb '[1]' @? '$[0.5]';
select jsonb '[1]' @? '$[0.9]';
select jsonb '[1]' @? '$[1.2]';
select jsonb '[1]' @? 'strict $[1.2]';
select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$ ? (@.a[*] >  @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$ ? (@.a[*] >= @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,"5"]}' @? '$ ? (@.a[*] >= @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,"5"]}' @? 'strict $ ? (@.a[*] >= @.b[*])';
select jsonb '{"a": [1,2,3], "b": [3,4,null]}' @? '$ ? (@.a[*] >= @.b[*])';
select jsonb '1' @? '$ ? ((@ == "1") is unknown)';
select jsonb '1' @? '$ ? ((@ == 1) is unknown)';
select jsonb '[{"a": 1}, {"a": 2}]' @? '$[0 to 1] ? (@.a > 1)';

select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'lax $[*].a', silent => false);
select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'lax $[*].a', silent => true);
select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'strict $[*].a', silent => false);
select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'strict $[*].a', silent => true);

select jsonb_path_query('1', 'lax $.a');
select jsonb_path_query('1', 'strict $.a');
select jsonb_path_query('1', 'strict $.*');
select jsonb_path_query('1', 'strict $.a', silent => true);
select jsonb_path_query('1', 'strict $.*', silent => true);
select jsonb_path_query('[]', 'lax $.a');
select jsonb_path_query('[]', 'strict $.a');
select jsonb_path_query('[]', 'strict $.a', silent => true);
select jsonb_path_query('{}', 'lax $.a');
select jsonb_path_query('{}', 'strict $.a');
select jsonb_path_query('{}', 'strict $.a', silent => true);

select jsonb_path_query('1', 'strict $[1]');
select jsonb_path_query('1', 'strict $[*]');
select jsonb_path_query('[]', 'strict $[1]');
select jsonb_path_query('[]', 'strict $["a"]');
select jsonb_path_query('1', 'strict $[1]', silent => true);
select jsonb_path_query('1', 'strict $[*]', silent => true);
select jsonb_path_query('[]', 'strict $[1]', silent => true);
select jsonb_path_query('[]', 'strict $["a"]', silent => true);

select jsonb_path_query('{"a": 12, "b": {"a": 13}}', '$.a');
select jsonb_path_query('{"a": 12, "b": {"a": 13}}', '$.b');
select jsonb_path_query('{"a": 12, "b": {"a": 13}}', '$.*');
select jsonb_path_query('{"a": 12, "b": {"a": 13}}', 'lax $.*.a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[*].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[*].*');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[0].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[1].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[2].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[0,1].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[0 to 10].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}]', 'lax $[0 to 10 / 0].a');
select jsonb_path_query('[12, {"a": 13}, {"b": 14}, "ccc", true]', '$[2.5 - 1 to $.size() - 2]');
select jsonb_path_query('1', 'lax $[0]');
select jsonb_path_query('1', 'lax $[*]');
select jsonb_path_query('[1]', 'lax $[0]');
select jsonb_path_query('[1]', 'lax $[*]');
select jsonb_path_query('[1,2,3]', 'lax $[*]');
select jsonb_path_query('[1,2,3]', 'strict $[*].a');
select jsonb_path_query('[1,2,3]', 'strict $[*].a', silent => true);
select jsonb_path_query('[]', '$[last]');
select jsonb_path_query('[]', '$[last ? (exists(last))]');
select jsonb_path_query('[]', 'strict $[last]');
select jsonb_path_query('[]', 'strict $[last]', silent => true);
select jsonb_path_query('[1]', '$[last]');
select jsonb_path_query('[1,2,3]', '$[last]');
select jsonb_path_query('[1,2,3]', '$[last - 1]');
select jsonb_path_query('[1,2,3]', '$[last ? (@.type() == "number")]');
select jsonb_path_query('[1,2,3]', '$[last ? (@.type() == "string")]');
select jsonb_path_query('[1,2,3]', '$[last ? (@.type() == "string")]', silent => true);

select * from jsonb_path_query('{"a": 10}', '$');
select * from jsonb_path_query('{"a": 10}', '$ ? (@.a < $value)');
select * from jsonb_path_query('{"a": 10}', '$ ? (@.a < $value)', '1');
select * from jsonb_path_query('{"a": 10}', '$ ? (@.a < $value)', '[{"value" : 13}]');
select * from jsonb_path_query('{"a": 10}', '$ ? (@.a < $value)', '{"value" : 13}');
select * from jsonb_path_query('{"a": 10}', '$ ? (@.a < $value)', '{"value" : 8}');
select * from jsonb_path_query('{"a": 10}', '$.a ? (@ < $value)', '{"value" : 13}');
select * from jsonb_path_query('[10,11,12,13,14,15]', '$[*] ? (@ < $value)', '{"value" : 13}');
select * from jsonb_path_query('[10,11,12,13,14,15]', '$[0,1] ? (@ < $x.value)', '{"x": {"value" : 13}}');
select * from jsonb_path_query('[10,11,12,13,14,15]', '$[0 to 2] ? (@ < $value)', '{"value" : 15}');
select * from jsonb_path_query('[1,"1",2,"2",null]', '$[*] ? (@ == "1")');
select * from jsonb_path_query('[1,"1",2,"2",null]', '$[*] ? (@ == $value)', '{"value" : "1"}');
select * from jsonb_path_query('[1,"1",2,"2",null]', '$[*] ? (@ == $value)', '{"value" : null}');
select * from jsonb_path_query('[1, "2", null]', '$[*] ? (@ != null)');
select * from jsonb_path_query('[1, "2", null]', '$[*] ? (@ == null)');
select * from jsonb_path_query('{}', '$ ? (@ == @)');
select * from jsonb_path_query('[]', 'strict $ ? (@ == @)');

select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{0}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{0 to last}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{1}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{1 to last}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{2}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{2 to last}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{3 to last}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{last}');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**.b ? (@ > 0)');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{0}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{1}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{0 to last}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{1 to last}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"b": 1}}', 'lax $.**{1 to 2}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**{0}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**{1}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**{0 to last}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**{1 to last}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**{1 to 2}.b ? (@ > 0)');
select jsonb_path_query('{"a": {"c": {"b": 1}}}', 'lax $.**{2 to 3}.b ? (@ > 0)');

select jsonb '{"a": {"b": 1}}' @? '$.**.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{0}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{1}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{0 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{1 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"b": 1}}' @? '$.**{1 to 2}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{0}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{0 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1 to last}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1 to 2}.b ? ( @ > 0)';
select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{2 to 3}.b ? ( @ > 0)';

select jsonb_path_query('{"g": {"x": 2}}', '$.g ? (exists (@.x))');
select jsonb_path_query('{"g": {"x": 2}}', '$.g ? (exists (@.y))');
select jsonb_path_query('{"g": {"x": 2}}', '$.g ? (exists (@.x ? (@ >= 2) ))');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'lax $.g ? (exists (@.x))');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'lax $.g ? (exists (@.x + "3"))');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'lax $.g ? ((exists (@.x + "3")) is unknown)');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'strict $.g[*] ? (exists (@.x))');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'strict $.g[*] ? ((exists (@.x)) is unknown)');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'strict $.g ? (exists (@[*].x))');
select jsonb_path_query('{"g": [{"x": 2}, {"y": 3}]}', 'strict $.g ? ((exists (@[*].x)) is unknown)');

--test ternary logic
select
	x, y,
	jsonb_path_query(
		'[true, false, null]',
		'$[*] ? (@ == true  &&  ($x == true && $y == true) ||
				 @ == false && !($x == true && $y == true) ||
				 @ == null  &&  ($x == true && $y == true) is unknown)',
		jsonb_build_object('x', x, 'y', y)
	) as "x && y"
from
	(values (jsonb 'true'), ('false'), ('"null"')) x(x),
	(values (jsonb 'true'), ('false'), ('"null"')) y(y);

select
	x, y,
	jsonb_path_query(
		'[true, false, null]',
		'$[*] ? (@ == true  &&  ($x == true || $y == true) ||
				 @ == false && !($x == true || $y == true) ||
				 @ == null  &&  ($x == true || $y == true) is unknown)',
		jsonb_build_object('x', x, 'y', y)
	) as "x || y"
from
	(values (jsonb 'true'), ('false'), ('"null"')) x(x),
	(values (jsonb 'true'), ('false'), ('"null"')) y(y);

select jsonb '{"a": 1, "b":1}' @? '$ ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$ ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.c ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.c ? ($.c.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.* ? (@.a == @.b)';
select jsonb '{"a": 1, "b":1}' @? '$.** ? (@.a == @.b)';
select jsonb '{"c": {"a": 1, "b":1}}' @? '$.** ? (@.a == @.b)';

select jsonb_path_query('{"c": {"a": 2, "b":1}}', '$.** ? (@.a == 1 + 1)');
select jsonb_path_query('{"c": {"a": 2, "b":1}}', '$.** ? (@.a == (1 + 1))');
select jsonb_path_query('{"c": {"a": 2, "b":1}}', '$.** ? (@.a == @.b + 1)');
select jsonb_path_query('{"c": {"a": 2, "b":1}}', '$.** ? (@.a == (@.b + 1))');
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == - 1)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == -1)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == -@.b)';
select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == - @.b)';
select jsonb '{"c": {"a": 0, "b":1}}' @? '$.** ? (@.a == 1 - @.b)';
select jsonb '{"c": {"a": 2, "b":1}}' @? '$.** ? (@.a == 1 - - @.b)';
select jsonb '{"c": {"a": 0, "b":1}}' @? '$.** ? (@.a == 1 - +@.b)';
select jsonb '[1,2,3]' @? '$ ? (+@[*] > +2)';
select jsonb '[1,2,3]' @? '$ ? (+@[*] > +3)';
select jsonb '[1,2,3]' @? '$ ? (-@[*] < -2)';
select jsonb '[1,2,3]' @? '$ ? (-@[*] < -3)';
select jsonb '1' @? '$ ? ($ > 0)';

-- arithmetic errors
select jsonb_path_query('[1,2,0,3]', '$[*] ? (2 / @ > 0)');
select jsonb_path_query('[1,2,0,3]', '$[*] ? ((2 / @ > 0) is unknown)');
select jsonb_path_query('0', '1 / $');
select jsonb_path_query('0', '1 / $ + 2');
select jsonb_path_query('0', '-(3 + 1 % $)');
select jsonb_path_query('1', '$ + "2"');
select jsonb_path_query('[1, 2]', '3 * $');
select jsonb_path_query('"a"', '-$');
select jsonb_path_query('[1,"2",3]', '+$');
select jsonb_path_query('1', '$ + "2"', silent => true);
select jsonb_path_query('[1, 2]', '3 * $', silent => true);
select jsonb_path_query('"a"', '-$', silent => true);
select jsonb_path_query('[1,"2",3]', '+$', silent => true);
select jsonb '["1",2,0,3]' @? '-$[*]';
select jsonb '[1,"2",0,3]' @? '-$[*]';
select jsonb '["1",2,0,3]' @? 'strict -$[*]';
select jsonb '[1,"2",0,3]' @? 'strict -$[*]';

-- unwrapping of operator arguments in lax mode
select jsonb_path_query('{"a": [2]}', 'lax $.a * 3');
select jsonb_path_query('{"a": [2]}', 'lax $.a + 3');
select jsonb_path_query('{"a": [2, 3, 4]}', 'lax -$.a');
-- should fail
select jsonb_path_query('{"a": [1, 2]}', 'lax $.a * 3');
select jsonb_path_query('{"a": [1, 2]}', 'lax $.a * 3', silent => true);

-- any key on arrays with and without unwrapping.
select jsonb_path_query('{"a": [1,2,3], "b": [3,4,5]}', '$.*');
select jsonb_path_query('[1,2,3]', '$.*');
select jsonb_path_query('[1,2,3,{"b": [3,4,5]}]', 'lax $.*');
select jsonb_path_query('[1,2,3,{"b": [3,4,5]}]', 'strict $.*');
select jsonb_path_query('[1,2,3,{"b": [3,4,5]}]', 'strict $.*', NULL, true);
select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$.*';
select jsonb '[1,2,3]' @? '$.*';
select jsonb '[1,2,3,{"b": [3,4,5]}]' @? 'lax $.*';
select jsonb '[1,2,3,{"b": [3,4,5]}]' @? 'strict $.*';

-- extension: boolean expressions
select jsonb_path_query('2', '$ > 1');
select jsonb_path_query('2', '$ <= 1');
select jsonb_path_query('2', '$ == "2"');
select jsonb '2' @? '$ == "2"';

select jsonb '2' @@ '$ > 1';
select jsonb '2' @@ '$ <= 1';
select jsonb '2' @@ '$ == "2"';
select jsonb '2' @@ '1';
select jsonb '{}' @@ '$';
select jsonb '[]' @@ '$';
select jsonb '[1,2,3]' @@ '$[*]';
select jsonb '[]' @@ '$[*]';
select jsonb_path_match('[[1, true], [2, false]]', 'strict $[*] ? (@[0] > $x) [1]', '{"x": 1}');
select jsonb_path_match('[[1, true], [2, false]]', 'strict $[*] ? (@[0] < $x) [1]', '{"x": 2}');

select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'lax exists($[*].a)', silent => false);
select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'lax exists($[*].a)', silent => true);
select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'strict exists($[*].a)', silent => false);
select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'strict exists($[*].a)', silent => true);


select jsonb_path_query('[null,1,true,"a",[],{}]', '$.type()');
select jsonb_path_query('[null,1,true,"a",[],{}]', 'lax $.type()');
select jsonb_path_query('[null,1,true,"a",[],{}]', '$[*].type()');
select jsonb_path_query('null', 'null.type()');
select jsonb_path_query('null', 'true.type()');
select jsonb_path_query('null', '(123).type()');
select jsonb_path_query('null', '"123".type()');

select jsonb_path_query('{"a": 2}', '($.a - 5).abs() + 10');
select jsonb_path_query('{"a": 2.5}', '-($.a * $.a).floor() % 4.3');
select jsonb_path_query('[1, 2, 3]', '($[*] > 2) ? (@ == true)');
select jsonb_path_query('[1, 2, 3]', '($[*] > 3).type()');
select jsonb_path_query('[1, 2, 3]', '($[*].a > 3).type()');
select jsonb_path_query('[1, 2, 3]', 'strict ($[*].a > 3).type()');

select jsonb_path_query('[1,null,true,"11",[],[1],[1,2,3],{},{"a":1,"b":2}]', 'strict $[*].size()');
select jsonb_path_query('[1,null,true,"11",[],[1],[1,2,3],{},{"a":1,"b":2}]', 'strict $[*].size()', silent => true);
select jsonb_path_query('[1,null,true,"11",[],[1],[1,2,3],{},{"a":1,"b":2}]', 'lax $[*].size()');

select jsonb_path_query('[0, 1, -2, -3.4, 5.6]', '$[*].abs()');
select jsonb_path_query('[0, 1, -2, -3.4, 5.6]', '$[*].floor()');
select jsonb_path_query('[0, 1, -2, -3.4, 5.6]', '$[*].ceiling()');
select jsonb_path_query('[0, 1, -2, -3.4, 5.6]', '$[*].ceiling().abs()');
select jsonb_path_query('[0, 1, -2, -3.4, 5.6]', '$[*].ceiling().abs().type()');

select jsonb_path_query('[{},1]', '$[*].keyvalue()');
select jsonb_path_query('[{},1]', '$[*].keyvalue()', silent => true);
select jsonb_path_query('{}', '$.keyvalue()');
select jsonb_path_query('{"a": 1, "b": [1, 2], "c": {"a": "bbb"}}', '$.keyvalue()');
select jsonb_path_query('[{"a": 1, "b": [1, 2]}, {"c": {"a": "bbb"}}]', '$[*].keyvalue()');
select jsonb_path_query('[{"a": 1, "b": [1, 2]}, {"c": {"a": "bbb"}}]', 'strict $.keyvalue()');
select jsonb_path_query('[{"a": 1, "b": [1, 2]}, {"c": {"a": "bbb"}}]', 'lax $.keyvalue()');
select jsonb_path_query('[{"a": 1, "b": [1, 2]}, {"c": {"a": "bbb"}}]', 'strict $.keyvalue().a');
select jsonb '{"a": 1, "b": [1, 2]}' @? 'lax $.keyvalue()';
select jsonb '{"a": 1, "b": [1, 2]}' @? 'lax $.keyvalue().key';

select jsonb_path_query('null', '$.double()');
select jsonb_path_query('true', '$.double()');
select jsonb_path_query('null', '$.double()', silent => true);
select jsonb_path_query('true', '$.double()', silent => true);
select jsonb_path_query('[]', '$.double()');
select jsonb_path_query('[]', 'strict $.double()');
select jsonb_path_query('{}', '$.double()');
select jsonb_path_query('[]', 'strict $.double()', silent => true);
select jsonb_path_query('{}', '$.double()', silent => true);
select jsonb_path_query('1.23', '$.double()');
select jsonb_path_query('"1.23"', '$.double()');
select jsonb_path_query('"1.23aaa"', '$.double()');
select jsonb_path_query('1e1000', '$.double()');
select jsonb_path_query('"nan"', '$.double()');
select jsonb_path_query('"NaN"', '$.double()');
select jsonb_path_query('"inf"', '$.double()');
select jsonb_path_query('"-inf"', '$.double()');
select jsonb_path_query('"inf"', '$.double()', silent => true);
select jsonb_path_query('"-inf"', '$.double()', silent => true);

select jsonb_path_query('{}', '$.abs()');
select jsonb_path_query('true', '$.floor()');
select jsonb_path_query('"1.2"', '$.ceiling()');
select jsonb_path_query('{}', '$.abs()', silent => true);
select jsonb_path_query('true', '$.floor()', silent => true);
select jsonb_path_query('"1.2"', '$.ceiling()', silent => true);

select jsonb_path_query('["", "a", "abc", "abcabc"]', '$[*] ? (@ starts with "abc")');
select jsonb_path_query('["", "a", "abc", "abcabc"]', 'strict $ ? (@[*] starts with "abc")');
select jsonb_path_query('["", "a", "abd", "abdabc"]', 'strict $ ? (@[*] starts with "abc")');
select jsonb_path_query('["abc", "abcabc", null, 1]', 'strict $ ? (@[*] starts with "abc")');
select jsonb_path_query('["abc", "abcabc", null, 1]', 'strict $ ? ((@[*] starts with "abc") is unknown)');
select jsonb_path_query('[[null, 1, "abc", "abcabc"]]', 'lax $ ? (@[*] starts with "abc")');
select jsonb_path_query('[[null, 1, "abd", "abdabc"]]', 'lax $ ? ((@[*] starts with "abc") is unknown)');
select jsonb_path_query('[null, 1, "abd", "abdabc"]', 'lax $[*] ? ((@ starts with "abc") is unknown)');

select jsonb_path_query('[null, 1, "abc", "abd", "aBdC", "abdacb", "babc", "adc\nabc", "ab\nadc"]', 'lax $[*] ? (@ like_regex "^ab.*c")');
select jsonb_path_query('[null, 1, "abc", "abd", "aBdC", "abdacb", "babc", "adc\nabc", "ab\nadc"]', 'lax $[*] ? (@ like_regex "^ab.*c" flag "i")');
select jsonb_path_query('[null, 1, "abc", "abd", "aBdC", "abdacb", "babc", "adc\nabc", "ab\nadc"]', 'lax $[*] ? (@ like_regex "^ab.*c" flag "m")');
select jsonb_path_query('[null, 1, "abc", "abd", "aBdC", "abdacb", "babc", "adc\nabc", "ab\nadc"]', 'lax $[*] ? (@ like_regex "^ab.*c" flag "s")');
select jsonb_path_query('[null, 1, "a\b", "a\\b", "^a\\b$"]', 'lax $[*] ? (@ like_regex "a\\b" flag "q")');
select jsonb_path_query('[null, 1, "a\b", "a\\b", "^a\\b$"]', 'lax $[*] ? (@ like_regex "a\\b" flag "")');
select jsonb_path_query('[null, 1, "a\b", "a\\b", "^a\\b$"]', 'lax $[*] ? (@ like_regex "^a\\b$" flag "q")');
select jsonb_path_query('[null, 1, "a\b", "a\\b", "^a\\b$"]', 'lax $[*] ? (@ like_regex "^a\\B$" flag "q")');
select jsonb_path_query('[null, 1, "a\b", "a\\b", "^a\\b$"]', 'lax $[*] ? (@ like_regex "^a\\B$" flag "iq")');
select jsonb_path_query('[null, 1, "a\b", "a\\b", "^a\\b$"]', 'lax $[*] ? (@ like_regex "^a\\b$" flag "")');

select jsonb_path_query('null', '$.datetime()');
select jsonb_path_query('true', '$.datetime()');
select jsonb_path_query('1', '$.datetime()');
select jsonb_path_query('[]', '$.datetime()');
select jsonb_path_query('[]', 'strict $.datetime()');
select jsonb_path_query('{}', '$.datetime()');
select jsonb_path_query('"bogus"', '$.datetime()');
select jsonb_path_query('"12:34"', '$.datetime("aaa")');
select jsonb_path_query('"aaaa"', '$.datetime("HH24")');

select jsonb '"10-03-2017"' @? '$.datetime("dd-mm-yyyy")';
select jsonb_path_query('"10-03-2017"', '$.datetime("dd-mm-yyyy")');
select jsonb_path_query('"10-03-2017"', '$.datetime("dd-mm-yyyy").type()');
select jsonb_path_query('"10-03-2017 12:34"', '$.datetime("dd-mm-yyyy")');
select jsonb_path_query('"10-03-2017 12:34"', '$.datetime("dd-mm-yyyy").type()');

select jsonb_path_query('"10-03-2017 12:34"', '       $.datetime("dd-mm-yyyy HH24:MI").type()');
select jsonb_path_query('"10-03-2017 12:34 +05:20"', '$.datetime("dd-mm-yyyy HH24:MI TZH:TZM").type()');
select jsonb_path_query('"12:34:56"', '$.datetime("HH24:MI:SS").type()');
select jsonb_path_query('"12:34:56 +05:20"', '$.datetime("HH24:MI:SS TZH:TZM").type()');

select jsonb_path_query('"10-03-2017T12:34:56"', '$.datetime("dd-mm-yyyy\"T\"HH24:MI:SS")');
select jsonb_path_query('"10-03-2017t12:34:56"', '$.datetime("dd-mm-yyyy\"T\"HH24:MI:SS")');
select jsonb_path_query('"10-03-2017 12:34:56"', '$.datetime("dd-mm-yyyy\"T\"HH24:MI:SS")');

-- Test .bigint()
select jsonb_path_query('null', '$.bigint()');
select jsonb_path_query('true', '$.bigint()');
select jsonb_path_query('null', '$.bigint()', silent => true);
select jsonb_path_query('true', '$.bigint()', silent => true);
select jsonb_path_query('[]', '$.bigint()');
select jsonb_path_query('[]', 'strict $.bigint()');
select jsonb_path_query('{}', '$.bigint()');
select jsonb_path_query('[]', 'strict $.bigint()', silent => true);
select jsonb_path_query('{}', '$.bigint()', silent => true);
select jsonb_path_query('"1.23"', '$.bigint()');
select jsonb_path_query('"1.23aaa"', '$.bigint()');
select jsonb_path_query('1e1000', '$.bigint()');
select jsonb_path_query('"nan"', '$.bigint()');
select jsonb_path_query('"NaN"', '$.bigint()');
select jsonb_path_query('"inf"', '$.bigint()');
select jsonb_path_query('"-inf"', '$.bigint()');
select jsonb_path_query('"inf"', '$.bigint()', silent => true);
select jsonb_path_query('"-inf"', '$.bigint()', silent => true);
select jsonb_path_query('123', '$.bigint()');
select jsonb_path_query('"123"', '$.bigint()');
select jsonb_path_query('1.23', '$.bigint()');
select jsonb_path_query('1.83', '$.bigint()');
select jsonb_path_query('1234567890123', '$.bigint()');
select jsonb_path_query('"1234567890123"', '$.bigint()');
select jsonb_path_query('12345678901234567890', '$.bigint()');
select jsonb_path_query('"12345678901234567890"', '$.bigint()');
select jsonb_path_query('"+123"', '$.bigint()');
select jsonb_path_query('-123', '$.bigint()');
select jsonb_path_query('"-123"', '$.bigint()');
select jsonb_path_query('123', '$.bigint() * 2');

-- Test .boolean()
select jsonb_path_query('null', '$.boolean()');
select jsonb_path_query('null', '$.boolean()', silent => true);
select jsonb_path_query('[]', '$.boolean()');
select jsonb_path_query('[]', 'strict $.boolean()');
select jsonb_path_query('{}', '$.boolean()');
select jsonb_path_query('[]', 'strict $.boolean()', silent => true);
select jsonb_path_query('{}', '$.boolean()', silent => true);
select jsonb_path_query('1.23', '$.boolean()');
select jsonb_path_query('"1.23"', '$.boolean()');
select jsonb_path_query('"1.23aaa"', '$.boolean()');
select jsonb_path_query('1e1000', '$.boolean()');
select jsonb_path_query('"nan"', '$.boolean()');
select jsonb_path_query('"NaN"', '$.boolean()');
select jsonb_path_query('"inf"', '$.boolean()');
select jsonb_path_query('"-inf"', '$.boolean()');
select jsonb_path_query('"inf"', '$.boolean()', silent => true);
select jsonb_path_query('"-inf"', '$.boolean()', silent => true);
select jsonb_path_query('"100"', '$.boolean()');
select jsonb_path_query('true', '$.boolean()');
select jsonb_path_query('false', '$.boolean()');
select jsonb_path_query('1', '$.boolean()');
select jsonb_path_query('0', '$.boolean()');
select jsonb_path_query('-1', '$.boolean()');
select jsonb_path_query('100', '$.boolean()');
select jsonb_path_query('"1"', '$.boolean()');
select jsonb_path_query('"0"', '$.boolean()');
select jsonb_path_query('"true"', '$.boolean()');
select jsonb_path_query('"false"', '$.boolean()');
select jsonb_path_query('"TRUE"', '$.boolean()');
select jsonb_path_query('"FALSE"', '$.boolean()');
select jsonb_path_query('"yes"', '$.boolean()');
select jsonb_path_query('"NO"', '$.boolean()');
select jsonb_path_query('"T"', '$.boolean()');
select jsonb_path_query('"f"', '$.boolean()');
select jsonb_path_query('"y"', '$.boolean()');
select jsonb_path_query('"N"', '$.boolean()');
select jsonb_path_query('true', '$.boolean().type()');
select jsonb_path_query('123', '$.boolean().type()');
select jsonb_path_query('"Yes"', '$.boolean().type()');
select jsonb_path_query_array('[1, "yes", false]', '$[*].boolean()');

-- Test .date()
select jsonb_path_query('null', '$.date()');
select jsonb_path_query('true', '$.date()');
select jsonb_path_query('1', '$.date()');
select jsonb_path_query('[]', '$.date()');
select jsonb_path_query('[]', 'strict $.date()');
select jsonb_path_query('{}', '$.date()');
select jsonb_path_query('"bogus"', '$.date()');

select jsonb '"2023-08-15"' @? '$.date()';
select jsonb_path_query('"2023-08-15"', '$.date()');
select jsonb_path_query('"2023-08-15"', '$.date().type()');

select jsonb_path_query('"12:34:56"', '$.date()');
select jsonb_path_query('"12:34:56 +05:30"', '$.date()');
select jsonb_path_query('"2023-08-15 12:34:56"', '$.date()');
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.date()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.date()'); -- should work

select jsonb_path_query('"2023-08-15"', '$.date(2)');

-- Test .decimal()
select jsonb_path_query('null', '$.decimal()');
select jsonb_path_query('true', '$.decimal()');
select jsonb_path_query('null', '$.decimal()', silent => true);
select jsonb_path_query('true', '$.decimal()', silent => true);
select jsonb_path_query('[]', '$.decimal()');
select jsonb_path_query('[]', 'strict $.decimal()');
select jsonb_path_query('{}', '$.decimal()');
select jsonb_path_query('[]', 'strict $.decimal()', silent => true);
select jsonb_path_query('{}', '$.decimal()', silent => true);
select jsonb_path_query('1.23', '$.decimal()');
select jsonb_path_query('"1.23"', '$.decimal()');
select jsonb_path_query('"1.23aaa"', '$.decimal()');
select jsonb_path_query('1e1000', '$.decimal()');
select jsonb_path_query('"nan"', '$.decimal()');
select jsonb_path_query('"NaN"', '$.decimal()');
select jsonb_path_query('"inf"', '$.decimal()');
select jsonb_path_query('"-inf"', '$.decimal()');
select jsonb_path_query('"inf"', '$.decimal()', silent => true);
select jsonb_path_query('"-inf"', '$.decimal()', silent => true);
select jsonb_path_query('123', '$.decimal()');
select jsonb_path_query('"123"', '$.decimal()');
select jsonb_path_query('12345678901234567890', '$.decimal()');
select jsonb_path_query('"12345678901234567890"', '$.decimal()');
select jsonb_path_query('"+12.3"', '$.decimal()');
select jsonb_path_query('-12.3', '$.decimal()');
select jsonb_path_query('"-12.3"', '$.decimal()');
select jsonb_path_query('12.3', '$.decimal() * 2');
select jsonb_path_query('12345.678', '$.decimal(6, 1)');
select jsonb_path_query('12345.678', '$.decimal(6, 2)');
select jsonb_path_query('1234.5678', '$.decimal(6, 2)');
select jsonb_path_query('12345.678', '$.decimal(4, 6)');
select jsonb_path_query('12345.678', '$.decimal(0, 6)');
select jsonb_path_query('12345.678', '$.decimal(1001, 6)');
select jsonb_path_query('1234.5678', '$.decimal(+6, +2)');
select jsonb_path_query('1234.5678', '$.decimal(+6, -2)');
select jsonb_path_query('1234.5678', '$.decimal(-6, +2)');
select jsonb_path_query('1234.5678', '$.decimal(6, -1001)');
select jsonb_path_query('1234.5678', '$.decimal(6, 1001)');
select jsonb_path_query('-1234.5678', '$.decimal(+6, -2)');
select jsonb_path_query('0.0123456', '$.decimal(1,2)');
select jsonb_path_query('0.0012345', '$.decimal(2,4)');
select jsonb_path_query('-0.00123456', '$.decimal(2,-4)');
select jsonb_path_query('12.3', '$.decimal(12345678901,1)');
select jsonb_path_query('12.3', '$.decimal(1,12345678901)');

-- Test .integer()
select jsonb_path_query('null', '$.integer()');
select jsonb_path_query('true', '$.integer()');
select jsonb_path_query('null', '$.integer()', silent => true);
select jsonb_path_query('true', '$.integer()', silent => true);
select jsonb_path_query('[]', '$.integer()');
select jsonb_path_query('[]', 'strict $.integer()');
select jsonb_path_query('{}', '$.integer()');
select jsonb_path_query('[]', 'strict $.integer()', silent => true);
select jsonb_path_query('{}', '$.integer()', silent => true);
select jsonb_path_query('"1.23"', '$.integer()');
select jsonb_path_query('"1.23aaa"', '$.integer()');
select jsonb_path_query('1e1000', '$.integer()');
select jsonb_path_query('"nan"', '$.integer()');
select jsonb_path_query('"NaN"', '$.integer()');
select jsonb_path_query('"inf"', '$.integer()');
select jsonb_path_query('"-inf"', '$.integer()');
select jsonb_path_query('"inf"', '$.integer()', silent => true);
select jsonb_path_query('"-inf"', '$.integer()', silent => true);
select jsonb_path_query('123', '$.integer()');
select jsonb_path_query('"123"', '$.integer()');
select jsonb_path_query('1.23', '$.integer()');
select jsonb_path_query('1.83', '$.integer()');
select jsonb_path_query('12345678901', '$.integer()');
select jsonb_path_query('"12345678901"', '$.integer()');
select jsonb_path_query('"+123"', '$.integer()');
select jsonb_path_query('-123', '$.integer()');
select jsonb_path_query('"-123"', '$.integer()');
select jsonb_path_query('123', '$.integer() * 2');

-- Test .number()
select jsonb_path_query('null', '$.number()');
select jsonb_path_query('true', '$.number()');
select jsonb_path_query('null', '$.number()', silent => true);
select jsonb_path_query('true', '$.number()', silent => true);
select jsonb_path_query('[]', '$.number()');
select jsonb_path_query('[]', 'strict $.number()');
select jsonb_path_query('{}', '$.number()');
select jsonb_path_query('[]', 'strict $.number()', silent => true);
select jsonb_path_query('{}', '$.number()', silent => true);
select jsonb_path_query('1.23', '$.number()');
select jsonb_path_query('"1.23"', '$.number()');
select jsonb_path_query('"1.23aaa"', '$.number()');
select jsonb_path_query('1e1000', '$.number()');
select jsonb_path_query('"nan"', '$.number()');
select jsonb_path_query('"NaN"', '$.number()');
select jsonb_path_query('"inf"', '$.number()');
select jsonb_path_query('"-inf"', '$.number()');
select jsonb_path_query('"inf"', '$.number()', silent => true);
select jsonb_path_query('"-inf"', '$.number()', silent => true);
select jsonb_path_query('123', '$.number()');
select jsonb_path_query('"123"', '$.number()');
select jsonb_path_query('12345678901234567890', '$.number()');
select jsonb_path_query('"12345678901234567890"', '$.number()');
select jsonb_path_query('"+12.3"', '$.number()');
select jsonb_path_query('-12.3', '$.number()');
select jsonb_path_query('"-12.3"', '$.number()');
select jsonb_path_query('12.3', '$.number() * 2');

-- Test .string()
select jsonb_path_query('null', '$.string()');
select jsonb_path_query('null', '$.string()', silent => true);
select jsonb_path_query('[]', '$.string()');
select jsonb_path_query('[]', 'strict $.string()');
select jsonb_path_query('{}', '$.string()');
select jsonb_path_query('[]', 'strict $.string()', silent => true);
select jsonb_path_query('{}', '$.string()', silent => true);
select jsonb_path_query('1.23', '$.string()');
select jsonb_path_query('"1.23"', '$.string()');
select jsonb_path_query('"1.23aaa"', '$.string()');
select jsonb_path_query('1234', '$.string()');
select jsonb_path_query('true', '$.string()');
select jsonb_path_query('1234', '$.string().type()');
select jsonb_path_query('[2, true]', '$.string()');
select jsonb_path_query_array('[1.23, "yes", false]', '$[*].string()');
select jsonb_path_query_array('[1.23, "yes", false]', '$[*].string().type()');
select jsonb_path_query('"2023-08-15 12:34:56 +5:30"', '$.timestamp().string()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +5:30"', '$.timestamp().string()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp_tz().string()');
select jsonb_path_query_tz('"2023-08-15 12:34:56"', '$.timestamp_tz().string()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +5:30"', '$.timestamp_tz().string()');
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp().string()');
select jsonb_path_query('"12:34:56 +5:30"', '$.time_tz().string()');
-- this timetz usage will absorb the UTC offset of the current timezone setting
begin;
set local timezone = 'UTC-10';
select jsonb_path_query_tz('"12:34:56"', '$.time_tz().string()');
rollback;
select jsonb_path_query('"12:34:56"', '$.time().string()');
select jsonb_path_query('"2023-08-15"', '$.date().string()');

-- .string() does not react to timezone or datestyle
begin;
set local timezone = 'UTC';
set local datestyle = 'German';
select jsonb_path_query('"2023-08-15 12:34:56 +5:30"', '$.timestamp_tz().string()');
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp().string()');
rollback;

-- Test .time()
select jsonb_path_query('null', '$.time()');
select jsonb_path_query('true', '$.time()');
select jsonb_path_query('1', '$.time()');
select jsonb_path_query('[]', '$.time()');
select jsonb_path_query('[]', 'strict $.time()');
select jsonb_path_query('{}', '$.time()');
select jsonb_path_query('"bogus"', '$.time()');

select jsonb '"12:34:56"' @? '$.time()';
select jsonb_path_query('"12:34:56"', '$.time()');
select jsonb_path_query('"12:34:56"', '$.time().type()');

select jsonb_path_query('"2023-08-15"', '$.time()');
select jsonb_path_query('"12:34:56 +05:30"', '$.time()');
select jsonb_path_query_tz('"12:34:56 +05:30"', '$.time()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56"', '$.time()');

select jsonb_path_query('"12:34:56.789"', '$.time(-1)');
select jsonb_path_query('"12:34:56.789"', '$.time(2.0)');
select jsonb_path_query('"12:34:56.789"', '$.time(12345678901)');
select jsonb_path_query('"12:34:56.789"', '$.time(0)');
select jsonb_path_query('"12:34:56.789"', '$.time(2)');
select jsonb_path_query('"12:34:56.789"', '$.time(5)');
select jsonb_path_query('"12:34:56.789"', '$.time(10)');
select jsonb_path_query('"12:34:56.789012"', '$.time(8)');

-- Test .time_tz()
select jsonb_path_query('null', '$.time_tz()');
select jsonb_path_query('true', '$.time_tz()');
select jsonb_path_query('1', '$.time_tz()');
select jsonb_path_query('[]', '$.time_tz()');
select jsonb_path_query('[]', 'strict $.time_tz()');
select jsonb_path_query('{}', '$.time_tz()');
select jsonb_path_query('"bogus"', '$.time_tz()');

select jsonb '"12:34:56 +05:30"' @? '$.time_tz()';
select jsonb_path_query('"12:34:56 +05:30"', '$.time_tz()');
select jsonb_path_query('"12:34:56 +05:30"', '$.time_tz().type()');

select jsonb_path_query('"2023-08-15"', '$.time_tz()');
select jsonb_path_query('"2023-08-15 12:34:56"', '$.time_tz()');

select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(-1)');
select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(2.0)');
select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(12345678901)');
select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(0)');
select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(2)');
select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(5)');
select jsonb_path_query('"12:34:56.789 +05:30"', '$.time_tz(10)');
select jsonb_path_query('"12:34:56.789012 +05:30"', '$.time_tz(8)');

-- Test .timestamp()
select jsonb_path_query('null', '$.timestamp()');
select jsonb_path_query('true', '$.timestamp()');
select jsonb_path_query('1', '$.timestamp()');
select jsonb_path_query('[]', '$.timestamp()');
select jsonb_path_query('[]', 'strict $.timestamp()');
select jsonb_path_query('{}', '$.timestamp()');
select jsonb_path_query('"bogus"', '$.timestamp()');

select jsonb '"2023-08-15 12:34:56"' @? '$.timestamp()';
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp()');
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp().type()');

select jsonb_path_query('"2023-08-15"', '$.timestamp()');
select jsonb_path_query('"12:34:56"', '$.timestamp()');
select jsonb_path_query('"12:34:56 +05:30"', '$.timestamp()');

select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(-1)');
select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(2.0)');
select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(12345678901)');
select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(0)');
select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(2)');
select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(5)');
select jsonb_path_query('"2023-08-15 12:34:56.789"', '$.timestamp(10)');
select jsonb_path_query('"2023-08-15 12:34:56.789012"', '$.timestamp(8)');

-- Test .timestamp_tz()
select jsonb_path_query('null', '$.timestamp_tz()');
select jsonb_path_query('true', '$.timestamp_tz()');
select jsonb_path_query('1', '$.timestamp_tz()');
select jsonb_path_query('[]', '$.timestamp_tz()');
select jsonb_path_query('[]', 'strict $.timestamp_tz()');
select jsonb_path_query('{}', '$.timestamp_tz()');
select jsonb_path_query('"bogus"', '$.timestamp_tz()');

select jsonb '"2023-08-15 12:34:56 +05:30"' @? '$.timestamp_tz()';
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp_tz()');
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp_tz().type()');

select jsonb_path_query('"2023-08-15"', '$.timestamp_tz()');
select jsonb_path_query_tz('"2023-08-15"', '$.timestamp_tz()'); -- should work
select jsonb_path_query('"12:34:56"', '$.timestamp_tz()');
select jsonb_path_query('"12:34:56 +05:30"', '$.timestamp_tz()');

select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(-1)');
select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(2.0)');
select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(12345678901)');
select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(0)');
select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(2)');
select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(5)');
select jsonb_path_query('"2023-08-15 12:34:56.789 +05:30"', '$.timestamp_tz(10)');
select jsonb_path_query('"2023-08-15 12:34:56.789012 +05:30"', '$.timestamp_tz(8)');


set time zone '+00';

select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.time()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.time()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.time_tz()');
select jsonb_path_query('"12:34:56"', '$.time_tz()');
select jsonb_path_query_tz('"12:34:56"', '$.time_tz()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.timestamp()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp_tz()');
select jsonb_path_query_tz('"2023-08-15 12:34:56"', '$.timestamp_tz()'); -- should work

select jsonb_path_query('"10-03-2017 12:34"', '$.datetime("dd-mm-yyyy HH24:MI")');
select jsonb_path_query('"10-03-2017 12:34"', '$.datetime("dd-mm-yyyy HH24:MI TZH")');
select jsonb_path_query('"10-03-2017 12:34 +05"', '$.datetime("dd-mm-yyyy HH24:MI TZH")');
select jsonb_path_query('"10-03-2017 12:34 -05"', '$.datetime("dd-mm-yyyy HH24:MI TZH")');
select jsonb_path_query('"10-03-2017 12:34 +05:20"', '$.datetime("dd-mm-yyyy HH24:MI TZH:TZM")');
select jsonb_path_query('"10-03-2017 12:34 -05:20"', '$.datetime("dd-mm-yyyy HH24:MI TZH:TZM")');
select jsonb_path_query('"12:34"', '$.datetime("HH24:MI")');
select jsonb_path_query('"12:34"', '$.datetime("HH24:MI TZH")');
select jsonb_path_query('"12:34 +05"', '$.datetime("HH24:MI TZH")');
select jsonb_path_query('"12:34 -05"', '$.datetime("HH24:MI TZH")');
select jsonb_path_query('"12:34 +05:20"', '$.datetime("HH24:MI TZH:TZM")');
select jsonb_path_query('"12:34 -05:20"', '$.datetime("HH24:MI TZH:TZM")');

set time zone '+10';

select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.time()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.time()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.time_tz()');
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.timestamp()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56"', '$.timestamp_tz()');
select jsonb_path_query_tz('"2023-08-15 12:34:56"', '$.timestamp_tz()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp_tz()');

select jsonb_path_query('"10-03-2017 12:34"', '$.datetime("dd-mm-yyyy HH24:MI")');
select jsonb_path_query('"10-03-2017 12:34"', '$.datetime("dd-mm-yyyy HH24:MI TZH")');
select jsonb_path_query('"10-03-2017 12:34 +05"', '$.datetime("dd-mm-yyyy HH24:MI TZH")');
select jsonb_path_query('"10-03-2017 12:34 -05"', '$.datetime("dd-mm-yyyy HH24:MI TZH")');
select jsonb_path_query('"10-03-2017 12:34 +05:20"', '$.datetime("dd-mm-yyyy HH24:MI TZH:TZM")');
select jsonb_path_query('"10-03-2017 12:34 -05:20"', '$.datetime("dd-mm-yyyy HH24:MI TZH:TZM")');
select jsonb_path_query('"12:34"', '$.datetime("HH24:MI")');
select jsonb_path_query('"12:34"', '$.datetime("HH24:MI TZH")');
select jsonb_path_query('"12:34 +05"', '$.datetime("HH24:MI TZH")');
select jsonb_path_query('"12:34 -05"', '$.datetime("HH24:MI TZH")');
select jsonb_path_query('"12:34 +05:20"', '$.datetime("HH24:MI TZH:TZM")');
select jsonb_path_query('"12:34 -05:20"', '$.datetime("HH24:MI TZH:TZM")');

set time zone default;

select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.time()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.time()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.time_tz()');
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp()');
select jsonb_path_query_tz('"2023-08-15 12:34:56 +05:30"', '$.timestamp()'); -- should work
select jsonb_path_query('"2023-08-15 12:34:56 +05:30"', '$.timestamp_tz()');

select jsonb_path_query('"2017-03-10"', '$.datetime().type()');
select jsonb_path_query('"2017-03-10"', '$.datetime()');
select jsonb_path_query('"2017-03-10 12:34:56"', '$.datetime().type()');
select jsonb_path_query('"2017-03-10 12:34:56"', '$.datetime()');
select jsonb_path_query('"2017-03-10 12:34:56+3"', '$.datetime().type()');
select jsonb_path_query('"2017-03-10 12:34:56+3"', '$.datetime()');
select jsonb_path_query('"2017-03-10 12:34:56+3:10"', '$.datetime().type()');
select jsonb_path_query('"2017-03-10 12:34:56+3:10"', '$.datetime()');
select jsonb_path_query('"2017-03-10T12:34:56+3:10"', '$.datetime()');
select jsonb_path_query('"2017-03-10t12:34:56+3:10"', '$.datetime()');
select jsonb_path_query('"2017-03-10 12:34:56.789+3:10"', '$.datetime()');
select jsonb_path_query('"2017-03-10T12:34:56.789+3:10"', '$.datetime()');
select jsonb_path_query('"2017-03-10t12:34:56.789+3:10"', '$.datetime()');
select jsonb_path_query('"2017-03-10T12:34:56.789EST"', '$.datetime()');
select jsonb_path_query('"2017-03-10T12:34:56.789Z"', '$.datetime()');
select jsonb_path_query('"12:34:56"', '$.datetime().type()');
select jsonb_path_query('"12:34:56"', '$.datetime()');
select jsonb_path_query('"12:34:56+3"', '$.datetime().type()');
select jsonb_path_query('"12:34:56+3"', '$.datetime()');
select jsonb_path_query('"12:34:56+3:10"', '$.datetime().type()');
select jsonb_path_query('"12:34:56+3:10"', '$.datetime()');

set time zone '+00';

-- date comparison
select jsonb_path_query(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ == "10.03.2017".datetime("dd.mm.yyyy"))');
select jsonb_path_query(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ >= "10.03.2017".datetime("dd.mm.yyyy"))');
select jsonb_path_query(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ <  "10.03.2017".datetime("dd.mm.yyyy"))');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ == "10.03.2017".datetime("dd.mm.yyyy"))');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ >= "10.03.2017".datetime("dd.mm.yyyy"))');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "12:34:56", "01:02:03+04", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ <  "10.03.2017".datetime("dd.mm.yyyy"))');

select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ == "2017-03-10".date())');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ >= "2017-03-10".date())');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].datetime() ? (@ <  "2017-03-10".date())');
select jsonb_path_query(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].date() ? (@ == "2017-03-10".date())');
select jsonb_path_query(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].date() ? (@ >= "2017-03-10".date())');
select jsonb_path_query(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].date() ? (@ <  "2017-03-10".date())');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].date() ? (@ == "2017-03-10".date())');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].date() ? (@ >= "2017-03-10".date())');
select jsonb_path_query_tz(
	'["2017-03-10", "2017-03-11", "2017-03-09", "2017-03-10 00:00:00", "2017-03-10 12:34:56", "2017-03-10 01:02:03+04", "2017-03-10 03:00:00+03"]',
	'$[*].date() ? (@ <  "2017-03-10".date())');

-- time comparison
select jsonb_path_query(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ == "12:35".datetime("HH24:MI"))');
select jsonb_path_query(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ >= "12:35".datetime("HH24:MI"))');
select jsonb_path_query(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ <  "12:35".datetime("HH24:MI"))');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ == "12:35".datetime("HH24:MI"))');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ >= "12:35".datetime("HH24:MI"))');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ <  "12:35".datetime("HH24:MI"))');

select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ == "12:35:00".time())');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ >= "12:35:00".time())');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].datetime() ? (@ <  "12:35:00".time())');
select jsonb_path_query(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].time() ? (@ == "12:35:00".time())');
select jsonb_path_query(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].time() ? (@ >= "12:35:00".time())');
select jsonb_path_query(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].time() ? (@ <  "12:35:00".time())');
select jsonb_path_query(
	'["12:34:00.123", "12:35:00.123", "12:36:00.1123", "12:35:00.1123+00", "12:35:00.123+01", "13:35:00.123+01", "2017-03-10 12:35:00.1", "2017-03-10 12:35:00.123+01"]',
	'$[*].time(2) ? (@ >= "12:35:00.123".time(2))');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].time() ? (@ == "12:35:00".time())');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].time() ? (@ >= "12:35:00".time())');
select jsonb_path_query_tz(
	'["12:34:00", "12:35:00", "12:36:00", "12:35:00+00", "12:35:00+01", "13:35:00+01", "2017-03-10 12:35:00", "2017-03-10 12:35:00+01"]',
	'$[*].time() ? (@ <  "12:35:00".time())');
select jsonb_path_query_tz(
	'["12:34:00.123", "12:35:00.123", "12:36:00.1123", "12:35:00.1123+00", "12:35:00.123+01", "13:35:00.123+01", "2017-03-10 12:35:00.1", "2017-03-10 12:35:00.123+01"]',
	'$[*].time(2) ? (@ >= "12:35:00.123".time(2))');


-- timetz comparison
select jsonb_path_query(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ == "12:35 +1".datetime("HH24:MI TZH"))');
select jsonb_path_query(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ >= "12:35 +1".datetime("HH24:MI TZH"))');
select jsonb_path_query(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ <  "12:35 +1".datetime("HH24:MI TZH"))');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ == "12:35 +1".datetime("HH24:MI TZH"))');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ >= "12:35 +1".datetime("HH24:MI TZH"))');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10", "2017-03-10 12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ <  "12:35 +1".datetime("HH24:MI TZH"))');

select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ == "12:35:00 +1".time_tz())');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ >= "12:35:00 +1".time_tz())');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].datetime() ? (@ <  "12:35:00 +1".time_tz())');
select jsonb_path_query(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].time_tz() ? (@ == "12:35:00 +1".time_tz())');
select jsonb_path_query(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].time_tz() ? (@ >= "12:35:00 +1".time_tz())');
select jsonb_path_query(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].time_tz() ? (@ <  "12:35:00 +1".time_tz())');
select jsonb_path_query(
	'["12:34:00.123+01", "12:35:00.123+01", "12:36:00.1123+01", "12:35:00.1123+02", "12:35:00.123-02", "10:35:00.123", "11:35:00.1", "12:35:00.123", "2017-03-10 12:35:00.123 +1"]',
	'$[*].time_tz(2) ? (@ >= "12:35:00.123 +1".time_tz(2))');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].time_tz() ? (@ == "12:35:00 +1".time_tz())');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].time_tz() ? (@ >= "12:35:00 +1".time_tz())');
select jsonb_path_query_tz(
	'["12:34:00+01", "12:35:00+01", "12:36:00+01", "12:35:00+02", "12:35:00-02", "10:35:00", "11:35:00", "12:35:00", "2017-03-10 12:35:00 +1"]',
	'$[*].time_tz() ? (@ <  "12:35:00 +1".time_tz())');
select jsonb_path_query_tz(
	'["12:34:00.123+01", "12:35:00.123+01", "12:36:00.1123+01", "12:35:00.1123+02", "12:35:00.123-02", "10:35:00.123", "11:35:00.1", "12:35:00.123", "2017-03-10 12:35:00.123 +1"]',
	'$[*].time_tz(2) ? (@ >= "12:35:00.123 +1".time_tz(2))');

-- timestamp comparison
select jsonb_path_query(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ == "10.03.2017 12:35".datetime("dd.mm.yyyy HH24:MI"))');
select jsonb_path_query(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ >= "10.03.2017 12:35".datetime("dd.mm.yyyy HH24:MI"))');
select jsonb_path_query(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ < "10.03.2017 12:35".datetime("dd.mm.yyyy HH24:MI"))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ == "10.03.2017 12:35".datetime("dd.mm.yyyy HH24:MI"))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ >= "10.03.2017 12:35".datetime("dd.mm.yyyy HH24:MI"))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ < "10.03.2017 12:35".datetime("dd.mm.yyyy HH24:MI"))');

select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].datetime() ? (@ == "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].datetime() ? (@ >= "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].datetime() ? (@ < "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp() ? (@ == "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp() ? (@ >= "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp() ? (@ < "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query(
	'["2017-03-10 12:34:00.123", "2017-03-10 12:35:00.123", "2017-03-10 12:36:00.1123", "2017-03-10 12:35:00.1123+01", "2017-03-10 13:35:00.123+01", "2017-03-10 12:35:00.1-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp(2) ? (@ >= "2017-03-10 12:35:00.123".timestamp(2))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp() ? (@ == "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp() ? (@ >= "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00", "2017-03-10 12:35:00", "2017-03-10 12:36:00", "2017-03-10 12:35:00+01", "2017-03-10 13:35:00+01", "2017-03-10 12:35:00-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp() ? (@ < "2017-03-10 12:35:00".timestamp())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00.123", "2017-03-10 12:35:00.123", "2017-03-10 12:36:00.1123", "2017-03-10 12:35:00.1123+01", "2017-03-10 13:35:00.123+01", "2017-03-10 12:35:00.1-01", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp(2) ? (@ >= "2017-03-10 12:35:00.123".timestamp(2))');

-- timestamptz comparison
select jsonb_path_query(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ == "10.03.2017 12:35 +1".datetime("dd.mm.yyyy HH24:MI TZH"))');
select jsonb_path_query(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ >= "10.03.2017 12:35 +1".datetime("dd.mm.yyyy HH24:MI TZH"))');
select jsonb_path_query(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ < "10.03.2017 12:35 +1".datetime("dd.mm.yyyy HH24:MI TZH"))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ == "10.03.2017 12:35 +1".datetime("dd.mm.yyyy HH24:MI TZH"))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ >= "10.03.2017 12:35 +1".datetime("dd.mm.yyyy HH24:MI TZH"))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11", "12:34:56", "12:34:56+01"]',
	'$[*].datetime() ? (@ < "10.03.2017 12:35 +1".datetime("dd.mm.yyyy HH24:MI TZH"))');

select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].datetime() ? (@ == "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].datetime() ? (@ >= "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].datetime() ? (@ < "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz() ? (@ == "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz() ? (@ >= "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz() ? (@ < "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query(
	'["2017-03-10 12:34:00.123+01", "2017-03-10 12:35:00.123+01", "2017-03-10 12:36:00.1123+01", "2017-03-10 12:35:00.1123+02", "2017-03-10 12:35:00.123-02", "2017-03-10 10:35:00.123", "2017-03-10 11:35:00.1", "2017-03-10 12:35:00.123", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz(2) ? (@ >= "2017-03-10 12:35:00.123 +1".timestamp_tz(2))');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz() ? (@ == "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz() ? (@ >= "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00+01", "2017-03-10 12:35:00+01", "2017-03-10 12:36:00+01", "2017-03-10 12:35:00+02", "2017-03-10 12:35:00-02", "2017-03-10 10:35:00", "2017-03-10 11:35:00", "2017-03-10 12:35:00", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz() ? (@ < "2017-03-10 12:35:00 +1".timestamp_tz())');
select jsonb_path_query_tz(
	'["2017-03-10 12:34:00.123+01", "2017-03-10 12:35:00.123+01", "2017-03-10 12:36:00.1123+01", "2017-03-10 12:35:00.1123+02", "2017-03-10 12:35:00.123-02", "2017-03-10 10:35:00.123", "2017-03-10 11:35:00.1", "2017-03-10 12:35:00.123", "2017-03-10", "2017-03-11"]',
	'$[*].timestamp_tz(2) ? (@ >= "2017-03-10 12:35:00.123 +1".timestamp_tz(2))');


-- overflow during comparison
select jsonb_path_query('"1000000-01-01"', '$.datetime() > "2020-01-01 12:00:00".datetime()'::jsonpath);

set time zone default;

-- jsonpath operators

SELECT jsonb_path_query('[{"a": 1}, {"a": 2}]', '$[*]');
SELECT jsonb_path_query('[{"a": 1}, {"a": 2}]', '$[*] ? (@.a > 10)');
SELECT jsonb_path_query('[{"a": 1}]', '$undefined_var');
SELECT jsonb_path_query('[{"a": 1}]', 'false');

SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}, {}]', 'strict $[*].a');
SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}]', '$[*].a');
SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}]', '$[*].a ? (@ == 1)');
SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}]', '$[*].a ? (@ > 10)');
SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 1, "max": 4}');
SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 3, "max": 4}');

SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {}]', 'strict $[*].a');
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {}]', 'strict $[*].a', silent => true);
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}]', '$[*].a');
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}]', '$[*].a ? (@ == 1)');
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}]', '$[*].a ? (@ > 10)');
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 1, "max": 4}');
SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 3, "max": 4}');
SELECT jsonb_path_query_first('[{"a": 1}]', '$undefined_var');
SELECT jsonb_path_query_first('[{"a": 1}]', 'false');

SELECT jsonb '[{"a": 1}, {"a": 2}]' @? '$[*].a ? (@ > 1)';
SELECT jsonb '[{"a": 1}, {"a": 2}]' @? '$[*] ? (@.a > 2)';
SELECT jsonb_path_exists('[{"a": 1}, {"a": 2}]', '$[*].a ? (@ > 1)');
SELECT jsonb_path_exists('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*] ? (@.a > $min && @.a < $max)', vars => '{"min": 1, "max": 4}');
SELECT jsonb_path_exists('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*] ? (@.a > $min && @.a < $max)', vars => '{"min": 3, "max": 4}');
SELECT jsonb_path_exists('[{"a": 1}]', '$undefined_var');
SELECT jsonb_path_exists('[{"a": 1}]', 'false');

SELECT jsonb_path_match('true', '$', silent => false);
SELECT jsonb_path_match('false', '$', silent => false);
SELECT jsonb_path_match('null', '$', silent => false);
SELECT jsonb_path_match('1', '$', silent => true);
SELECT jsonb_path_match('1', '$', silent => false);
SELECT jsonb_path_match('"a"', '$', silent => false);
SELECT jsonb_path_match('{}', '$', silent => false);
SELECT jsonb_path_match('[true]', '$', silent => false);
SELECT jsonb_path_match('{}', 'lax $.a', silent => false);
SELECT jsonb_path_match('{}', 'strict $.a', silent => false);
SELECT jsonb_path_match('{}', 'strict $.a', silent => true);
SELECT jsonb_path_match('[true, true]', '$[*]', silent => false);
SELECT jsonb '[{"a": 1}, {"a": 2}]' @@ '$[*].a > 1';
SELECT jsonb '[{"a": 1}, {"a": 2}]' @@ '$[*].a > 2';
SELECT jsonb_path_match('[{"a": 1}, {"a": 2}]', '$[*].a > 1');
SELECT jsonb_path_match('[{"a": 1}]', '$undefined_var');
SELECT jsonb_path_match('[{"a": 1}]', 'false');

-- test string comparison (Unicode codepoint collation)
WITH str(j, num) AS
(
	SELECT jsonb_build_object('s', s), num
	FROM unnest('{"", "a", "ab", "abc", "abcd", "b", "A", "AB", "ABC", "ABc", "ABcD", "B"}'::text[]) WITH ORDINALITY AS a(s, num)
)
SELECT
	s1.j, s2.j,
	jsonb_path_query_first(s1.j, '$.s < $s', vars => s2.j) lt,
	jsonb_path_query_first(s1.j, '$.s <= $s', vars => s2.j) le,
	jsonb_path_query_first(s1.j, '$.s == $s', vars => s2.j) eq,
	jsonb_path_query_first(s1.j, '$.s >= $s', vars => s2.j) ge,
	jsonb_path_query_first(s1.j, '$.s > $s', vars => s2.j) gt
FROM str s1, str s2
ORDER BY s1.num, s2.num;
