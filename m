From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 18 Oct 2010 13:36:35 +0200
Message-ID: <20101018113635.GA15440@pengutronix.de>
References: <4CB56A88.2040101@eukrea.com> <20101013082930.GA11286@pengutronix.de> <8762x6xx00.fsf@lechat.rtp-net.org> <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net> <20101013100632.GC11286@pengutronix.de> <4CB58565.5020806@eukrea.com> <A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net> <20101013102055.GD11286@pengutronix.de> <20101015102729.GB4276@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab0JRLgh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 07:36:37 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guo Shawn-R65073 <R65073@freescale.com>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Mon, Oct 18, 2010 at 04:48:07PM +0800, Zhu Richard-R65037 wrote:

> The debug msg "mmc0: mmc_rescan: trying to init card at 400000 Hz..." are=
 dumped out repeatedly.
> ROOT: There are pr_info codes in the mmc_rescan func.

There was already a patch on this list fixing it.

> The other:
> Encounter the Timeout and CRC error when the sandisk 4G SDHC card are use=
d as the ROOTFS storage media
> When I boot up the BBG board.
>=20
> It seems that the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" is mandatory required =
at my side when I did the tests
>  on BBG3.0 board, and the i.MX51 board can support the "MULTI-BLOCK".

Okay, this can be fixed...

> BTW, I still can't fetch out the latest codes out, that means I still can=
't found the V5 patches, although I run
> the git fetch and git rebase. :(

My branch gets rebased because I can't mainline the driver with all my
incremental improvements. Does just taking the branch and cherry-pick
your additions work? (BTW meanwhile you can also just use mmc-next)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky8MUMACgkQD27XaX1/VRum5QCeONf3n3wiZqJTGRvBEKSBV+X6
fBkAn3wcTnx8VrRFkP9j8A7+SRFaztMi
=mGU7
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
