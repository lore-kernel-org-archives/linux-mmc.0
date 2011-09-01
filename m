From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
 from 100ms to 1ms
Date: Thu, 1 Sep 2011 07:55:22 +0200
Message-ID: <20110901055522.GB22652@pengutronix.de>
References: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37853 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1IAFzY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2011 01:55:24 -0400
Content-Disposition: inline
In-Reply-To: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lin <tony.lin@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2011 at 01:51:15PM +0800, Tony Lin wrote:
> 1ms is enough for hardware to change the clock to stable.
> 100ms is too long.

How do you know that? Can you be sure for PowerPC as well? Have you researc=
hed
why the original author of the code has chosen that value? If so, please up=
date
your commit message with such infos.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5fHkoACgkQD27XaX1/VRsEbgCgnaJBDmgPb8zw1RY0wozrsJco
v/YAnRhde25oAgKQQoDRsgzrB/45XbrI
=HyNU
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
