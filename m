From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 18 Oct 2010 13:38:36 +0200
Message-ID: <20101018113836.GB15440@pengutronix.de>
References: <20101013082930.GA11286@pengutronix.de> <8762x6xx00.fsf@lechat.rtp-net.org> <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net> <20101013100632.GC11286@pengutronix.de> <4CB58565.5020806@eukrea.com> <A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net> <20101013102055.GD11286@pengutronix.de> <20101015102729.GB4276@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net> <4CBC1528.40907@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41967 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab0JRLin (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 07:38:43 -0400
Content-Disposition: inline
In-Reply-To: <4CBC1528.40907@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, Guo Shawn-R65073 <R65073@freescale.com>, linux-mmc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> you seems to be right, the attached patch seems to fix it (tested on our=
=20
> board using a Linaro rootfs on a Transcend SDHC card and I didn't get=20
> errors after applying this patch but I'm stopped by udev errors now with=
=20
> this rootfs).

Is this needed on MX35, too?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky8MbwACgkQD27XaX1/VRtT2gCdF7c/UkYTa8Z/ET2kcLQkpf4I
Co4AnRmmVtMU9sBlbRz+bw5StVXqx5Iz
=zL1E
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
