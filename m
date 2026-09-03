Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7906470421
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428282; cv=none; b=fMlCqY20E1BbFa6NBnkjUfG9q+w1i1kIebOZLkMnUAl91q9fpv8BT1Lymf5MuMOPLfEktFvHaE1e4VgtpJ++c0fauD3nhFeKr58gbA+IcLUu19ecQgdIppPE8QQCeg7kGQC/6xBbNJImGJVDZaPaVU+7MiDJiDryhMxN4jJDXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428282; c=relaxed/simple;
	bh=Fkd399WWImd9KJdZfl07eo+eynmLZQVkJf6NdqrDObA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ6nxP8QTmbaHYZ2zfXNkay0DMrHSxsKc8z+asNz9iblf5EId8SL/J+ELtNBy/jn2qbDVlOOsI9tTSh6GeQGA22Qxnm2RVdNR//vwT0w3WfbLpRIWdnhKjpU/f40IpNGYBmFllvLHhTWeuBi6oaCcN1GkA7MJ40GUrt2NXDFC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hWdwpaeS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hWdwpaeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FSjT
	ZhC7WnhgkLy/1e6nyfPpclYviSuIuUmpThZjZ1A=; b=hWdwpaeSPBANUJFZ9zjy
	ieojamlI6bO1mC869hJgGOFmUPV6XlWc0tHzEzTiyL1pmb2P4FaI93aTfk0DXcYe
	hq7MqQ2g/tpjQuAzp6BwuOLkNuWLs/N++uakZEUm7U/ufEVawfEdv48RGMsq1dGA
	A/sK3PlZ9l7Yoep/3iwOvETtDIAKj7571FelyksThNRjQ+BwCZaQ17IM0MR4kMJ7
	Z9BSD7K+bwoIli18RxzTsTBxiljJcf1LmmCnO2BPd/mrWXcu8KsYlF8ElkOeU5G5
	bdg8Cvhys1S7tzXjjVmdF9UaiQ2WyxTAxJQa3urGgDhSow5gXB6N+ggKbRpqGx+z
	iQ==
Received: (qmail 993007 invoked from network); 3 Sep 2026 11:37:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 11:37:56 +0200
X-UD-Smtp-Session: l3s3148p1@Tp4c6JBaIKUujntC
Date: Thu, 3 Sep 2026 11:37:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Message-ID: <apk_81IYqxrWZyJK@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1HOCjPIa4TORl4Ez"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-9-biju.das.jz@bp.renesas.com>

--1HOCjPIa4TORl4Ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Fallback `f_max` and `f_min` initialization fails to account f=
or the internal clock divider.
> --
>=20
> --- Patch [8]: [PATCH v24 08/15] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL=
_DIVIDER flag ---
> commit c4a63c19303286f5b383bdabaa2a3f3827a8c5c5
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
>=20
> This commit introduces the TMIO_MMC_INTERNAL_DIVIDER flag to support SoCs
> like RZ/G3L that have a fixed internal /2 clock divider. It adds a helper
> function to fold this division into the reported clock rate and uses it in
> the clock update path.
>=20
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/re=
nesas_sdhi_core.c
> > index ff428b6187bbd..b5f2ff68db758 100644
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -125,6 +125,27 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc=
_host *host)
> >  	return 0;
> >  }
> > =20
>=20
> [Severity: Medium]
> Since this patch introduces an internal /2 clock divider, should
> renesas_sdhi_clk_enable() (which is just above this hunk) also be updated
> to account for it?
>=20
> If the device tree omits the max-frequency property, f_max defaults to
> the raw parent clock rate:
>=20
> drivers/mmc/host/renesas_sdhi_core.c:renesas_sdhi_clk_enable() {
>     ...
> 	if (!mmc->f_max)
> 		mmc->f_max =3D clk_get_rate(priv->clk);
>=20
> 	/*
> 	 * Minimum frequency is the minimum input clock frequency
> 	 * divided by our maximum divider.
> 	 */
> 	mmc->f_min =3D max(clk_round_rate(priv->clk, 1) / host->pdata->max_divid=
er, 1L);
>     ...
> }
>=20
> For hardware with the internal divider, this advertises double the actual
> achievable bus frequency. If the clock provider cannot scale up to 4x the
> requested frequency, the MMC core might negotiate a high-speed mode that =
the
> hardware cannot satisfy, resulting in a mode mismatch where the bus silen=
tly
> runs at half the expected speed.
>=20
> Could mmc->f_max and mmc->f_min calculation be adjusted when the
> TMIO_MMC_INTERNAL_DIVIDER flag is set?

Looks valid from a glimpse. Please comment if you think this report
makes sense or not.


--1HOCjPIa4TORl4Ez
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZP/MACgkQFA3kzBSg
KbazUg/8D5L45wtGNn85UOEWoJ0hr1plRyJQCvAQlwPj9Ngr1mjo8WWHaPmNYRTs
z1zDKUJQSfs632hnr2C2pwVBIaJ1LCY4Ug4sOwnb/ugCSnkDDTCApbBP++VutDOV
vzsqZMAFPq9F20pgbVynWjARJLcgwIs72dYVv8dDqL5J6LHModbidopxwxYDlK5t
vEiPSwoLPpttHqsDnSR3uieh3E6Ty5pFqbyj/+gPbhxk9C3/5caEBuRx10IK7B3f
Chw6eIAeuZk1y9XKIh4yWysPOCeavfCw33ufA0FvPSgqrKmEewCJk9nqmYoUsLLM
QWcGWEq5EsKo1E1/8ywW5GsopM0bY6gedl6WWd0bvQSTXpZ7XvLNhhvGb/T8TKYV
1XE9a2z7OEpyaz86JAfv6zUV5hbQOzMwZOPtI0b49a6fsIK2LXe5xST6i2gonMhX
JkTdA/0o7jglhu0DvfuQ2kLeoduu+0qYSz0t7m/YDUWawrrfNaxZgtVOEtICx0Zn
FrXjKQfWKYRjqONsoRlupqF9SSPiJIDFy6BaVbEKw+oSqgZid5SWLXSDYRysK1LL
PMuw6KvRG4qmw0lFfduKhv6DhxhNqh0LfHvJGQNwv7VnrsToLC7orta5sWvGRXq1
FEQWRQkyJ9COhcTTt6pjgiwT9s7ncaagbUwIdGqaF+69FjhhmPI=
=qsww
-----END PGP SIGNATURE-----

--1HOCjPIa4TORl4Ez--
