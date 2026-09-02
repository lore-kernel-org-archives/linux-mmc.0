Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD643BDDE
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346273; cv=none; b=frSbAmayOi9qWvPXQAzmoQmhIdPjq4r0sZzSUiBhmuUIPn5Ke/NF0ZrgIONTHDsCvFMfwSHGzDULkWNP7QmZfanATMHWprGfhfoJvWD/SN8OyddDj/dzv8yjqUdDJ6RdUjuiQ67muveIPvXc436KHZZOntlHUAx61N1mjL4kSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346273; c=relaxed/simple;
	bh=7+pgVRiEqs6a0HKoe4GsO/ApMXXLth0gkdAXurYMzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDQMyNQU/kU+y2DNKj5qaDhBS0aUhTaL12xWADI3RYvBQkq8Q3d7kVjj9nxQAjdxrN+E55inpg2kf3vS14h0P5KWhzXQf+trnjzpasC6HU8wjEk9+XaaCR+KC7DQhK3eZB6B2qA5UcSdCDH9gWqXlekuH3Oyu+Ddd1fauDravtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TXKjq/JN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TXKjq/JN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KUZS
	pW9cXyMvfhg/XJ45RuGZTMIRYgou34R5eqncWgk=; b=TXKjq/JNhIf3gToySB1B
	Vw90Hzhzkvzhu6rILqiFh7olV2fsa7/5t26ErITAZxYufz5sJ8rArEIjPA9OIxc1
	RlIXARpNVAaZMlBITdQJ7fw0CQ7Q1dR/BYkcZgRbjieZm6fAbIOOIzYC5noHSbKy
	LNL5qg9v6UmKUK22XlbhOxqidv0/YUCMj/EuO/b06XyF/AJ+ZZDNZipCLfeBvyrI
	DmgWuTgMs8f7a0vAbunseOnJ6C6H2aKx6XWfoxSVlYe86WEwZQKGv6P2fdOm6KrP
	nAmSGs4JtmaANYlDy6/oNcJc67TVYqyF+461PnI4aOA0lVHAs0c2/x37bX9iSI/y
	qg==
Received: (qmail 602205 invoked from network); 2 Sep 2026 12:51:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 12:51:02 +0200
X-UD-Smtp-Session: l3s3148p1@QHKrz31arNEujnuD
Date: Wed, 2 Sep 2026 12:51:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 03/15] mmc: renesas_sdhi: Add clk_mask field to
 support flexible clock divider widths
Message-ID: <apf_lZA1TgMkItYw@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MEO7vtC4g3Cr2ZB2"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-4-biju.das.jz@bp.renesas.com>

--MEO7vtC4g3Cr2ZB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#define SDHI_CLK_MASK_DEFAULT		0x80000080

ULL suffix maybe?

> @@ -101,6 +101,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
>  	/* DMAC can handle 32bit blk count but only 1 segment */
>  	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
>  	.max_segs	= 1,
> +	.clk_mask	= SDHI_CLK_MASK_DEFAULT,

I'd vote to not initialize clk_mask when it uses the default value. We
have code handling this case. This makes the instances having a
non-default value more obvious, I'd say.


--MEO7vtC4g3Cr2ZB2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqX/5UACgkQFA3kzBSg
KbaCCw//VbTrKiMJx6qkHoBtGKicFTw6lTZ/FTWifz1YNQTB/7kOsFs6BteGWkPP
4yiO7xf3inqXUQ6CmFb+INtA/23+QxW4arnaP2yfVPExgwTv9kofoj/ODS7WH+cF
9TjxrWvzfaYFVDDaHNolEBrn69zJxGryrzzlC8w6etVxxDJNJSrEnm3cEb9UQDzK
QxGuWzslhByXVBm6J7dGlmvRGruYcu0izwT8qSeLAYXPMEkNEnlxgkMprFoZLr0Z
WAM9mm4pbYajf2u+Z+1V8qA/5rP83RR03izgYeGeM3z+yVJXfudqrDpOc2h6714W
KmJqo1E3LIGud+qInQxG1k6x02yXMZAzeTOO6vTU4fC/vo4a6DHJcSa8o+/1QW1p
ffZM61HBT3V1jJTTUD/ZnEldEyTBl0yFhQyl8+3GS9BP7JOKIAfAau5u27FT1GLt
fTPwqkhDgMRhnXQBet3tllOaWxzp95+uJWBH1LUERVstEtCRTm3jAGYFVyjJdIi/
dsy4TUYkWN4+OW5RYSSNpSaTs15/TLVEnKd37HQuJPvwMAx5nrxdIgZshkaKJdjS
cFsckC1idigdfNwsQeoa6gm1nzrpT3oaf8Otdtya/tNqEEaKbGEZPdTjW6zLxKmc
fsNNxAcdMjxZYoV91SaxFnEDM+cgPHLTe0c+gm6flnaereJrtss=
=BOkc
-----END PGP SIGNATURE-----

--MEO7vtC4g3Cr2ZB2--
