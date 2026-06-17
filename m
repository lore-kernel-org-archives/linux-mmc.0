Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3132217F27
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705949; cv=none; b=hkFHdYbRxUrtFz5/u0Tsxv7eoDBIbXNCaK3iEuuof+CedAtmDeHY0EnLFT/v690vSjrkwF0RMyzsMVd7LzQyUMgqcmtg7kRqoaK2QMFbISzgJHnmMiy+553hy+NeDlmMMFB3X7OuaBG3RUBamycjSM7z7Se4n5z+Nf0nUjdVQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705949; c=relaxed/simple;
	bh=JCD8cvv8rlUBHXPK9uD5sq5eLv/nvfOPoDDvsUVKle0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx/S2zjiqGVx8CghEOF7Bfe2Jl7/jLDQniObPGB5LkiYtuuspzF6rHO5im1ZyDMCjzTwICehCXH3DacTga0AY4Asu/OOFJIClnK5hvQCRUQRybOVTPyBEABgfpby2vafixkihugkzidK0aJ/fZnHF+Pnx3xILx0lhymBZXgqXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=alDJPvvU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="alDJPvvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=900S
	KMhfjAoJ0k5ypr/nO0lm8fvJ0WQU4Q8AFwgz2FQ=; b=alDJPvvU8hC/7oiKyGei
	v+YhbMJly6NruUddCTyvb6Hk/jvhQPgu4pzuSqFi4YZUXnsFO2D9Ss6Wmw6SHgVc
	5XaJktkjoFD6hIIAW/7pc1XvFnvZO/9SiC4yVlXHgknXJ+cdqLPx/s2zVOjrtoyj
	B/1xCnf8xrCERwpkQDkVppNWZA3E3z+6zFSR9N5lENbnyDKWnsn1BHVW2qfO1Euy
	3L00ObKu5An5w7hcnaf6iuNJd7FQ4ME+NYzGlxyXOuddzVoo7cOkZj70HMVKEsqw
	T0pRnpxyssxmV42Ss+Tm9rxt0HLhosVs48uDz6hcnYj1ICHMpYf3cogUuS81EMOW
	EQ==
Received: (qmail 198739 invoked from network); 17 Jun 2026 16:19:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 16:19:02 +0200
X-UD-Smtp-Session: l3s3148p1@aG/DvXNUrWBtKXEK
Date: Wed, 17 Jun 2026 16:19:01 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 08/17] mmc: renesas_sdhi: Add tuning_delay hw_info
 flag
Message-ID: <ajKs1aZiFwHkOBGt@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-9-biju.das.jz@bp.renesas.com>
 <ajKVxixgTHaavVfi@shikoro>
 <TY3PR01MB1134670687D54134ED8479CBC86E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56iKqqiBSDpEqFLZ"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134670687D54134ED8479CBC86E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--56iKqqiBSDpEqFLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +	if (host->mmc->ios.signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
> > > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
> > > +	else
> > > +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1); }
> >=20
> > Isn't it enough to move this upwards? I don't see anything requiring th=
is function to be so late. Am I
> > overlooking something?
>=20
> OK, you mean this function along with SH_MOBILE_SDHI_SCC_* macro upwards?

Ah, the SH_MOBILE_SDHI_SCC_* macros were the things that I missed. It is
okay as-is then.


--56iKqqiBSDpEqFLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoyrNAACgkQFA3kzBSg
KbbFBQ//Z4YbxlxhSc5Hg9+34I01TCUEVRJcobPhGG9TdglpkkCxCtOIhtNymsk3
BCVKQ8CHTaILRdazgFLLi3d/PLHEKPZtlRrh+cLiCpeEe290zWlgFedTOn8CRehE
z9sseGvwSPLDS+rc8lKzvF2US1dtxDAGPONmbfy//9+72ghy2P7ZfeneflUPWpa/
9ev+Nsuy6KM8kE8bOE3wTQPpEbTz0JRNH8QBKOkfKe/wfmo6tRZGThO/3/cbqwFg
0pKEhI+9QPfzFgWJ1C+HW1E/hQDzqeQFh5E2XcQ7J/liQqnUdIJKOKvuaT5b2ppB
lnTrer309CS00sayNYDREHizmA+zFyMUwWDmPjcY5VjdpTnYAO2+nx+ONpZmz2Cw
z1FrL45AD1kVjqiO8iSv+r8EbRYT/yhXQePNJF3pETf9JlmMrvHQoqMsurJCuWzy
ockW0tVbUhvfzv6DjbjA612AxmAnsZguS0NgqQxyMruZRQ1qV7F89rjYmZcG7xuC
KMezIwjUTW5EQAPVn8eku1A6nB1u6CThjdqtaIEL7RX+Wf3OubtkcjIP7znZP+Yv
kJDRyGOSKsjQMUwh9A57rZqh4ETAyCbiAmUJH2J2hmo05ih1Xabb//7iBcsaB84Z
DcGKYwSE+I5k2oVOuOuT5Mt/PlfmDTghsSRmMpE6NPXr6RJRGX0=
=5avp
-----END PGP SIGNATURE-----

--56iKqqiBSDpEqFLZ--
