From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
Date: Tue, 14 Jun 2011 11:24:10 +0200
Message-ID: <20110614092410.GB5043@pengutronix.de>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60184 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab1FNJY1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 05:24:27 -0400
Content-Disposition: inline
In-Reply-To: <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2011 at 06:42:49PM +0800, Shawn Guo wrote:
> The issue was initially found by Eric Benard as below.
>=20
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
>=20
> Not sure about other SDHCI based controller, but on Freescale eSDHC,
> the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> gets cleared, if a card is inserted. The driver need to mask the irq
> to prevent interrupt storm which will freeze the system.  And the
> SDHCI_INT_CARD_REMOVE gets the same situation.
>=20
> The patch fixes the problem based on the initial idea from
> Eric Benard.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric Benard <eric@eukrea.com>

Hmm, that should get enough testing on non-imx (and even non-ARM)
devices. And a comment describing the situation.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk33KLoACgkQD27XaX1/VRs72QCgjnmh0y7YYehy5vZbq62Eprcc
dVMAnRiJnrZoMfPC/BR4h5/I43ES+1ns
=KsKA
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
