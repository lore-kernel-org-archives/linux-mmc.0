Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938147886E
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346452; cv=none; b=QKL3AqtcRM+AoKKkaRegiq8i99RmF8j0RDN+bEi+vKXOr0Ty8C/5/SSMWKUqGSAtK9vc7Zn5D3FKDaVCQKYegvZ+zaPa8VYgrG+YfUZyjSYlcs49oq1/i55GCZSKwmvYdVDwx1wlG3CP6oSOaLgnstIf4GatCyGa/eJxxgJqcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346452; c=relaxed/simple;
	bh=Qbht4x4IzGT/JiczHyNCGNYWVQo4ezwLAuwXfNqwdEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=airkoUoNQgbxAIFlmnsPyDPlvBHzKeh7Zpm7ZhtwQP05i7mpuhQgQP59wubcykzGfM4ja4MroAQLf9WH7Kxsexl36aKv26dkOKfh4eaTtSHxCaTpXN2MJvDC+DNY2qeJJT6f2v7HtCceOnpa7+2IXxLb0gQXJSOy7EmGZOL9LOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eWN9GyoS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eWN9GyoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wZKm
	07XhcNsktoC3Api7lsFF1a7aDWq6S9O9xPgdB+E=; b=eWN9GyoSCaucuH2we4Ie
	njturwef9v0eHVQUYmMM5u3L9C8940gyTvy4k8un5AAPTWrnM7N3JtCS+aBbUmF0
	76JSyWD4qKEyKoyf6noeahbHaYbIhVZUs2sYxbn6auDkW7dtCR4hpGJZv109DxUG
	FKtUtJ3z3xNC9NWs8zl31wOZMwi7SkHXai7vlhzW2mIcD3ljPZ8TApReLtqZiTVz
	EWmZHIzvC27b42ZFK6Eu66e4ew0mzB1AHTdq9hsvDSmjoQy5rvN6DcY2xe4mhzxa
	4gocBpqGwJ/24mbd5CBxTJK2pyEvTX8BDQSf2EHIazGGF7eIVruNv5C1tMGKhHhC
	OA==
Received: (qmail 603002 invoked from network); 2 Sep 2026 12:54:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 12:54:04 +0200
X-UD-Smtp-Session: l3s3148p1@kdWP2n1aqrwujnuD
Date: Wed, 2 Sep 2026 12:54:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Message-ID: <apgATHptEbhkohZo@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GX9/bM/hw9OSTs2Z"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-4-biju.das.jz@bp.renesas.com>

--GX9/bM/hw9OSTs2Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sashiko found issues with your patch. I curated the list and left only those
which I see as valid. Please have a look at these issues.

Thank you and happy hacking,

   Wolfram

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] A very low or zero clock rate from the clock provider causes an =
infinite loop in `renesas_sdhi_set_clock`.
> --
>=20
> --- Patch [3]: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to=
 support flexible clock divider widths ---
> commit 1c7318b14c028686fc8ca703eb8ac2be269937b6
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> mmc: renesas_sdhi: Add clk_mask field to support flexible clock divider w=
idths
>=20
> This patch introduces a clk_mask field in platform data to replace a hard=
coded
> 32-bit clock mask, supporting 11-bit clock dividers on newer SoCs like the
> RZ/G3L. It updates renesas_sdhi_set_clock() to use the dynamic mask and s=
ets
> up backward-compatible default mask values.
>=20
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/re=
nesas_sdhi_core.c
> > index f9ec78d699f45..604d886e483c7 100644
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> [ ... ]
> > @@ -213,7 +213,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_=
host *host,
> >  	 * provided for actual_clock in renesas_sdhi_clk_update().
> >  	 */
> >  	clk_margin =3D new_clock >> 10;
> > -	for (clk =3D 0x80000080; new_clock + clk_margin >=3D (clock << 1); cl=
k >>=3D 1)
> > +	for (clk =3D host->pdata->clk_mask; new_clock + clk_margin >=3D (cloc=
k << 1); clk >>=3D 1)
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does this loop risk an
> infinite hang if the clock provider returns a very low rate?
>=20
> In renesas_sdhi_set_clock(), if the clock provider supplies a rate smaller
> than the maximum divider, the division to calculate the initial clock val=
ue
> can evaluate to 0. Since 0 << 1 is still 0, the loop condition
> new_clock + clk_margin >=3D (clock << 1) will remain permanently true for=
 any
> strictly positive new_clock value.
>=20
> Could this prevent the loop from ever terminating, causing an unrecoverab=
le
> CPU hang? Should there be an additional safety check (such as clk !=3D 0 =
or
> clock > 0) added to the loop condition to gracefully handle misbehaving
> clock providers?
>=20
> >  		clock <<=3D 1;
> > =20
> >  	/* 1/1 clock is option */
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820171657.62=
815-1-biju.das.jz@bp.renesas.com?part=3D3

--GX9/bM/hw9OSTs2Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqYAEwACgkQFA3kzBSg
KbZkdQ//WekvPvNMmpAI/+sU1MP3LrhF8r9ZctmiZbh5vUxaLhcuzGEsqZZgM24N
AsF1qgTezHxi05aimqv5ycQm8/6XKn7QRt1Ml903RSmXUtH1pheWF8TdGmy4MpKO
leYDRzmP1I1pUbxc1+c46ISVi6IjbHIXjE2E9HxvslXPNBd1hw3xG+kVYVN1OgvB
S4uwLIJZ1EcbH3P5kcIUh1UnXgj0kD+Bx4MZ7p7XPrrQLT4E995mq1DJWA0cvnX7
5JrK6Yd4FqFtVsV0/ze0necPcv/dkCeNaPl6pnlHAqJOSgIDmaAvkJM4Pkyc41xf
KV0L3ZTOTaquZBgNsuXk7mUznfJfP1Iai3XIAyllnsDtmQMBAZ/8pyTuJc5o4UOv
Dn5N9nm7KvFfy4WX90x0h4i2+sgmS98qy9CJ77kKshfAt/Qi1xVNefNy/Pg3QT0d
Jd8vG9SJl3UliPDTkts4Rp6x6MF58UbRDtpsotsKWSlU5u0nh68U+BWEmVU4G2oh
zGSnlZZFIA+ytp/s6PsM3dIgKWJfMXG8mg1sBmbTdVqqPwOMDWNikZGmzhNW9bNO
poLBJLm1O0JvLb/zfKrcmc4OpWXRiCbXqqd7dYFZRIzopfxiiGmNCIO6I34je4NQ
Nt3IY+tId4zxeGYdf9XRGRJ+/Dif1u/yQfHxEvBK1ZvuLs270uc=
=TeQQ
-----END PGP SIGNATURE-----

--GX9/bM/hw9OSTs2Z--
