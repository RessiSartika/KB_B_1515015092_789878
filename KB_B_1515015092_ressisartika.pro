DOMAINS
     nama,jender,pekerjaan,benda,alasan,zat  = symbol
    umur =integer

PREDICATES 
    nondeterm orang(nama, umur, jender, pekerjaan)
    nondeterm selingkuh(nama, nama) 
    terbunuh_dengan(nama, benda) 
    terbunuh(nama)
    nondeterm pembunuh(nama) 
    motif(alasan) 
    ternodai(nama, zat) 
    milik(nama, benda) 
    nondeterm cara_kerja_mirip(benda, benda) 
    nondeterm kemungkinan_milik(nama, benda) 
    nondeterm dicurigai(nama)

/* * * Fakta-fakta tentang pembunuhan * * */ 
CLAUSES
    orang(fajar,55,m,tukang_kayu). 
    orang(wong,25,m,pemain_sepak_bola). 
    orang(willy,25,m,tukang_jagal). 
    orang(andre,25,m,pencopet).  

    selingkuh(lina,joni).  
    selingkuh(lina,budi). 
    selingkuh(siti,joni). 

    terbunuh_dengan(siti,pentungan). 
    terbunuh(siti).

    motif(uang). 
    motif(cemburu). 
    motif(dendam). 

    ternodai(fajar, darah). 
    ternodai(adi, lumpur). 
    ternodai(siti, darah). 
    ternodai(lina, coklat). 
    ternodai(joni, coklat). 

    milik(fajar,kaki_palsu).
    milik(joni,pistol).

/* * * Basis Pengetahuan * * */
    cara_kerja_mirip(kaki_palsu, pentungan). 
    cara_kerja_mirip(balok, pentungan). 
    cara_kerja_mirip(gunting, pisau). 
    cara_kerja_mirip(sepatu_bola, pentungan). 

    kemungkinan_milik(X,sepatu_bola):- 
        orang(X,_,_,pemain_sepak_bola). 
    kemungkinan_milik(X,gunting):- 
        orang(X,_,_,pekerjaan_salon). 
    kemungkinan_milik(X,Benda):- 
        milik(X,Benda).

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*****dicurigai semua orang yang memiliki senjata 
*****yang kerjanya mirip dengan senjata penyebab 
*****siti terbunuh. * * * ** * * * * * * * * * * * * * * * * *  */

    dicurigai(X):- 
        terbunuh_dengan(siti,Senjata) , 
        cara_kerja_mirip(Benda,Senjata) , 
        kemungkinan_milik(X,Benda).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
dicurigai laki-laki yang selingkuh dengan siti. * * * * * * *
 * * * * * * * * * * * * * * * * * * * */ 

    dicurigai(X):- 
        motif(cemburu), 
        orang(X,_,m,_),  
        selingkuh(siti,X).

/* * * * * * * * * * * * * * * * * * * * * * * * 
dicurigai perempuan yang selingkuh dengan * * 
laki-laki yang juga selingkuh dengan siti * * * * * * * * *
 * * * * * * * * * * * * * * */ 
    
    dicurigai(X):- 
        motif(cemburu), 
        orang(X,_,f,_),  
        selingkuh(X,Lakilaki),  
        selingkuh(siti,Lakilaki).

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * 
dicurigai pencopet yang mempunyai motif uang. * * * * * * * 
* * * * * * * * * * * * * * * * * * * * */ 
    
    dicurigai(X):- 
        motif(uang),
        orang(X,_,_,pencopet). 

    pembunuh(Pembunuh):- 
        orang(Pembunuh,_,_,_), 
        terbunuh(Terbunuh), 
        Terbunuh <> Pembunuh, /* Bukan bunuh diri */ 
        dicurigai(Pembunuh),
        ternodai(Pembunuh,Zat),
        ternodai(Terbunuh,Zat).

 Goal: pembunuh (X).