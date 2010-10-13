From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Wed, 13 Oct 2010 12:31:43 +0200
Message-ID: <20101013103143.GE11286@pengutronix.de>
References: <1286806866-19258-6-git-send-email-w.sang@pengutronix.de>
 <1286817032-21219-1-git-send-email-w.sang@pengutronix.de>
 <20101011183300.GC21335@void.printf.net>
 <A88EF4D64D8447468743DC1503C0B6CA0D557E@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34698 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0JMKbp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 06:31:45 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D557E@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2010 at 06:22:14PM +0800, Zhu Richard-R65037 wrote:

> It's better that the mdelay(100) is replaced by some litter value such
> as 10ms and so on,
>  since I encounter one bug ever when this values is set to 100. The
> audio playback would
>  be noised by the sd/mmc insertion/extraction operations.

Okay. Can you send a patch (as you seem to have a testcase)?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky1io8ACgkQD27XaX1/VRv4RwCgkSVjLeTnyOsR/SGS28+hPBsX
7i8AoK2HN5e56XW4sRzHjCIHLBO+rW3p
=Rrex
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
