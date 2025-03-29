Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AD29A5
	for <linux-mmc@vger.kernel.org>; Sat, 29 Mar 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743248824; cv=none; b=s/AsK2JoRZvycFOfjssuBu9EV5vBNELQEz1qSC/+IYm7DfjcVJ7VQtpUG+l2D5GyLMfK/fsyVbmNb4r2ymUC8RMJpDwM1hUMTPPJTHhAkE18SfK+kwISftLmAkdmmVPXQzQtUs8wOnECeBxTY33J2+bhLwLN2OT2a9JsmfO2KfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743248824; c=relaxed/simple;
	bh=v7wrmjaMzoGiPADUDwETsT2LWdqNzuCLVgWukxnDXDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRgAV+sdN2HM9419jo2Xa8ACVdcE4iE+Q398H0Tr5MXAhyIffEm8Yc5eOyMsbADxZgHJD1RhJxsBNqhxI3p5UuY70+2oxI3yMfYy1Gss4gDw/gzEW9rrCNLYOX12GVeB/gSj61p+i24ihAi9CypAE2rIThyaZquhy2oekUXWbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FF0P8lLh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FF0P8lLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n7QY
	FGFX0medxAfmWU5ZWu/t0tYD7MgFQrWrMXlrM5Q=; b=FF0P8lLh5zppOgE5Tf61
	5OhyCBCbNQQbVZKxv0ne9gT7uLhbnUnicQVY1awH3EMQOoTKdIhb0f/9nUz9ByrU
	bBhap6yHj3JJa6IFSzFsykQ4H3JlaquCWCNVpcuKmC0mRky5AWIvq/Fp4yUGRusl
	hvicnlP71dXV3Gcdjn8Cku9PDMq803WAyPPD26Ce5Evg7YIddz8uGqfBDCUb3DDM
	YClWgZohk6Y88NbpRWdwyQdg93C76qK5LGoIS+whQ8yPDdHWGckEa3IcQkegpC8k
	2OgP/YEAE8e9iqhRS2PU42G4Zt37TAzEqE/TLrk25Ro6ZFHdxJKQrZbEyR738kd+
	Ng==
Received: (qmail 562002 invoked from network); 29 Mar 2025 12:46:57 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Mar 2025 12:46:57 +0100
X-UD-Smtp-Session: l3s3148p1@eCZ6vnkxugRtKjH6
Date: Sat, 29 Mar 2025 12:46:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: add regulator dependency
Message-ID: <Z-fdsBZgcO6bruIN@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <20250329082123.2325267-1-arnd@kernel.org>
 <Z-fBYVzkxZOqZixB@shikoro>
 <70367c55-81c9-4387-b332-1e19ab8397d2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gBVHUACiTNPCzHVf"
Content-Disposition: inline
In-Reply-To: <70367c55-81c9-4387-b332-1e19ab8397d2@app.fastmail.com>


--gBVHUACiTNPCzHVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 11:46:10AM +0100, Arnd Bergmann wrote:
> On Sat, Mar 29, 2025, at 10:46, Wolfram Sang wrote:
> > On Sat, Mar 29, 2025 at 09:20:52AM +0100, Arnd Bergmann wrote:
> >
> >>  config MMC_SDHI
> >>  	tristate "Renesas SDHI SD/SDIO controller support"
> >> -	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> >> +	depends on SUPERH || (ARCH_RENESAS && RESET_CONTROLLER) || COMPILE_T=
EST
> >> +	depends on REGULATOR
> >
> > Hmm, this is too strict IMO. SuperH does not need REGULATOR.
>=20
> I haven't tried building on sh, but I don't see why it wouldn't
> need the regulator dependency. The code that calls it is
>=20
>         rcfg.of_node =3D of_get_child_by_name(dev->of_node, "vqmmc-regula=
tor");
>         if (!of_device_is_available(rcfg.of_node)) {
>                 of_node_put(rcfg.of_node);
>                 rcfg.of_node =3D NULL;
>         }
>=20
>         if (rcfg.of_node) {
>                 rcfg.driver_data =3D priv->host;
>                 rdev =3D devm_regulator_register(dev, &renesas_sdhi_vqmmc=
_regulator, &rcfg);
>         ...
>=20
> which sounds like regulators are always needed when
> of_get_child_by_name() may return a non-NULL pointer, i.e.
> when CONFIG_OF is enabled.

rcfg.of_node will be NULLed when the regulator device is not available.
Which is only true for a few SoC variants. Most other SoCs use
'vmmc-supply' insteand of 'vqmmc-regulator'.

> If this is correct, maybe this is the best variant:
>=20
> config MMC_SDHI
>   	tristate "Renesas SDHI SD/SDIO controller support"
> 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         depends on (REGULATOR && RESET_CONTROLLER) || !OF
>=20
> CONFIG_ARCH_RENESAS is only set when CONFIG_OF is also set,
> so both subsystem dependencies are covered by that, while
> SUPERH doesn't currently enable OF, but will need the
> regulator and reset controller if that patch is ever merged.

Even given the above, I like this approach and think it still works.
But Biju is the SDHI regulator expert here.


--gBVHUACiTNPCzHVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfn3awACgkQFA3kzBSg
KbYKSQ//XAJdZgt1l4Z7SGVxeOH8I7WfEE7nyL4lBq677rJuzf9xAmJat272QtzU
ycaShEHDGvVkwsJCeY8xsCF5jQGvDCbdYCjvurjp10gbc+ZxKwQxFY+VJe0OLIyf
xWKzBWz4nhXp+3q8fpibX8NHBIpz2LgmYlwDxZ/YPxp5fCrUmIUqLySmXw9AaYWH
XYEzs6uVexxK94Kgi+bqiHPJW4eoyK0IXf5JyTUXTtzvrSlTPJNWVm50bV5ngfsx
gy24g8TiN9HmbxTCfGVmPHmlH/eOayCLHiMQJwPPxerkG2iNKmY7+ao2ZTgXsI4K
DKKWE4ejyE+FyUFnxDGORedswKArhUsUlIg3VK8LUwmZW4rLuPjuklvZGA596aNc
hx2FsJijBfsDD9pDpCqmjshFEIMoB7n9O4NW6WotZmyvr6hmKTOCvOXGRPCN1D93
v3FQEYS+B+RBqPQK7wNdbgHDeDRRUVe9KIIX0CgGEyEvuXtOgZw60YKM3fJWvajQ
O0kabIxOaEXJbz8asQINSkqJGii+jTd7pa/A/5v6Yv6LhacU24VOTv728COF9y5R
H9yuO4Itd1mWp7TVi31UCa+ShvPawLIVTsavGsoXNErb+GS12nX44syJp2Y7Z6NA
2g9zeeCwlyFduhnKSi4w3sVudWPwouf64Nt5281gqAZjrUYCPAM=
=MBr0
-----END PGP SIGNATURE-----

--gBVHUACiTNPCzHVf--
