#!/usr/bin/env perl

use strict;
use Test::More tests => 14;

use_ok('WWW::Scraper::ISBN::TWPchome_Driver');

ok($WWW::Scraper::ISBN::TWPchome_Driver::VERSION) if $WWW::Scraper::ISBN::TWPchome_Driver::VERSION or 1;

use WWW::Scraper::ISBN;
my $scraper = WWW::Scraper::ISBN->new();
isa_ok($scraper,'WWW::Scraper::ISBN');

$scraper->drivers("TWPchome");
my $isbn = "9864175351";
my $record = $scraper->search($isbn);

SKIP: {
	skip($record->error."\n", 11) unless($record->found);

	is($record->found, 1);
	is($record->found_in, 'TWPchome');

	my $book = $record->book;
	is($book->{'isbn'}, '986-417-535-1');
	is($book->{'title'}, '�Ů����� �� �}�еL�H�v�������s����');
	is($book->{'author'}, '������B���B��   �X��');
	is($book->{'pages'}, '376');
	is($book->{'book_link'}, 'http://ec2.pchome.com.tw/case/000334/00033424.htm');
	is($book->{'image_link'}, 'http://ec2img.pchome.com.tw/case/000334/00033424/BIG.jpg');
	is($book->{'pubdate'}, '2005 �~ 08 �� 05 ��');
	is($book->{'publisher'}, '�ѤU���');
	is($book->{'price_list'}, '450');
}
