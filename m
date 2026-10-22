Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659819;
	b=Z8dMsvo4zNSJdqqiesoouudYnYF1k3Ox5Mpn3LKTb3PpmDpNQpmJ52EXX/2tJ1TcxRe+
	 Z+qebgpPsGPGHE0qdJ/BPKm7v2dqap7/99bRa880LR3PzsZlKqQbOO/8QRq02eTcdokx3
	 BYjCsrHpvSzs24lwMtWdwtKYNLBDSv29VWBRDRUezs+sDbxPIlzEG7OztZXshnCPlzbCJ
	 VAMfZXCTSE/WTgqqN2XBnCaaf39VrQgpCiZohdBmkvWOHAPV0MG6GxzBIIJ6AJYoYhgMP
	 /7unoOAVy4yFk0p11y5RWlTq6dZ7zcF3jnBwn+lv3oh/p/kjyrQlGka13fON+d8VWqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659819;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=th1rgFIEa+Cf+jvGOKhrS5SYYwAobP8Fiqzy1jWnEdM=;
	b=stEMauXumg58fkFtJM/+j+VBZQBssyqXVFs19aRJjaXeQfiS6we/Z1TRXtIiquco1K1f
	 nsUN9hJOMJiNKTG1a1+CPkAZTno8XCjSprKvh6Wb52vYC1k85VZkEC7QIvsK6OIIiS9Ee
	 4yuYZmIp6jjWVVg+aJRZhN9ScSF45JHxE1OUivV+dHxA/xhT9uaz97RfLYcqDcJaXD7Y8
	 AFAHKW0zi5gn8RnfmhoZ4fnv7iOPnuRlo7e/7xcFvbAURH+X6ST6lSfqJmFDev/Vtk9av
	 E7vXVBLo2n4GsHQFPUIXDrFsMxLCBQNIJZQRRnN/B35c9qBlDmcNKjnaQMnnPh4nq9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=GAdxC5qf;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C5606A31B
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 928C5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=GAdxC5qf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=th1r
	gFIEa+Cf+jvGOKhrS5SYYwAobP8Fiqzy1jWnEdM=; b=GAdxC5qfwc/v8PergLgg
	ARjzl/5C1uq9wE5rb2FygQ3Y/xB/YXHzFtpTjf/O3feH13UYXyi7/TxzIRCUy9KE
	HWiyHHvCrw2mQiotEvXLoUH/CiZq0iXODaRz4V9uIle6NFX6LJaQt0pg+9tszE3F
	PpnW+JwGV8VOwcdQfLxaTRNCII/IZghPcrX5kV3p61DQowlcg85x+z4QIfChfEKI
	GQPGiNLgVyQwxtULG/IgGXG+ieJl8AgJ6ZZIEj9v1of/k68o928VXg0dgf3R87qS
	r0UvmgiyziO2P4AIUc3DTVl0XkZwAaJyrVLxKOCZIPSSvgEtHRFpKzhGdi5eL2Al
	6A==
Received: (qmail 1079903 invoked from network); 22 Oct 2026 11:03:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2026 11:03:28 +0200
X-UD-Smtp-Session: l3s3148p1@GyYOI2peXLoujns/
Date: Thu, 22 Oct 2026 11:03:27 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 08/15] mmc: renesas_sdhi: Add
 TMIO_MMC_INTERNAL_DIVIDER flag
Message-ID: <atnRXPLulZyrkp_m@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-9-biju.das.jz@bp.renesas.com>
 <apk_81IYqxrWZyJK@shikoro>
 <TY3PR01MB11346EC6636C810EEBA215F4E86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQ+xqu+tRMuz+sma"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346EC6636C810EEBA215F4E86B22@TY3PR01MB11346.jpnprd01.prod.outlook.com>

--pQ+xqu+tRMuz+sma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

> > > drivers/mmc/host/renesas_sdhi_core.c:renesas_sdhi_clk_enable() {
> > >     ...
> > > 	if (!mmc->f_max)
> > > 		mmc->f_max =3D clk_get_rate(priv->clk);
>=20
> The SoC with TMIO_MMC_INTERNAL_DIVIDER has always frequency defined in So=
C dtsi
> and this condition is skipped. Please let me know should I add a comment =
here??

"has always defined" is not ensured currently, or?. So, to achieve that
we minimally should

a) make 'max-frequency' a 'required' property for SoCs which have an intern=
al divider.

To make everything more robust (and IMHO also more understandable) we
should also

b) move the above 'if (!mmc->f_max)' block to probe (as 'f_max' only
   needs to be set once unlike 'f_min')
c) bail out in the above if block if TMIO_MMC_INTERNAL_DIVIDER is set
   because it then is required. A small comment explaining why will make
   it easier for our future selves ;)

Makes sense?

Happy hacking,

   Wolfram


--pQ+xqu+tRMuz+sma
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrZ0VwACgkQFA3kzBSg
KbbmRA/+MhQg1xA9UN7Bne4VszF1SbCcMHEsgPab1Gv1X4NfaVLlfp7ydFhQbga9
yrt3I7BT6Wxol15oC529c2XVeh5mm28sfmlLprCc8MWfxCUAKl4gBLTj7Etdoma9
HSXahjV4OBVjnRAs2lEa3eoTWimmpUhQrSz6gQcU+G26kgNuBTisljNM7TlC0CBy
vQ9AD1SiZRahg3nKEIARkEzWY6ezpbFYwpLZAXleR++0nhCzFwCgqxj6BScrcLLV
ao7J5tFpZp3wDe8GozzG4xcBBt4x2cIKveZHjEk0WpfxvvsmwVas5J38kdCWzCay
pit4O6zOKEx2WqF56VWGcceIhzohPdfDGLtFUQc533Das5eAjt27XsJHedAd9RDy
KY7zo1uSGgb3Oo9XFJnn/qJPGWOZ2PXeBzRk8xeVkmXfgVrZEa7KCccI3xcX8OGr
flQ3Ifg+/y+XGCgQYENliAhp2gjyXJkgXsealhc29H29MtsbXAXJ8txtpAWAEgol
4b28jh02prS3MQn96RcBYZz+uI7he2RsIfrucBNW0WtxuukTkV6o+LKpXW6h8rtg
y2OFmmmqtgVL2f7JcQn/l1TMK1L36uQg6THonLanj0/VBcqcm0axWe7I4hrdamPf
7p6QB/VgBDeb9pqbbPVolkiUxWHQwbgynMAMZun10EqLudUwctw=
=mOAh
-----END PGP SIGNATURE-----

--pQ+xqu+tRMuz+sma--
