Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB23BD22E
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428624; cv=none; b=fUuIVwXvxjx7vKt1BZnJMrmt22qSyCDwaQxSII+swm8dzIbNDB0MO6BNSKiNqNWbW9Tq1W78mjxQkvTQguFRTbJTN4m3JmSQWkLABR7q0CmkDjsnZTwV9ZpCxso55qB390unxA09IKqXSzXEhXoNxLpabzcG/bFaO257Z80jSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428624; c=relaxed/simple;
	bh=zVRZ9YB2jZg4NspjMBUhfg4hNV05y/D1ChD368Bh1eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXdcoDgKLZ28TdfMDIx81H3vvlbzLFt22Ql7OGSnxkaboxgtUMkzbofSCtMzMKIsUnUN9LiL2Gt034rPwwH+4lxDv1fFJK5tYXiNyvmbl1w2WXnyN092w7rFbcDgwsMIGYlQbYsfHUXZpqw20iqNppztDq+ZJyoieNuTlmM6Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JZc2MiSs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JZc2MiSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LY9A
	uxdY0YgAtitZHhuxf78G9rjwrzekgyOQQDK/Gqs=; b=JZc2MiSsgJIy4r/9Uo4M
	SLryPfnRs2esjfpXwImw1LAPCxySom2Gh1UMRJekL05lmItQszh37t2UStNlHrnz
	06iZ1ITyQr2D6K+0ArLMdKGNExzkNx9ihceDPLIeampWg8YvhKBxdhqymoX2fqH3
	+usp6Q5BhlDxqiVykjhGlgvVSvzX5G3nOuAQw/e6i3IeIMh772F1etDSLHA5mkvv
	H0fnen7XvB7CqYFvXUyurcCxSK6ky6ndmcvo8r/l0c3CLbPNjcax7Wbnqjjpwgid
	MhLmJyMhNBwIsj9gyHw5kZfCM7XhUTfPSMS4Q5qaZIurkE4kpV6J7NhpDzE8Dlon
	CA==
Received: (qmail 994618 invoked from network); 3 Sep 2026 11:43:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 11:43:40 +0200
X-UD-Smtp-Session: l3s3148p1@nH2j/JBa5NUujntC
Date: Thu, 3 Sep 2026 11:43:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Message-ID: <aplBTMnnF1V71BDL@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E99sx6PRJK2Yhpw5"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-9-biju.das.jz@bp.renesas.com>

--E99sx6PRJK2Yhpw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +static bool renesas_sdhi_is_internal_divider_enabled(struct tmio_mmc_hos=
t *host)
> +{
> +	bool enable =3D false;
> +
> +	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> +		enable =3D true;
> +
> +	return enable;
> +}
> +
> +static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
> +					      struct clk *clk)
> +{
> +	unsigned int freq =3D clk_get_rate(clk);
> +
> +	if (renesas_sdhi_is_internal_divider_enabled(host))
> +		freq /=3D 2;
> +
> +	return freq;
> +}

???

static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
					      struct clk *clk)
{
	unsigned int freq =3D clk_get_rate(clk);

	return host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER ? freq / 2 : freq;
}

Was this AI generated?

> @@ -184,10 +205,14 @@ static unsigned int renesas_sdhi_clk_update(struct =
tmio_mmc_host *host,
> =20
>  	clk_set_rate(ref_clk, best_freq);
> =20
> -	if (priv->clkh)
> +	if (priv->clkh) {
> +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> +			clkh_shift =3D 1;

No, this needs to be handled a bit above where clkh_shift is initially
set up, so we have it all in one block.


--E99sx6PRJK2Yhpw5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZQUwACgkQFA3kzBSg
Kbbp/g//RPqRM7wsWLv3lCIY+qTDPlkd06UoszyERYrrKruEVVp90sLIXqCbIFMq
hGV7xSzWjY7UZWialAhIYYcqvGKT4YyKC0X19TaVcGtn1xxEcH3cEMGEcG8YHzfy
V9ZJ7uFKahINTYDbH+8fWUquf69ikFrg21wwodc/NN1lbK2mPsEw2Pro/slKgtnl
65WeH46PrfG3djq8ldgB64cnNN6ng3yzKdxxukFQSYllNhfrzF0LnMshqBWtllkI
EIPMDzB/ayeLi1khwJOLyL219kU6/LMxi1LEuomXHh/K/qbQnisQe4TFGwsYoTR8
bZmGruaZnH9dnKJkOSXknwJ/ZvIgLjFFssoA6hKo8Z3ZxeuFp6IK0YPSFk22KgqL
fjENVX6onGyEssi2IBJWuHP5JDtAX981Ga51JMr74wuok9vk7MgVr2od9uAwD1YT
246iZPANVHq+E9oSjGV3T/A2p1ikiCgfieR0JKJszk42uuzWt/DWgNIuKhvfWUrR
FNULm7Pj3xtvjtZPd8HzRKOyk9Ud9bFxOTCxQ6QspXcZKrSyiPCsIlwoQrysP6zk
kdBYIkEoJY4JeRdhaFKaEIRC0DZ9rhP1TkhpzuBLIjziq65KAEn873cKQFT+siWD
zF0gBzHa+VdXL6w7IrTUicW7bUKUM5AF7lVX4EWMuyPXN8PFEp4=
=SpLs
-----END PGP SIGNATURE-----

--E99sx6PRJK2Yhpw5--
