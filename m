Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3453C3798
	for <linux-mmc@vger.kernel.org>; Fri, 19 Jun 2026 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901526; cv=none; b=ELU3ZqbgLHMjz9Cs35LfF1vp3Q9WJ0/ciZuCiVLL6P4jMTfu2qPq34SeOdhxyt3QH4e1CEeSEwtFmNADXnWoVvrE/EER/JUirQSTf2I74r/BwVzjAH7m0md5V1lccikOEKSozBbkYMo7psmpl2njc8JE1WfGP3n/I5cNe/FVrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901526; c=relaxed/simple;
	bh=EZr1+E4oVltKrjDfNKfRT8gICM8xtrPLZv0GScqUEb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZlIVdW7vDs/Ia7/k9V7zJP2Vloa0AMZDgiYwHeOgOvlCEoJeCWOmCQlyTHJ2Xm9W4DlvS1tNea9ue3jgVT6EDTHZit6FcI9pV2Siwg/Ev/lj/06oJohO1kG3Ne4D9ogZYiqAsgHZdHlCqfJqLZCAWXmidfLFWv2SiWYxR/mvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=em3tcqsv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="em3tcqsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=L+tl
	7S3h6sYShTNI3fZIx5NImbXSRV5f779EeY3Ldpo=; b=em3tcqsvfHZBOsnHgMGn
	QHy/IDzWSiHl2bmzUb99g+8tC9TvJGteUAx504I25/nbNSLsA0FaebSVZavLs2LQ
	p3jmjAlw2B4lqBtBtQwKE5UGQqkyjZSbj1MsyUY2sl8NVnkYpTXDDs11ocs8PWDE
	a4DpXCCjRpFcQWR+IBIbitgrozbUTf6rcL/PW9pVcWxUdQcZr5/4v64weZjlhLmL
	oJj8g4rIusEs7Kn0rQLQjDb1VGkLiKMOmW1pjNmB5hHvKUNp3cWDJx0l4WhToBu3
	RxiTETjrimIBQCkPhk/60gH3GeFSOp1jyHpcl7GfPvy6plbYNi0GdnUT+7QcMCjY
	Ow==
Received: (qmail 1076573 invoked from network); 19 Jun 2026 22:38:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Jun 2026 22:38:32 +0200
X-UD-Smtp-Session: l3s3148p1@l6ajRqFUpNMujnu2
Date: Fri, 19 Jun 2026 22:38:31 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 06/17] mmc: renesas_sdhi: Introduce
 renesas_sdhi_hw_info to abstract clock mask
Message-ID: <ajWox2c91f9R4lhZ@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-7-biju.das.jz@bp.renesas.com>
 <ajKUpOHCaufy42NH@shikoro>
 <TY3PR01MB113467337ECB82BCD7E812DD286E32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymGzApE8W6HMv3+9"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113467337ECB82BCD7E812DD286E32@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--ymGzApE8W6HMv3+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

> Ok, I have prototyped with renesas_sdhi_of_data and tmio_mmc_data as per =
your=20
> suggestion

Cool, thank you!

>=20
> The below variables[1] added to struct tmio_mmc_data and
> the feature flags[2]. Please let me know is it ok or not?
>=20
> [1]
> 	u64				clk_mask;
> 	unsigned int 		max_divider;
> 	u32				osel_tmpout;
>=20
> [2]
>  /* Some controllers have tuning delay */
> #define TMIO_MMC_TUNING_DELAY		BIT(13)
>=20
> /* Some controllers have internal divider */
> #define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
>=20
> /* Some controllers have hw adjustment delay */
> #define TMIO_MMC_HWADJ2			BIT(15)
>=20
> /* Some controllers have HS400mode2  */
> #define TMIO_MMC_HS400MODE2		BIT(16)
>=20
> /* Some controllers have HS400ES  */
> #define TMIO_MMC_HS400ES		BIT(17)

Yes, looks good so far from what I understand about the differences.
Keep going, please.

> Agreed, it now works without hw_info struct.

Awesome!

Happy hacking,

   Wolfram


--ymGzApE8W6HMv3+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo1qMcACgkQFA3kzBSg
KbZE9BAAiWAVAvqnf3djwiwI20QtD9cD6qtWqJBpv7XRf6AaAHMiAmQqQYuZVyRC
N64Es5l8bnTp2JqPcdZbdr0NchavCVdpXMziTNVNKedhCoDBpuH2cJcQzyKHYQV3
t6h78vXogpJm7moIZLYauIGzfKmayo27dtATz1FbJ57lLSBLfIS2lH+lEExy2laP
BQ/uapTG4u3eNfp5Jitm1zeOq4e7IGr/MzgrZU+pXysrECENubkfJHPgekZlAMsx
fJCQlw7bnj+72J9AzFd1GRskgB1cZ6tsYi4N5s2pOxCGOqw6BbJLb3gLzA/vW8Hx
Ua83t+1SsdFyORVbGzavVnkiLE622z05lUykJyNSskZCKlR+yVVmxrmw7XkjSCT1
sjgwU+61dyDUEMU2KkvQhs2bfNWZiR8nqpqYqYt66DEnnoUyxMKSW9udG6gtsRAx
ks+TcEkbVM4I/xufs5x9+F6Ym47cw0+Cz5+NNHY0Gc0jl3DRZ2/tTwn6/RR2IMjl
WKKZ3ISmg4ynYBfVVFwClpTzSMnilj1/5PtKGrlyKnRnTb3oCYPmBEGu7EEVxolU
BEF0cH64ezXJltARJs2tk9J92BJXqZfuarK2MxAjToZnx2D2sMnpsYzNI5GhZaVh
OpmEjtZ/c3yvXtQJLJJlvze14U6oXRXMBDKVLSHHwCIMEE3d5EA=
=Djc0
-----END PGP SIGNATURE-----

--ymGzApE8W6HMv3+9--
