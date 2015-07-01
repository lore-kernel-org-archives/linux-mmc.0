From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] mmc: core: Set load on vmmc and vqmmc
Date: Wed, 1 Jul 2015 11:59:25 +0100
Message-ID: <20150701105925.GT11162@sirena.org.uk>
References: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HtRZva1Vzv8iP5ye"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34890 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbGAK7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 06:59:35 -0400
Content-Disposition: inline
In-Reply-To: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org


--HtRZva1Vzv8iP5ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2015 at 09:38:45PM -0700, Bjorn Andersson wrote:

> +- vmmc-load: requested load for the vmmc regulator, in mA
> +- vqmmc-load: requested load for the vqmmc regulator, in mA

Isn't this something that should have default values from the spec?  The
binding also ought to say what a "requested load" is.

--HtRZva1Vzv8iP5ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVk8gMAAoJECTWi3JdVIfQ/F8H/1zbZ/Cz+O2qCTwqijuWpnmY
Dhrz3oJn6yEBq6lRu3ZAnebhA9qV0vgCQOxnbMWrf4CXrarLSP470SIpciWiD+aq
Z+SkTDKtbGbEMv2Xn/8zrw7jsprW8KJnVbi0OqOy8+oCvWoblhajovfPPityBiEP
qst+ANqrF3/8kgST56pJBGbM4tDf+AVf7fUdYp2MebHuYp7UDEv1vrFTdXkynyQH
+faadFPTAi7sDMVKNhPgt5cHd3Ryghj1SkKlJjVgifw6VwSHaewY5H5CBjm5UBXA
MqM+HlaBeIP0zi4t4C/6XF+v1kVED8mM1kxCq9X9+dy5SR5clax6OzioMv0hbMs=
=LfQn
-----END PGP SIGNATURE-----

--HtRZva1Vzv8iP5ye--
