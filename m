Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8C411A16
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436903; cv=none; b=Ei8Fmhzopg8CyEFH6QO6l1N8c0D9JDPhaj66WX/fzoiXRmTgdh8KE7w1rI9cfIYghhjH6sQFxypZ0bS18ZclE1ebMVBSZ88OU1HSnoUr1x58JJd8ecLF+Hkt7T14bcG2Jakl6j8DsqwO3cYoPWTH7YxhwCTx8mIvX38/aseJDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436903; c=relaxed/simple;
	bh=3JRGhyckz5malS0xm86glLK46wIsuCl7J+xHw95jSPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLL1lpM7cPi+6yQDfYVKmTTjlLuMgZ4Mwue+SbZzomCJx4TfC3JkuZYJWPcbTE1F+qwOHIMOKCAUxQQKZlTJ+jIcKDkRK81w+2k/HSoMb9CraDGAtJG3hDmwVXEyI2UjgskIbDJ+HooULTBlP6sm/wO6Z1NsC2kOM/m8s7PRfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EiUfz/n2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EiUfz/n2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=aKJX
	bTwdyrznYPGRuoX01iBhI+rk25Vt+bwyCdC8MA8=; b=EiUfz/n2vmWq9ztnjuXs
	cZahbeet5yAOLaESwcIpOevQqc4mFRBkvfI+d7DKJIlbbe2o7NXtFk7uebJaqxI6
	tq9Zg52JkYX6r+Cpj8BtXsKcKphOwev1/0pjF0XR7tfbAyX5yqHIxh1HggidQ/PL
	sNBZjBAwLXdbkfPYTHXQ71r6umdZ/2KtXT0qyE2PoBxwUCQfddguJ1U1MZG04xfC
	kWaR5dvW1jELp6Md9DD8xH5q8ZruOLCnxCr8jQcGAiTPir1/VctkoFfRaqU9iDUM
	iD8NT5znMm6IX9B0Ffryz/OqwDeJKyFLFcMzd5I6hbFA1C6u62Rgb6+2FurdUSS3
	Nw==
Received: (qmail 1036518 invoked from network); 3 Sep 2026 14:01:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 14:01:32 +0200
X-UD-Smtp-Session: l3s3148p1@Y7Gw6ZJanqkujntC
Date: Thu, 3 Sep 2026 14:01:31 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 11/15] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Message-ID: <aplhlynkb_LUiVhS@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-12-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pK/lZdLk3occFTHY"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-12-biju.das.jz@bp.renesas.com>

--pK/lZdLk3occFTHY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Okay, let's start this one high level...

On Thu, Aug 20, 2026 at 06:16:41PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> RZ/G3L (r9a08g046) has an SDHI controller that differs from existing
> platforms in clock divider width, a second HW adjustment register,
> and an extra tuning register.
>=20
> Add TMIO_MMC_HWADJ to mark controllers with a second HWADJ2 register
> (offset 0x010), programmed by renesas_sdhi_set_hw_adjustment_delay()
> alongside TMPPORT2 (0x3FFF at 3.3V, 0xFF at 1.8V). Clear the new
> HWADJ4 register (0x022) at tuning start when TMIO_MMC_INTERNAL_DIVIDER
> is set.
>=20
> Update renesas_sdhi_set_clock() to write the clock control register
> with a 32-bit access when max_divider isn't the default, moving bits
> [9:8] of the clock value into bits [17:16] of the register =E2=80=94 need=
ed
> to drive RZ/G3L's wider 11-bit divider field via the max_divider/
> clk_div_mask support added earlier in this series.
>=20
> Add SDHI_VER_RZ_G3L_SDMMC (0xce10) and handle it in
> renesas_sdhi_sdbuf_width(). Add of_data_rzg3l with RZ/G3L's wider
> clk_mask, an 11-bit max_divider of 2048, a dedicated tap table, and
> the relevant flags including TMIO_MMC_INTERNAL_DIVIDER and
> TMIO_MMC_HWADJ. Wire it up via of_rzg3l_compatible (fixed_addr_mode
> quirk) and register the "renesas,sdhi-r9a08g046" compatible string.

After arriving at patch 11, I feel a significant loss in motivation to
read this patch description. It is very wordy, includes a lot of the
WHAT, hiding the WHY. Maybe you can adjust the prompt, but I would
suggest to write it yourself.

> -	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> +	if (host->pdata->max_divider !=3D SDHI_MAX_DIVIDER_DEFAULT) {
> +		u64 tmp;
> +
> +		tmp =3D FIELD_GET(RZG3L_CLK_CTL_DIV9_DIV8_SRC, clk);
> +		clock |=3D FIELD_PREP(RZG3L_CLK_CTL_DIV9_DIV8, tmp);
> +		clock &=3D ~RZG3L_CLK_CTL_DIV9_DIV8_SRC;

I am confused. Bit 8+9 are always zero?

> -#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
> +#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E /* G3L: SDm_SCC_HS400MODE1 */
> +#define RZG3L_SDHI_SCC_HWADJ2		0x010

Does RZG3L have a dedicated naming? I'd guess *_HWADJ1. I wonder if it
makes sense to have a dedicated define for it. I tend to think so.

> +		if (hwadj2)
> +			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0x3FFF);
> +	} else {
>  		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
> +		if (hwadj2)
> +			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);

Magic values?

>  	if (preserve) {
>  		card_opt =3D sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
> -		clk_ctrl =3D sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
> +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> +			clk_ctrl_32 =3D sd_ctrl_read32(host, CTL_SD_CARD_CLK_CTL);
> +		else
> +			clk_ctrl =3D sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
> +
>  		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
>  			sdif_mode =3D sd_ctrl_read16(host, CTL_SDIF_MODE);
>  	}
> @@ -217,7 +222,11 @@ static void tmio_mmc_reset(struct tmio_mmc_host *hos=
t, bool preserve)
> =20
>  	if (preserve) {
>  		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, card_opt);
> -		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
> +		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
> +			sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clk_ctrl_32);
> +		else
> +			sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
> +

We should hide this complexity in a function, I'd say. To make sure
future updates modifying CTL_SD_CARD_CLK_CTL will have it easy.

> +/* Some controllers have hw adjustment delay */
> +#define TMIO_MMC_HWADJ			BIT(15)

I wonder how likely it is that a SDHI variant has either only this or
only TUNING_DELAY. Do you know of one? What would you think about
merging the two? You know the RZ SDHI much better...

I will stop reviewing at this patch. There are enough issues to tackle,
I'd think. Once we got this right, we can improve HS400 on top of it.

Makes sense to you?


--pK/lZdLk3occFTHY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZYZcACgkQFA3kzBSg
KbawLxAAjuWj/8/y4ara9+iSLjrytiHihw+rT+9A6zZt7S7sdbRDIVbZ3a+4j1Jc
Y14ZaOFD3Urt9LdxEts3Z38jp5z/8lhwnMc3XCrr7J3lguD6XkliHwr4U3ETokU2
EPmAKENUWvdtskVo0jVbP1ULMLdk2CSbLTkd0eTk8/qXZ2rSiiW8MHjfKFAtFFaR
2CBF7tPhVGx3CNZzhjgsLXA4qC8BDa+KMrcUuHAHp8hKIxR89WiWyt+pMP6ONLYb
TdVv3MvAFFcaEj7VsEWcEn31r/EHM7dghtYoaFKLPVlkkLhXvUSqYuBKQgnylega
i4RAPD7hNRBC6DTGOIyoA61WXtLPYHJ/xBs9Rq0AyvUZOIqxZfMV+ow/JvAZDvUN
N9enFfr9729WjbiSuDYOiG7jgE5xG4PgwCuCs+dLoSVw93ntTyEo/sA9jLqy4efp
G0cZgd+dBx48fvJUOCvoE8aTBaU72cnu1QXi0F2IChw6KBrzyKxiqISfzj36NLk1
thjL8eZE2Zmv+JgpFiMld5mh6ZPjBkzv8fy2nG/vnwlILJy48AHBzl41cYgzQrRc
2AkYxRR+rzWsH7BXkXdpJoFXZlAdCvSt5o2ky2vs/hfZVpwQu0N2ebOey4Mx4PHz
wot5hlQIM32kngWSqaCgmC98o8aLNfJl8ZrnqB3fYc96zeF1aKk=
=iifC
-----END PGP SIGNATURE-----

--pK/lZdLk3occFTHY--
