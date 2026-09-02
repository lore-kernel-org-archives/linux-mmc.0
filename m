Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A24734EE
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346363; cv=none; b=g6owAm4AaTRbPPHAg4nIrN9H5K8ydyOq5+2j7zRWNJ1kJzyZrZ0EwXlejprWnZQpVlM4Ogmbajf9C5XhPBRsEg4pCy9uZmBnq9hG5skTSdhM55BjPEreGee4CAKgld/9x+dJhKSsOLjrGqbOfaFIxnF1E32HRGrI4aaXEfaLnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346363; c=relaxed/simple;
	bh=g4aJZ2RjcwW7U0smS6IixfD2FH2m9/1ImTEShl4a4GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USdokJ+65alw7BCPpjk6kU5htgoHui8MMBiNhcAtw5zQlkseR0d299t7EglFNfy+zPJiUPUVkuWfPHMK0m1cLhJ/llm1VkWqpTdAaRx/KVU6Igy3dIRwzv6xOUtRgZu4i4R9iTmwcEFWK09WGe4vtMvW6ZlE+HWDWqJh0nWBJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VUU9pYBi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VUU9pYBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=g4aJ
	Z2RjcwW7U0smS6IixfD2FH2m9/1ImTEShl4a4GI=; b=VUU9pYBi0gyTMLI9uuds
	yuq3ct+yiN3Q7jw+AORlKKjfyoVjhQUXvZqOzXvK3DBALCLl+MoCDVQ5f8ZFofnZ
	TIzoapaTfsL8s/e4FWoqJuAeKOEnN+M1fOq33QOJUu90kunDgeCbKz398U0EUjPK
	FGH/DSD9x61Yz3ZoQ/NBj9F1rTjWVSjWxH4RFE+abywWS5XB7u0Es65f9WUf9JPu
	bVqFkBaxU80h+1n616GJtHQHSL5bG2eRbWck8akhzLdQePJLP5bxucdvwPwHf07U
	qbm8kZGzMw678Cdlc0M4+UpMEa6/ED98FBo7398Kmvpk/xWxDWcLDzn42HjoMLD4
	Iw==
Received: (qmail 600530 invoked from network); 2 Sep 2026 12:45:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 12:45:44 +0200
X-UD-Smtp-Session: l3s3148p1@RAa5vH1aJJkujnuD
Date: Wed, 2 Sep 2026 12:45:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v24 01/15] dt-bindings: mmc: renesas,sdhi: Document
 RZ/G3L (r9a08g046) SoC
Message-ID: <apf-U05yy4eNwfIB@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PROTVcDqJHsMEqco"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-2-biju.das.jz@bp.renesas.com>

--PROTVcDqJHsMEqco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 06:16:31PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Document the RZ/G3L (r9a08g046) SDHI controller. The RZ/G3L SDHI
> controller is similar to RZ/G2L but has five clocks (core, clkh,
> cd, aclkm, aclks) and three resets (rst, axim, axis), so update the
> clocks/clock-names maximum to 5 and resets/reset-names maximum to 3.
> It has an internal divider for all modes except HS400, and a 2048-bit
> divider compared to 512 on others.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Looks good to me. Adding new SoCs might turn into an adventure game with
serious logic puzzles, though. Not your fault, of course.

DT checks pass here as well.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--PROTVcDqJHsMEqco
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqX/lQACgkQFA3kzBSg
KbYiFQ/+PvEF+HCEx/rzup0RhIbsZNqtE2qf090ahioHUHwBH6QyPDTslA8hGsvt
y0EZ73SbnsMiEgRXaXWFs3uejhpi4eTnMkd5fexWlsOzV+3Pye2G0E7K33FlK46t
H1eJgQJULjp8th6ha/k7HVkRJiFjj0bAHPyi0ksFrFrdsghNZSVYGqS7l+J/Ok10
sNlVu9DC/VbnZKIy/nwcOYyS1jPrMp9avmxmawPZz19/aIjGMePKEok2ZaqKzqL8
T8tTDtBRMlUGDy5pdLJuVkjATozZOFUsMu0qHAcGmNfjCzBZ/OgTNac2f+PV+rac
M4HwsGufWBJx3//vJSSz7p2irhyZ2XMbdz/2+mBUpYQCEZy0iCHt2ysvBG3iNqBo
wPocf4Ju4ar9nagthGbJdN0Y+3kj1z458GP/3mnb2jS+RWibBGJgHLS5YNWI5Xcp
iWBceG29mt41xvfL3H6PKUyhn/jwqjQKsM22+7mVyeFAIoXfpJdwc1JvU1w7AQjJ
RjSnRpqvTL5LEjKhTgfGF5ZLgxo5ILYDuvzjosyGclvdEdcDRBZ3hPchTFMc7FZE
l4JhfBvpqb5MN6/dfUrljRjIHqParN7um/2B2Bnk8Eh3pRJPTUauELAHZ3LQUiK9
MQWMrrLJlMQ6Yf/dnFxQXp5LLQWO2Yw6jlPADHFBIvfZDitP1n0=
=zrcg
-----END PGP SIGNATURE-----

--PROTVcDqJHsMEqco--
