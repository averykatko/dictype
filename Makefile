version:=$(shell swipl -q -s pack -g 'version(V),writeln(V)' -t halt)
packfile=dictype-$(version).zip

.PHONY: test package doc all clean

test: test_results.txt
	cat test_results.txt

test_results.txt: prolog/dictype.pl tests/tests.pl
	swipl -s tests/tests.pl -g run_tests,halt -t 'halt(1)' > test_results.txt

$(packfile): pack.pl prolog/dictype.pl tests/tests.pl README.md LICENSE
	zip -r $(packfile) prolog tests pack.pl README.md LICENSE

package: $(packfile)

doc: prolog/dictype.pl
	swipl -q -t 'doc_save(prolog, [doc_root(doc),format(html),title(dictype),if(true),recursive(false)])'

clean:
	rm -rf doc test_results.txt *.zip
