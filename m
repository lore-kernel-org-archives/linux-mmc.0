From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 0/5] sdhci-esdhc-imx: use gpio for write protection
 and card detection
Date: Tue, 22 Feb 2011 16:08:35 +0100
Message-ID: <20110222150835.GI2755@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
 <87wrks5dgo.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49823 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab1BVPIg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 10:08:36 -0500
Content-Disposition: inline
In-Reply-To: <87wrks5dgo.fsf@lebrac.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-mmc@vger.kernel.org, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2011 at 03:52:07PM +0100, Arnaud Patard wrote:

> Has this been tested on imx51 ? By default (even after applying your
> patches), the sdhci has quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION set, so
> we're polling.

Ouch, thanks for that. I missed to delete the above quirk from
sdhci_esdhc_imx_pdata. Can you give another try removing it?

-			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,

That should prevent polling. Fixed here already. Will wait for Eric's
tests and send a v3 then.

> I've been wondering if it was a good idea to configure for everyone sdhc
> host card detect pin as gpio 1 1 or gpio 1 8 on imx51, which would mean
> no more polling. What do you think ? Would it be working or it's just a
> stupid idea ?

MX51 won't need platform data. The pins can be routed to the controller,
like efika-mx51 does (judging from the source and documentation).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1j0XMACgkQD27XaX1/VRv8QwCeLRXI4SlWAxZj1G7xtJEoMcRC
fBgAn2BLikHmsjACslDtYQfndgAb6y1k
=DjSc
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--
