Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB13E9C37
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428057; cv=none; b=fj/RlqghntQ3YIOklCduSjWjpE9RFA4LipAA5HErww6SsLtdt12A8tyc6C2UHO2Pw6yedCrs7xUFjZXIseheXsrNYGR+7q7Fi42PK1lNBZx2P7O8gQXVN61iBDGWAyVMondIR5z5C/rwieZi2rmaqCpzecB4kio9SV6wxWgWT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428057; c=relaxed/simple;
	bh=UN0FIwW6VIX4p0uKarl6ZJ211XsIpGy9bfsb+jQb2uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRduRXEor2Ttz4ZOBNVGuKX/KKnM4QwMdxzRFYF3gUyBGD9fGHf0FpKJVI6I9XSICSkK5DQaFn+XOv/QKmxNU3csTWFW5DjbeFXeNTtGgHWUsQ3zBjqXTH1Xabi7229jNkVD8LK1fVxaaax5BChFWADMnCyRe0bE1yGEHQimj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=b+Dp063W; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="b+Dp063W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=htnX
	c411+OiYJDFK9qVlNAvaXrNdaLqHzd01Efu1tzg=; b=b+Dp063WNnBv5YIO5Qr0
	Q2SMX/SdeUp41YA6bny7APtU4nBIgMKdIKaGQKJJX4/A51Dx/O7YPbXY4vXnKyIp
	wJgUwttqXaN4d087CRSvJul7tEC5rHbpBQY/O6/PpLCBdNxOPKKbXTgqn6kijXyq
	qrNgUh4ILf5zst5AphE4v4IvTdUxe2y058yPdFw/0pgV4kTpDTqYB01FKAQHf3Q3
	xGHAwvuTaBHU2AbhqwgCAsrZEawfmJQEBH00oW4KXeV/BZ1y9ymnXVvGVbiq/tli
	KbHWQ4goab2KmreNRQgwKtTIVlggaJkmBtyqs1ulE0lq+RaxFJLO1Xe9c93Izrhm
	gw==
Received: (qmail 991847 invoked from network); 3 Sep 2026 11:34:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 11:34:13 +0200
X-UD-Smtp-Session: l3s3148p1@RV3L2pBaHLYujntC
Date: Thu, 3 Sep 2026 11:34:12 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 07/15] mmc: renesas_sdhi: Add tuning delay support
 for RZ/G2L
Message-ID: <apk_FKZDZ-zlov69@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-8-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="drAb8C3PrY/vxc33"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-8-biju.das.jz@bp.renesas.com>

--drAb8C3PrY/vxc33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This might be over-engineering a bit, but let's discuss:

> +static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)

How about adding a 'bool force_clear' parameter here...

> +{
> +	struct renesas_sdhi *priv = host_to_priv(host);
> +
> +	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
> +		return;
> +
> +	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)

add '|| force_clear' here ...

> +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
> +	else
> +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
> +}

...

> +	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
> +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);

and simplify this to

	/* add comment why on tap_num == 8 */
	if (priv->tap_num == 8)
		renesas_sdhi_set_hw_adjustment_delay(host, true);

?

The other call to renesas_sdhi_set_hw_adjustment_delay needs the bool
parameter 'false' then, of course.

What do you think? Rest looks good.


--drAb8C3PrY/vxc33
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZPxQACgkQFA3kzBSg
Kbb7YA//Sw1akXu3o0TWdwVGZJCgnPrL8Da3/DQxg+7V72AoXpXFXdTMrEiUZGVZ
FTwQBQdop1SCHaFywxcBj29hL+ata/id3hrXqbfENTBGxnguvuEBCtFewJel6lpt
34qzib0ApPbtbtfL6+ulYhEg062fEUCMNkBNLODNJcXCkiwhp9FBjXrD30Q2SdFR
LaDdWP2yloYa/6bJbZeGW+pyehUPLfhPIUnq9xXToZw7JtA/4kN0CL6whOZM9+S1
IbO+lIA8vwxHTfrqY7WMJlMhjVT3/LRwXSErDrkMXW7G6Gn2sJ2I/BGxYa0FQfug
pASDm+jxGGYF7pDWe8ltNeCa3iZQRGmChjUF7CejqRtUaCRwgSJncC6OGKkfxTo9
uZ7AMfQff5kJQD9ozQJ89x52dEfpE8fd+aebJEQKSkHOydsfw0JWq4yW7vxRO/nk
/nSCwxCFjSTSiWc+ViizaP4+lzh5NXbeu4/SgjRvo/+g1l2g/cVcWEzUWtZxSZP5
s7uHC2HQfJqxD4Hy5hrL/4fd0Lqork5mlBNRYrBStYVGyBMBi4OVTKm3SC+gWOmO
e+4ej1wVpQHz1oVPul3aW6S2oemfQRMCzu99zPMBDP0QU/jzUF/+9CbtfcAl8Ayz
giJX4rVM+NnOVS+rf3mymNwx8fQ6hfBlqHLW4/98d+5Y1ZDhIHs=
=VfIM
-----END PGP SIGNATURE-----

--drAb8C3PrY/vxc33--
