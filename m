Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAB49B5B7
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077411; cv=none; b=GVS37UPWtredsHUPKIb2UhWEaI+HF39pncEmNC7qZqyFUSa5nOV38jFVYowvixfIXr1BMwq7e6VcqlGsas0foeD9X62CaYmBw6YFCe/p1GhxnYLlbP86f43j5gLUGAyN47F47gnLYZd0/SlENHv5mnr05Sj4YdcK7sVskSs5huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077411; c=relaxed/simple;
	bh=CWaC0fTsUKpac4O5WTzq8s1kyRTvQkg7iAWOBnBFHUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm+W0ELZfAjGD5i4DIT4z4tTQM1svauB4a9/g8+z5fylzSxsJmfvYw2P73vYcgV5xiyaOgQhAgtClYqohNBiPxpeaglyENf/N8+csfJs3k2jdqvHDTVvmZ87eSEDJ3MZdoMZNQGyDJPmgNs1nfQrxnsAqGTORT3e6d/HqFT0vNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=I2dAez65; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="I2dAez65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nsEB
	oEDySqPtp6kqV31QKHXsFwNw/aSZNpzV0OJWL3I=; b=I2dAez656iLlrDIDsFcu
	0d2TiSGwXGIZGkOJYy/1IKjtftEep2wXiB5xAOHB423w06nJEx2gfWXq0P8nGDo0
	hFr1PDEBV+dpl63kR2McssmtsCi4JuXmkEJk29aBYjOQosFjKsH+TgarVxt2z+0t
	X89CvA61DnEJ1ijHJ8fVv6SouhAzappUdLuOMzN4y0dG3XKuZxatSK4dDSe1p9RV
	akxeO8BI0Ev0/DJYVwGJBlmhcbLFHVZ3dzw6vYsJ61f+yJsYV1G++PoQqHSu+kCR
	pcMYTcNhS1auGFu/WT8jKroGaIHX6omuEnnBrk6hjju+DJ5IBK5qYAI/Scx2gl4b
	Og==
Received: (qmail 3638278 invoked from network); 10 Sep 2026 23:56:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Sep 2026 23:56:47 +0200
X-UD-Smtp-Session: l3s3148p1@D6pVCyhbYKIujnt/
Date: Thu, 10 Sep 2026 23:56:46 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
Message-ID: <aqMnnjs_9tzfuPem@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-5-biju.das.jz@bp.renesas.com>
 <apgC-m7SrDNU9YmQ@shikoro>
 <TY3PR01MB11346696A5DF407A8E25150F186B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CLUXuWf+OlF+qkdd"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346696A5DF407A8E25150F186B52@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--CLUXuWf+OlF+qkdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > -	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) / 512, 1L);
> > > +	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) /
> > > +host->pdata->max_divider, 1L);
> >=20
> > ... because the existing code is just too subtle / fragile and hard to =
understand. I think we should move
> > clk_round_rate() out of max() and handle it seperatly before. What do y=
ou think?
>=20
> You mean use, max(clk_get_rate(priv->clk) / 512, 1);
>=20
> clk_get_rate() returns unsigned long compared to clk_round_rate() which r=
eturn long??

I mean

	rate =3D clk_round_rate(priv->clk, 1);
	if (rate < 0)
		...
	mmc->f_min =3D max(rate / host->pdata->max_divider, 1L);

Makes sense?

--CLUXuWf+OlF+qkdd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqjJ54ACgkQFA3kzBSg
KbZGRxAAm3JRYA2YPuVxHhvnJi/ugfncRwwLm7XC0TUvCcfeSsraFTnIgXQ+R5aQ
yXIa+2wASuMC156+xUGy+/48o5gEUUB6EDPV4slt8/OMAHxG+w6Hxh+K5Xz42KVG
U2JJiNg4FH50PypqNLM10/WbiLkM0DLa0JeN2Ta9YyLg/cas0cyPMMLvfae/rNon
zAcUcrJJ5uXQQHTmxQ9G/4wNvn9rzfPvX13Xfg4p85k9PKnPI+9nZ1DF+AVKAQV5
zQ+foTKKpWTc/rcNSc+3C+ufIB8TyNthQ5XTvA6sG5ixysi0EHP5LRfylFo7vO4q
p2kSaOa3TtAsor6VhH3XTQZJucl03sPSKUaFliRxbeC39NJ2cZYjgr73o/VRRouE
AZPcTw8Q08CrAcn+K+qBjCSS4ACrgxPN6QpdqDL44C/6bOh4gh0OdEozYlXjWyYi
xma6P0F+YM0R6Uv7DtGC5W0sXohaf8XfQxjxIFyT+hP+eItEatx1dbV2IoM74i3I
jStNHWc31a+e/aPq0mRVlzIsNwzlGK/BI2NCaCLZeouSKPPz6134jtwgOXA+3cI2
pJkqGXW/r8pfEeenZQELXI8EkbzPymyVuzYJxU75q/nEPuusRP7j7c0WL8UJVEoT
wAvJadGcnRJOpHTTme7Pg0rUQqwVajzwCQPzTTizoCfKZdM87pE=
=TRkD
-----END PGP SIGNATURE-----

--CLUXuWf+OlF+qkdd--
