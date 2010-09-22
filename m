From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: allow for eMMC 74 clock generation by controller
Date: Wed, 22 Sep 2010 10:56:54 +0200
Message-ID: <20100922085654.GA2693@pengutronix.de>
References: <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
 <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
 <20100920061459.GA9353@pengutronix.de>
 <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com>
 <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com>
 <4C984B01.2000005@nokia.com>
 <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
 <20100921165829.GA883@pengutronix.de>
 <15EE115E-4B8A-4314-BD7A-3FB24A1F1BB6@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38131 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0IVI47 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2010 04:56:59 -0400
Content-Disposition: inline
In-Reply-To: <15EE115E-4B8A-4314-BD7A-3FB24A1F1BB6@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>    Patch attached. =A0We are in a chicken and egg situation. =A0 The cont=
roller
>    needs data to cause the clock to start and the first command sent by t=
he
>    mmc layer is CMD0 -- mmc_go_idle(). =A0This is sent without the =A0eMM=
C chip
>    seeing the 74 clocks but since there are NOW clocks the chip see's thi=
s.
>    =A0It is not able to parse the command and we are struck.

Okay, and some host->ops->generate_initial_74_clocks() could help you
out, it seems. If it is a controller specific issue, the approach seems
in general sensible to me, unless I am missing some details.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyZxNYACgkQD27XaX1/VRsUxwCgrq8AKg5xiNmltMdo1MmcFEGY
jssAn1Jnrl/8B5ku7dmf71SKZfYIOc2z
=yNpb
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
