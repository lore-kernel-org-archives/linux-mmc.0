Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0813B592
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jul 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999491; cv=none; b=en6XPO+ye/QfcSNVVKDmhb1bANzyvbQph/rqc3BcMgrVKgKyPcymS0FXXXYWaentbRTjCCqJyzszo1AKnWM8ZyTMthtuLTOGpnDzxRcqSVbiZylt+RdyIv/3BDDXsVYaxyNN/ocIOgFt4DGOAqcLbCvRCxLB4d4tZMjUPrGHmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999491; c=relaxed/simple;
	bh=WqW5N5vhce1BJCwQssaorgX8o1WWx0esUvxlticDErY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO9/aK+SrGTCZeuLir1mlK8l4XD5Zw5Z3trH4sMCQH/4s6qCiwEa39Se1sJzoIMQxq/znjeV9mgBNPY4GZzc58QvBsKO8kpEyk8A0f2t3pXdjOy/W/PFTIfuov/XDvKWros242UA9ohFNFB7WUUV9uKOdhSSpO7QWZIC/giUrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gvDd2HZ/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gvDd2HZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=WqW5
	N5vhce1BJCwQssaorgX8o1WWx0esUvxlticDErY=; b=gvDd2HZ/2SeBygE6JOH1
	nRQc3sMwzm+XfHiMArZEIRNmCV9U2icBeHkTYKcMs1P2va+IB1zKnLojExgV4jUm
	e6J1iUSOYo5Z9hpg59o3M5FOd/xOUZlOSXC8fHYkSfvrVB++HZkIxJSSKVA8loch
	OXXDyfVmUgc3fYQyxKzKf4Cr9tkkp2Mh0ucNJcMEkVQr3RmArevrM1Iadv6emjbs
	IK3gDBoWWKm6k+i+6U8q4/nQF08MQOEoVQzjQr70Lmzdj5ppi60wPZ+RnzunAT//
	YJfhFVe3nYg4dA0yIjvNwkaIYi+oVBKZCr5dWX1In11S4jRRdvuEcbs7iQJh5bz8
	GQ==
Received: (qmail 2757245 invoked from network); 3 Jul 2024 11:38:06 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jul 2024 11:38:06 +0200
X-UD-Smtp-Session: l3s3148p1@NstlllQcishehhrb
Date: Wed, 3 Jul 2024 11:38:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: renesas,sdhi: Document
 RZ/V2H(P) support
Message-ID: <ZoUb_olfaVapoYBi@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240626132341.342963-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240626132341.342963-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iPwmJwlsopKq/aKH"
Content-Disposition: inline
In-Reply-To: <20240626132341.342963-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--iPwmJwlsopKq/aKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 02:23:39PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The SD/MMC block on the RZ/V2H(P) ("R9A09G057") SoC is similar to that
> of the R-Car Gen3, but it has some differences:
> - HS400 is not supported.
> - It supports the SD_IOVS bit to control the IO voltage level.
> - It supports fixed address mode.
>=20
> To accommodate these differences, a SoC-specific 'renesas,sdhi-r9a09g057'
> compatible string is added.
>=20
> A 'vqmmc-regulator' object is introduced to handle the power enable (PWEN)
> and voltage level switching for the SD/MMC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Can we have an example here? I can read DTS snippets better than YAML
code :/ Also wondering about the "regulator-compatible" property but
maybe the example makes the problem clear?


--iPwmJwlsopKq/aKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaFG/4ACgkQFA3kzBSg
KbYbLA//c2KrKF77eSjgTiTSPmk4F2q+Y96EIf24uY4NzA1O6sHvuXDAIiHS9IkN
V6kgK8UpUG4nhaW1dv5CTOV0jQZlqI1nrKgS5nwWppDv2JqrPtt3+nfJ6gXLnIts
ote7Bldb0ahFEwZnnQ78Z1WV6cjCBi0ixGM6IXPcNldzU/gtRC/GbisQgZRXiYUV
G0li7NnOmXkIkBujEQxH5yv2ejDgs9JokjpTqa0XGold9ICZ1ZxJ8/nhfM4Tqq0h
zcjaZVECGVI+tYp53UgzRWtqpYW24J4AtLe2Gm3X3sppqq5Eeu9c9wxGQdkgLxCl
n/tve9stOv0VxKughkb9dsglJ87EFi1IKYmvw4FG3v115AM3G8MnZVWmKGs9pLpN
mdp1Ob4PcnUsnfa6zyVKQFBIxnhksooEv8pMn4VI4xMp/e7Yk0ij+VdEiuIbD8xh
6dufK++JzEHs1auGh3JTSduB0HgHT3WaxK80uvBGG/zwDKOooMAKOEloqqIg+Lhq
EBXoKh5laiZCiVjB1DJDVVAUszOzCGQgrZrLZ3eFu64uXQiAnxjpFjwW+J/WpWdL
iB/lPSMwsok+v3cBK3s4cFAnMQIHqsgADskIHxUZixpnkyspnDCkDb/kQW17od/x
/TzgbIkhG0B3FTDyfP37BloYqTidaExNJBXVpk3sn04WqI7x9Ak=
=yYhE
-----END PGP SIGNATURE-----

--iPwmJwlsopKq/aKH--
