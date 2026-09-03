Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458448821B
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431584; cv=none; b=e3k9m/z5iec5y8MdilK0xGYXKlkoCu2hVy7+wjpMBEPKaB9/cSwzIW+6f6SVVIX4k3QshH+S9cfAeMAcTKRvAScY+PklX26Ua7bh7NPlgq+YeMBiGhIAvSqUMklXHyUad0H3h2Lv9h5LpGpFaMN1878uflR5QlcdwrUPSAJ6Gl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431584; c=relaxed/simple;
	bh=1pg5bjnnTADzEUkOaTVelG4SX/AoNaaGBLV125Jc5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmsSpV75uBcWNqLytcgO9d3gJd4t4D3nWE90HKM1SRjAemSuq2b8EFppJqcUWRDJMhHCFE/3E9e3wqCbZLzH3gae8NR5daepJKSXAHno+J3ErmFMpVsT/O/1qMpy2hejNcyF0WHM0/eQQYQFgXa/PM7hyO83Skb7YX2DhKtcO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KGOFzSc1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KGOFzSc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7xyv
	c+hzDyQkOoghz8pVOPfk8aNeYZ8rq5mea95KcSM=; b=KGOFzSc1mBTA4l09xwha
	iMOZmpa6LjXs+wEWICouWWqEW/CZphVEAUMq2gtSUS8iEyPnP+zDlYBvOXGjJYv1
	Fy4+phKoua+514wB/5xxodELGbJ6x+Oj/5ZAHC7xNi0TPoTW2vjcMqMN/DIDm7u7
	CNLoAa3Z+ET3uSnlDMQCGVZPHoENVmoa18rR2a8QlE3kieR67E7wMoGpbepc+ff+
	Pqj5Q7fVD8Tbwv6jVd85thMoyL2OcsVWLWFxzyTQC5SOQrVOpRrzffNZ7UWxhDjM
	rLD//XBoFbtkhLIEXhjuUNhsBRZuJUGCoQa8cfRF++NmEdQr/kZ1Y2LdHEaHz4V4
	AQ==
Received: (qmail 1010148 invoked from network); 3 Sep 2026 12:32:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 12:32:52 +0200
X-UD-Smtp-Session: l3s3148p1@EuiWrJFaVOgujntC
Date: Thu, 3 Sep 2026 12:32:52 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
Message-ID: <aplM1LLFJ4eo4YJ3@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-11-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vyt5JrzZ0I2IKlXI"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-11-biju.das.jz@bp.renesas.com>

--vyt5JrzZ0I2IKlXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] tmio_mmc_host_probe() clears write16_hook when TMIO_MMC_HAS_IDLE=
_WAIT is not set, but fails to clear the newly added write32_hook.
> --
>=20
> --- Patch [10]: [PATCH v24 10/15] mmc: renesas_sdhi: Add write32_hook for=
 CTL_SD_CARD_CLK_CTL register writes ---
> commit 57d55ff6257b421b4e27c4306c5ee441c02c3087
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> mmc: renesas_sdhi: Add write32_hook for CTL_SD_CARD_CLK_CTL register writ=
es
>=20
> This patch introduces a write32_hook for the Renesas SDHI driver to wait
> for the SD bus to become idle before 32-bit writes to the
> CTL_SD_CARD_CLK_CTL register. Writes are skipped if the hook returns an
> error.
>=20
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/re=
nesas_sdhi_core.c
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
>=20
> [ ... ]
>=20
> > @@ -1203,6 +1211,7 @@ int renesas_sdhi_probe(struct platform_device *pd=
ev,
> >  	}
> > =20
> >  	host->write16_hook =3D renesas_sdhi_write16_hook;
> > +	host->write32_hook =3D renesas_sdhi_write32_hook;
>=20
> [Severity: High]
> Should write32_hook also be conditionally cleared in tmio_mmc_host_probe()
> when TMIO_MMC_HAS_IDLE_WAIT is missing?
>=20
> Looking at drivers/mmc/host/tmio_mmc_core.c:tmio_mmc_host_probe(),
> write16_hook is actively cleared for devices without this flag:
>=20
>         if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
>                 _host->write16_hook =3D NULL;
>=20
> If write32_hook remains set on older or fallback configurations lacking t=
his
> flag, polling for TMIO_STAT_SCLKDIVEN will time out after 1ms.=20
>=20
> The hook would then return -EBUSY, causing sd_ctrl_write32() to skip the
> register write entirely, which ultimately fails SD controller initializat=
ion.

Please check this, too.


--vyt5JrzZ0I2IKlXI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZTNQACgkQFA3kzBSg
KbYz/w//Ygoql5hp0Ff/kU2y+OC73vExZpvK242pR83m0q23+e0SLcm3awgvwiwy
nTNczWYoq5e5/+KRWov5XIVYeHfNXYsAiVy4cg1JSW65P2TFDLnYgbdHBEXsNp91
fglKUrh/s2hI0zGx7wY7m7M1stZKmWTPlgqmG0rchJTbPlpvkiHeTPOWGAjTI5S0
f3lzbj+wTKiXqXu2BUY7AzqKTkFdpRr3n5C7bvO52ixyCOVF0RtdLvdFPG97r/l8
WATXcxwmHDZ1+t82NktojOE29JQQ8CS8/Wvv/DCur80LYHWSHvRXjJAt5tslcKav
k/bM4ZmFe0Jz0JHKUNCs+wByKfzew7iWFbM8UbIya/D92/1gALb0G3/kdRsFy8Db
tU1Tha9c6OT74UMSxOxIrjJiQG5VTrt27Ke1d7tR2L4/XO2kPZsZJKMJZaYdjWB7
0Wjg8d1EfjyT5q32aI3/Ci8c6wR+imH4u8L9VpGQLYAYVUkGN2FK1cs8FknCYKmn
3MSHFX3fSTb5RV5HZq1qO2YM7YCqlv9h2HfTHTaS46wrSSBPEF4byIMAdLBWY5bV
EzoCGIc4BaRJ64FBndMTGzpngVXUbWO/fcWL16GRUNhrRQrBu1GEc6TbbpqsweVQ
NFiuH21VAdEMtJv3b04t9NpJjlbcZszERp92TCxjLO7C42nGCmc=
=3HZj
-----END PGP SIGNATURE-----

--vyt5JrzZ0I2IKlXI--
