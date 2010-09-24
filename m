From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Fri, 24 Sep 2010 08:43:10 +0200
Message-ID: <20100924064310.GA30543@pengutronix.de>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54441 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0IXGnM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2010 02:43:12 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

> * About the share between i.MX and PPC eSDHC.
> Why configure a few parts be shared between the i.MX eSDHC and PPC
> eSDHC? Can they be separated into two independent systems?

The rule of thumb is to avoid code-duplication. Assume the PPC driver gets
fixed an off-by-one error in the freq-calculation, you surely want to have =
that
fix on imx, too.

> It would bring the conveniences to maintain stuff in the future if we
> separate them.

If you can name these conveniences and they are convincing, we can keep them
seperate. At the moment, I don't see them (what doesn't mean they don't exi=
st)

> And there is already one set of eSDHC driver for all the i.MX SOCs.

I am confused: which set do you mean?

> As we know that i.MX and PPC are the disparate SOC families.

Well, if the eSDHC-core itself is the same or very similar, that doesn't re=
ally
matter IMO. Especially as the of-platform-bus might disappear somewhen in t=
he
future, the PPC and imx-drivers could become more similar.

> * About the driver name of i.MX eSDHC driver, I think that use the imx
> to identify it is better than esdhc.

I picked up Anton's suggestion 'sdhci-esdhc-imx.c' so far. Although I am st=
ill
not sure if 'sdhci-esdhc-pltfm.c' would be more precise.

> As I know that the eSDHC name wouldn't be used anymore in next
> generation SOCs of i.MX family.
> So the name of imx would be much clear and exact.

Not really, because all _existing_ implementations are called eSDHC, no? :)=
 If
some future incarnations have a different name, but behave the same or very
similar, this is usually no problem. Check for example the I2C eeprom driver
which is named 'at24' but support basically all EEPROMs and not only Atmel
ones. Same goes for a couple of RTC-drivers, etc...

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkycSH4ACgkQD27XaX1/VRsRMwCaAjqftkq90VVuOvWRIhQRMx2K
8qoAn2KhsafocqrR8b628zoFdm9vLMwv
=evNw
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
