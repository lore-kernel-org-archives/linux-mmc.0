Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC4412C1A
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427833; cv=none; b=bWqAQqJ80XIAzPErvH/PKL9WXmrvs327VVN/x6EQPQ23DsKIZNtmBp6DhXub6DkOPCrlUBi7EkDrgJEf6YnTMLsub3IOXQvo5L3GWJ3e7qMUnZFW2p+8+Yp1aHeP4YdUXjncz8LHNb0i936khj7yJfy/VDjJEWoIJbnCpiBwSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427833; c=relaxed/simple;
	bh=moVhZEPlxOejs4INWSi094ZLc7KHsJbD49rd9CQQFFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmyE9Zvi3N2oxIynDOQJyvrkHtfcFCtjMPuyuM00spllz4TOoE4QXE8YD7mcZhCrefOzlCNEkdRC7Aq8qdrf6KTQkT1ie+Pjje9DDyfUHdUpgVCZ5R/BQfkzrAqtkRrklQmclK/KUuMEMyQSiEF1vCpyiVWjqsmEaz07dN7X3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HeJBsBwM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HeJBsBwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=AbTb
	7S2al3DCsVSokZ5kIhiq2Pl40XwJjzjGTFN89nU=; b=HeJBsBwMl/lEtzX/SkCy
	/1E5nUvK1yb/p4WUEDPEQ/ubaDD1Fls8drjxhXcxVhemLDXpQ+Y+b2vO0d4YEoRx
	EGIEmQ3UuUmqLpPrjAKZ2BqpEA4I2UdvL5oDExm1p0xeZIpoMCq0RmWfdUIWqTRC
	jiBQBnLtKadNmoia/hqrPxtYfRsLLanoW8Q2fIAr1kFotEsSn5fd6wwmkzSDMqsZ
	S/a++NWgxYqO2stq9+LkPok5Xq5hUoAN3A62b2TjSS2Ecd37PAeO92xYDhoMIlGD
	NM3PH/b3XGfPvLlGnr6BNZPmCcG5bazYXwMrg07nSn+mznHyd2PGVCoNj9b97qjN
	Wg==
Received: (qmail 990621 invoked from network); 3 Sep 2026 11:30:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 11:30:20 +0200
X-UD-Smtp-Session: l3s3148p1@EMnvzJBa3tIujntC
Date: Thu, 3 Sep 2026 11:30:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support
 for RZ/G2L
Message-ID: <apk-J8is9MNm7I2R@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-8-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyaiZIAdHY4EYaxM"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-8-biju.das.jz@bp.renesas.com>

--uyaiZIAdHY4EYaxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The new function renesas_sdhi_set_hw_adjustment_delay() accesses=
 SCC registers via sd_scc_write32() without checking if priv->scc_ctl is in=
itialized.
> --
>=20
> --- Patch [7]: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay supp=
ort for RZ/G2L ---
> commit 4e31e96fb980d0bb6400d3a60dfcc29dca208dcc
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
>=20
> This commit adds hardware adjustment delay support for RZ/G2L SoCs during
> signal-voltage switch. It introduces the TMIO_MMC_TUNING_DELAY flag and
> applies a delay by writing to SCC_TMPPORT2 based on the regulator voltage.
>=20
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/re=
nesas_sdhi_core.c
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> [ ... ]
> > @@ -350,6 +316,55 @@ static inline void sd_scc_write32(struct tmio_mmc_=
host *host,
> >  	writel(val, priv->scc_ctl + (addr << host->bus_shift));
> >  }
> > =20
> > +static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host =
*host)
> > +{
> > +	struct renesas_sdhi *priv =3D host_to_priv(host);
> > +
> > +	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
> > +		return;
> > +
> > +	if (host->mmc->ios.signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
> > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
> > +	else
> > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
>=20
> [Severity: High]
> Is it possible for priv->scc_ctl to be NULL here?
>=20
> If an incorrect device tree binding or a hardware fault causes the
> controller to report a version older than SDHI_VER_GEN2_SDR104,
> priv->scc_ctl might not be mapped during probe.
>=20
> However, renesas_sdhi_start_signal_voltage_switch() is registered based
> on TMIO_MMC_MIN_RCAR2 and calls this new function, which writes directly
> to the SCC register via sd_scc_write32().
>=20
> Could this cause a NULL pointer dereference during card insertion?

I agree. We should ensure in probe() that either

a) TMIO_MMC_TUNING_DELAY has a valid SCC or bail out otherwise

or

b) clear the TMIO_MMC_TUNING_DELAY flag if there is no SCC present

What do you think?


--uyaiZIAdHY4EYaxM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZPicACgkQFA3kzBSg
KbarVw/+Mu5eiDZRyuMUhefrlInydy2+mmkctbCUF0RAN8f3745catRlv/gNifXm
wR6FKLx/YzKup8qe7XQhfbGOYOeH5a4hR+znzIBIXcebE7H9GILOiwtdenClTJ3M
I6unKmJZ2ARxyKcZ0ZugUGfj2loXSjzwJqiRy6dJBCBXHqwyy6onUMuSAlU6mCZO
JD8Tw4Lj+wG1KgFouRCPYjD1fPpw5n5IHMNIy6bm7VPUArXo516pgtyWhI4Ho7nM
cM9KzKNZzH3c+LJzhkqR82vCGaFNR+gzuzmaBnZyhsseS6GTp9RnoudCw9nyu3tX
YPw6r6ZdmG1eS641RF97ZWsnKrI3YhN6LSgrO1RFPRpddJL83wdIUoGsDMeJkmAm
PIt2aPFtPu7zwjhrocwfEH2MyV4BI2nqI5dEhnnZdIYhSeNRIBy1H/wPzndemxJV
ozOqUW/orjfw0187ksFO3/DqNe0X250AEVy3/IXEi4jjQB8VwiXovD8P9adu6Rbw
iSkDrf6CqEM0UqikcpfJ69i6dAJyFAxGbrZ7Vpk7CiD25lixpEjAvTzerpFD4JI2
YdeSR0s2dMQ4RMoMwWiHyfLXRuHpJREuImgmnbkAiPVmTuVv4JHVBdA0rfjgJQ5H
lJP6nc6fnzoFOQf38syYrXRs7O7SKh/u0F2bFJl41gOxlA0NHhs=
=IRZu
-----END PGP SIGNATURE-----

--uyaiZIAdHY4EYaxM--
