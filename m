From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Mon, 21 Aug 2017 10:25:23 +0200
Message-ID: <20170821082523.GA2418@katana>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:50498 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbdHUIZ0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 21 Aug 2017 04:25:26 -0400
Content-Disposition: inline
In-Reply-To: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  	  Below is the number clocks for each supported SoC:
> -	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> -	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> +	   1: SH73A0, R8A73A4, R8A7740, R8A7743, R8A7745, R8A7778, R8A7779,
> +	      R8A7790, R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
>  	   2: R7S72100

Hmm, maybe we should convert this to only listing SoCs with two clocks?
That will be easier to maintaine since the majority seems to have one.


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmamO8ACgkQFA3kzBSg
KbZAhQ//eQYb5pxOg7/SDMdhRx8QA8awWsLI8fWdghLrchmdH1xfMfCnJGAHacq2
frOqBHXgYbo/GiNL8SMqd72MFuviopK8AyMD7x81TtdtXb0gb5icz87HXQtABrlM
gbROAhzDehJRcp2lwFrR98cYqobB0VTSNXm7R4rHVYOD2tWFaIEWPOMkTcBlvkNS
/AjzqBCl8NJ4+VrxWtohNLHqUBOdTfbCDYP25A6vFaRYxj+ObDT120z522lVkt99
N+0a1AnZemMWwmZphxv1SnuSqvzYxZZtqi51ONLILx0A6acEskEWpDDSX+PSZiS5
zeWlspR5SslFlASUpl6nGXMKUvk+zTJqYQfptiSF1xNDlkeaGi+07BMsMEOSfhjz
dB108iVOCzydxvwC8EVKEuJtMqjBu2hU/4QI+Nr8QELiUh3ozBDPWfSgSmlj0mdq
r7zLuaHZCecagaL/WZbetNZ9KwY7RAFipR9aXgAty8v973ZOwMfx+kqY8QIS674r
eVb9ctpEb1WqGV+j5Akd/W9JsrNy8x94c3lczeS3NDt1ehuoZby7raHoqNs4t9cn
pRegQyYyOQZwKaRzUoJNElvHDLmVi/OijPfrOG9vulQ2tLHE5cHWHFOWGAcDdDiw
N8p+GLMVurlO5mpjUyVBvaNVLTNL2Vl7vsB22x1gjycA7iMukMU=
=lPi4
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
