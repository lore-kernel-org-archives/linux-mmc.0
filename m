From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
 and card detection
Date: Thu, 24 Feb 2011 14:12:45 +0100
Message-ID: <20110224131245.GA2420@pengutronix.de>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
 <87k4gp3bl1.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59828 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1BXNMq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 08:12:46 -0500
Content-Disposition: inline
In-Reply-To: <87k4gp3bl1.fsf@lebrac.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I'm getting a hard freeze on my efika sb and mx once I remove the
> unconditional BROKEN_CARD_DETECTION flag. I'm still investigating the
> issue. I'll keep you informed if I find something.

Hmm, this is probably an unhandled interrupt. Will see if I can get the
efika here...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1mWU0ACgkQD27XaX1/VRtEIgCeKmilbtcuL+LhPz2WFertzt2U
hCgAoLPJxoSBE8EnTE6qggmWcqSGaVBS
=2hZu
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
