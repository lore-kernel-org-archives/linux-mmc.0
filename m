Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668171;
	b=s2ue+ClpAuGPGhvv9t+tyIJIu3pNFysYfmSeSpHaiOW3AQNDur3UpEZSf+HMFsLzE8kd
	 QXTIynAIdUAlc1HBNo2pFvGAm02e7AC5Gf1lY/jEUV3+HOw1zzcTovOHnYyzvBlUzdHFM
	 cQraKRSec+EAPfN8iPQyGbZSOhBCYiW75itUhxilQ8gATJ6YFX6gzfVF+nSQyri7i/4xO
	 jF9IJUMuDciq/H8AUXvC+eVb8hdo2JZDQkHQUSwDhAz63hkOwQ5AetATN5jCe9MVrfHth
	 vXASRLBFqimz2UliyXYIshWBhmVpFN+r/nRvjPOWAF6r3w5zK4FTfPU0zQ3f0+iKT5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668171;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lIovBDsxm3c+1AuHfs1HngEsYYIn9NYcLWoRryp26/w=;
	b=WwqXwlp7qbz/BfOza7hj3HthRJK12IncPNb3mMuSD47PNfP5x6jCxFsgRr3lcLL1vFww
	 OiKbnvRiA2ah/LGOr+rWkpAiYxo0xgEGfw77UyzVlYwXr04dKkYx3WukH5IhCn1XP8sAA
	 XYm9dT+gv/sKPX4fXLn4enJY5kWoJokmEEhNe4hTmuHb0BaITPZy2g0Rh+xXqlYnykfgR
	 NpcMMYVDPM1L5/Mfgp5NdyjKPrC5OP7h7Si2EZVTU5wxhYPJX1KlEAtWqFteRLTwiNWP6
	 posYxqJccgssXkM0wI8LrfrAAUWJQgewBTEJW56KQBK7GgMx4FtK0k5YFnpsLeOKbZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4F606A319
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 11:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA4F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lIov
	BDsxm3c+1AuHfs1HngEsYYIn9NYcLWoRryp26/w=; b=PRRAxsOXcrEuZF1KxMnl
	bShB1Mhpseyoa1fktDWDt9zMaa+BTseTg6ixm06gGfRM8SC8197/Q9kayDAAU7W7
	srwoktpg+lgGcW5TAE+FY5xdRmDt9ydpa1MUZMdYsoBedU38DRZIzFdOIH6c2zh6
	1GTu7j4xOpwsMyqGvYXWuFjr/TlwqaOEyMAzFR2+ELVWTYWnYbwLb96F47YF0vFf
	CLO520wm4nTb9fWzyFvyb5jfmJlhchkubmvLudu0vfhDk7ArWUOpqdHd+cCyWvn/
	aT50KZamVh6fR0ps6X9E007mgBy/yfMBB1IzN3gCA30G7z6nEv7KELrSm+7LL/9Q
	6g==
Received: (qmail 1121144 invoked from network); 22 Oct 2026 13:22:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2026 13:22:43 +0200
X-UD-Smtp-Session: l3s3148p1@AWMWFWxeQpkujns/
Date: Thu, 22 Oct 2026 13:22:41 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 11/15] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Message-ID: <atnyAfePwJ_9kenH@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-12-biju.das.jz@bp.renesas.com>
 <aplhlynkb_LUiVhS@shikoro>
 <TY3PR01MB11346596836AD38371FC3568A86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346D30496CABEA390A2385986832@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysZcyI4lULtAi+wb"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346D30496CABEA390A2385986832@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--ysZcyI4lULtAi+wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > So initially bit 8+9 will have a value. This will be moved to bit 16
> > + 17 first Then we clear the bits 8 + 9. Bit8(SCLKEN) and
> > Bit9(SDCLKOFFEN)

Okay, I get it now. Thanks for the explanation.

> > > Does RZG3L have a dedicated naming? I'd guess *_HWADJ1. I wonder if it
> > > makes sense to have a dedicated define for it. I tend to think so.
> >=20
> > There is no *_HWADJ1 mentioned in HW manual.
> > Hardware manual mention this register as "SDm_SCC_HWADJ2"

OK.

> >=20
> > >
> > > > +		if (hwadj2)
> > > > +			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0x3FFF);
> > > > +	} else {
> > > >  		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
> > > > +		if (hwadj2)
> > > > +			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
> > >
> > > Magic values?
> >=20
> > HW manual mentions the following,
> >=20
> > HWADJ2[15:0] 1FFh Hardware Adjustment.
> > For 1.8V operation, specify 00FFh.
> > For 3.3V operation, specify 3FFFh.
> >=20
> > Is the below macros ok for representing magic values??
> >=20
> > SD_SCC_HWADJ2_1_8V 0xFF
> > SD_SCC_HWADJ2_3_3V 0x3FFF

If you replace the 'SD_'-prefix with 'RZG3L_SDHI_', then yes :)

> > > I wonder how likely it is that a SDHI variant has either only this or
> > > only TUNING_DELAY. Do you know of one? What would you think about mer=
ging the two? You know the RZ SDHI
> > much better...
> >=20
> > HWADJ2 present only on RZ/G3L,
> > whereas TUNING_DELAY present on both RZ/G2L and RZ/G3L.

Ok, no merging then. Was worth asking.

One more thing I noticed. I think you can drop 'sdhi_quirks_rzg3l' in
favor of 'sdhi_quirks_fixed_addr', or?


Good luck hacking the updates. And thanks for the patience!


--ysZcyI4lULtAi+wb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrZ8gEACgkQFA3kzBSg
KbbuMA/9F2eYMU4tnooba8JXs1gnFf/8HwQK+UeX89ohclYiQ7xHJIXCE6bBdzc+
edscvXMtezLEhrnbQOcZZKlfoFML73OJprbGywMgTrNDTP8gBQgO29nwHGLst0yt
AqD7qIKDh5eJxIaQ/vH2wScAkcEPKHpSgbgvX+O+p4MtHYyO68fmG8TuySpbnfzO
nmywJnVvdZM7pPM3DuO/JtWTrSeULWT01FrFT5v8pVKSZr4PUvHNBJVnWVJN2y0T
xF0REiv2lvgomhxLe8lQLHUqBMiv790y8pw+MPEGiN5PsNWFwwytoKTgIGsMOGlD
7l+RAWrFkhwfAAxAIZJ8EZJQaM/f39s+Y6t01f/T/dqIC7rDT6hx/iI21BH2y/5s
y70uV1uxZiwm137ukX4larfwCxXkdSs2L4N4ib6h2wm671uMOc7s4TsV46dlSZMk
cZFexzBZCWZBB48UjOrjQadeIU5o0FDNigp1VQVXao+9IROLYyhUJa6lewCtvyPc
lNuSTUKNTXEqvABNTGcp4tqBWEYlML0XSdzKV6Zvcp7v/UbO3iQ+VxXx2uz5U4IF
v2wY5Yf9REu8+jB/z3+Jd4+RVdHqV7piuGG2PpxrijcslmRHg5CnYUvjY72+J0eI
A7CZUqDJAN/RbaHtDWXFL5L7JAjqv7WSi3Wt4W4cEbmgyw6eebs=
=9eXK
-----END PGP SIGNATURE-----

--ysZcyI4lULtAi+wb--
