Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4538D40F
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077136; cv=none; b=FqJ0VCTUeUqk7otL9JgnlqcJlScHQMxZwLWseATNv19qvOZuJHrHrigpWBGHXU8KzxfSiA1+7BNZfPvGF96G0kM51Vhtq9L/qDHB361sMDGXKMIdPbDojaWXHVWLhUeP/lbjcc3UUMq7oEWiYsrGcYIrA9qPzSzZmm/eWRQvLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077136; c=relaxed/simple;
	bh=FOw0yj4KnPINDQ47ZccqL85C9a5gUDF4Q2B1clVk0ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxxU0/B1QB87D0p9xKMvlAF13S35P6xi+5MioCdQPDyetlHOLXz/JN8Ml0qUnyqArpXnzWGlYKArgn6nNZ5TBL2atethUTi+Y3D5Xu5fvhJGhzYCsVGHxXvbL5qOM6t6ccaj315GMv3shRYnqoGoSB4idoppGFYr2niSqQUcWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cd50Esq7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cd50Esq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Tf0k
	ECCw0I5WU5psDz+cQ21abySa5IfujkZqAr6RYTE=; b=cd50Esq7IUTUnED2qwSG
	O9AM/D2/KU0r2dRxs4TinBUqCjr1X1vcFwJ7lyIwflqClmQy4bTi9ADA9LsjfEV/
	fZ4UC+QFe0WJ1n5aIAZeSqIObAJdHt6FuqCuxwF7/Ldk3a0mkTLXK36RcRoTjNBh
	I/o7eYGgvpfXwqHnL6m2XSuwwyr0DPRix9YX+zbr4ymaCLLMiY1959At+FpDI/D/
	hJlpgQFdYPZ5bj1/Fp2RjcmFK7XqqfS3Fc+ThGK7+rgNeRYwjFikLDCkHu89U+Jh
	eg6LYYqZpXikF14IQCsJi2kFsyOEIgete6CKLqrwNpcuaFp9LnKaua1dGpTnwidV
	xw==
Received: (qmail 3637333 invoked from network); 10 Sep 2026 23:52:03 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Sep 2026 23:52:03 +0200
X-UD-Smtp-Session: l3s3148p1@lL1t+idbQN0ujnt/
Date: Thu, 10 Sep 2026 23:52:02 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Message-ID: <aqMmfu4mfWXORdnS@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-4-biju.das.jz@bp.renesas.com>
 <apgATHptEbhkohZo@shikoro>
 <TY3PR01MB11346A72764B85A9F9C41F6BC86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r/LHPAWzPtz7Wr2h"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346A72764B85A9F9C41F6BC86B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--r/LHPAWzPtz7Wr2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If (host->mmc->actual_clock < 512), we get clock=3D0.
>=20
>=20
> In this case, shall we set divider to maximum and skip the loop?
> So that clk runs with maximum allowable divider value.
>=20
> Please share your thoughts on this.
>=20
> Or
>=20
> Do you have different solution, please let me know?

I hope I am not confusing things. What about

	clock =3D max(host->mmc->actual_clock / 512, 1);

? The loop should return then the smallest divider which makes sense for
a super-small actual_clock (which is super unlikely but still)?


--r/LHPAWzPtz7Wr2h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqjJn4ACgkQFA3kzBSg
KbbS6Q//WM+346AgZGZ8S3kfQT8Eo84IMPHlwaGZZZUf+/pFyXWVqcDoUsEUkZJ8
F+eBzRxVQr4h+/oRyPI2hdI/fwWitM1ynr3cr3/uXcDz+SA5acr2ygal/KWxSCNX
Na4J6WOa0wF7qZNcxIJpfua500cOMzVWybeF/qBcBcGpP2CLTZlpggUGzrts5WW9
wA2WkiG6+6iAv+zu1u0BS5Upkh8EFgzs68VwozDzrJ8On1ib5eDa+lnE8n4QNgK9
YpMJT4ecEBopT5PQm5MnjEU3PTPI8BrgO4PdY2MIBHWGuOg8itycXiXeruzuEpZX
x9CSl+Uo3eYW6MX3SBj6DvxlGRMSBIKjjOaHLZFY+JY+L0YPGrE1JsNfEzbUEwbM
HsU7WOLbLp6PMm/FcqZvYxU8ozoO3CBiw35tSftU1tNKo0ghbz3JvAlq3fsrUppE
5cE5tdpk1AiZtYLjHPw3WjWQ93+u5GE7FSH3pCdIs4jBip2eO6Lc4E+xmeCIIKH3
LJBGZw7VXmEkyCfsQRW6M5aro74IGh8mtNkPS3quNzsBqI7pzSu38A1LOmJncoKp
kv6duy/kbwEjqVOEjPAo3FbVyN59o4nio6ndoogwgr9G5ujw68PgbfXdWUzGWPko
5RkTY65b0mwffburD6ERfP8/Xush1wTNNBtybsM4MrE7gL2eUfo=
=GwUg
-----END PGP SIGNATURE-----

--r/LHPAWzPtz7Wr2h--
