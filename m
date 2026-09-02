Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45AB46F4AD
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347136; cv=none; b=XfVn9INvGXwAG0/BY4uENCYPi/+uawErcWjtiIt2frKwB1CKYF9p76LZhzB+lZkl9MrXB6N6CrUCj0xK1FsxVPASRakCuhKV5BFb570frJal9fDvjMuwhd7Rf8RGDAmRJVOh/iZMXzrCAZexX1GjYfV8Wm379JYgVB883TF/Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347136; c=relaxed/simple;
	bh=5YKCw1lGrOb5ecJxJOAVdaN248fxOqfxZSuDRTu5hKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltvvi6PaILNJ8PiaSAwqaZEHdQMjfhhCfQs28HnU665U15fG77SXBPoAcB/Wzm2ZBFIYS9Zt0PG6swaLqCDiTBYwQGSNFZwv6zH9NNa1eSImAqQTP/NQYY/Pw1RUqaHbaaU0EOgEv4WTA1PuQUQaKsww5a7I9FUDLx+WyOA3trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=f/KZGdC+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="f/KZGdC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bJWM
	4wTIPM7G6a69Iw9U3U8LoF8Tt0qXwAx9qwPAumY=; b=f/KZGdC+OIFlpCZc8dAq
	Fsm/S54xrXwGhYolma/jT0FEvpt9jBaN9qBcnIgvl23kxiV3Goo44g+TtS7Qo17L
	CVsZkFI6Iua6Vbxi1Svnjqj4hQLVhjgfZQOpnHWGwB10dQNM1NgTNQB8uDkmQoIP
	kriZXYKKxVQK2apMACTGqfWBeOJVD3x9i0MyLLjBkdGGTW003RGMK9SqPpbMGizm
	R5429j/EvGcX0/lKADkSfu6Ycly+YJiecOPXxbg3je3Wvi8qn/aAjyrjXLXJEyvg
	cjuUslSXudESyAMSDuyC+E+mvntzcMT1guT8zG4A51n19dFIeCdvEAsYe7DSRmKu
	QQ==
Received: (qmail 607358 invoked from network); 2 Sep 2026 13:05:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 13:05:31 +0200
X-UD-Smtp-Session: l3s3148p1@LGh6A35astoujnuD
Date: Wed, 2 Sep 2026 13:05:30 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 04/15] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
Message-ID: <apgC-m7SrDNU9YmQ@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I+T3EXHzJlatFLR/"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-5-biju.das.jz@bp.renesas.com>

--I+T3EXHzJlatFLR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> v22->v23:
>  * Changed the data type of max_divider from unsigned int to signed int.

You changed this because of a Sashiko report. While the report was
correct, I think the solution of simply using 'int' is suboptimal...

> -	mmc->f_min = max(clk_round_rate(priv->clk, 1) / 512, 1L);
> +	mmc->f_min = max(clk_round_rate(priv->clk, 1) / host->pdata->max_divider, 1L);

... because the existing code is just too subtle / fragile and hard to
understand. I think we should move clk_round_rate() out of max() and
handle it seperatly before. What do you think?

>  	 * greater than, new_clock.  As we can divide by 1 << i for
> -	 * any i in [0, 9] we want the input clock to be as close as
> +	 * any i in [0, {9,11}] we want the input clock to be as close as

Maybe instead of "{9,11}" use "ilog2(max_divider)" or something? This
matches the code and is more future-proof if the divider gets extended
again.

> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index c6db0418de15..2bf354331b2d 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -102,6 +102,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
>  	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
>  	.max_segs	= 1,
>  	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
> +	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,

Same comment as for clk_mask, I would not initialize to the default
value.

> @@ -62,5 +62,6 @@ struct tmio_mmc_data {
>  	unsigned int			max_blk_count;
>  	unsigned short			max_segs;
>  	u64				clk_mask;
> +	int				max_divider;

I hope that moving clk_round_rate() out of max() will allow 'unsigned
int' here again.


--I+T3EXHzJlatFLR/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqYAvoACgkQFA3kzBSg
Kbb7SA/8CeMma1Fw+5Fs5ab0CS+qRpcfqr53IicNc9cZs+F4jlQGqmFGUm/eNm93
WPuCtd47IVbNWgU1YHqmqprUeTC8qqSqIhNnTAyC8DDB+TLgeELkTS2OOIpSNg2+
igNs1FFJmv4g8QV9fQ6+hT6Ucmvhg/LTWgy415n3CkAITyvbe0mIVa+ZXGsdpnFm
sFkTNbgrnaQ094dcZ7M+uehHNElHvj/adjc3kiYTXRinbykLNy5K2cI/6v4anF1N
V7Gx50uxUj4A0U7fHndTlPS3oVaoK8uu+QkEnrjPAt/oyvYxtLiqB2h1huzaRD0Y
VAIfTlFOa13KS8lLbv37aB8VMAU0HubE7ffY8OFgZgRe++oUNTps4PFpp+TrNw9W
seA//R+ykWjz/I82+ret6SX+m8bSC7mdjtmHBqEqLWZ13UG2TZ/4hmacuKu3u9kf
hVqIITNF8BNEYn4q5LIbCBejNEgekm/11O5mm+x9aWk+FSTKJXQMyAPUj1YUHuZB
hbTcH1gi3z2I2bbn+6Mul0AUOIbHd3ID+XAdqAsdHYtxaVRcwvqKHDZCFcQEGGqk
LUA6jib0y5YLsidmDcKGQb4y5AryBJIzc4AkicERX+xFI3XIucgs3LuclgUsc3Gq
O5EumlmuuW+MIt5/kpWMokCN/FwegT08tof9J+vzB2E3u84YBTM=
=DAOc
-----END PGP SIGNATURE-----

--I+T3EXHzJlatFLR/--
