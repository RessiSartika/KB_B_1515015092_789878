predicates
	nondeterm hari(simbol,symbol,integer)
	nondeterm ruang(symbol,symbol)
	nondeterm nilai(integer,integer,integer)
	
clauses
	hari (senin,smbd,20000).
	hari (selasa,visual,30000).
	hari (rabu,kommas,25000).
	hari (kamis,framework,20000).
		ruang(senin,lab bp).
		ruang(selasa,puskom).
	nilai(X,Y,Hasil):-
	Hasil=X+Y
	
goal
	hari(hari,matkul,Bayar),Bayar>20000;
	ruang(selasa,puskom);
	nilai(50,40,Hasil).
	