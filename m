From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: can we remove the quirk  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
Date: Tue, 9 Nov 2010 13:21:57 +0100
Message-ID: <20101109122157.GF3223@pengutronix.de>
References: <4D68A6A7-2D95-463F-875B-DB52ECCC53F1@marvell.com>
 <65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
 <20101109115517.GD3223@pengutronix.de>
 <23C594B6-1B72-4DE0-8BE7-04E1FD36B58E@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0KIMWB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 07:22:01 -0500
Content-Disposition: inline
In-Reply-To: <23C594B6-1B72-4DE0-8BE7-04E1FD36B58E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@gmail.com>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philip,

> Doesn't the platform data hold the specific board specific quirks ?

If we agree on not calling it "quirks" but "configuration", then we may
in deed be talking about the very same thing :)

> Can you provide an example of how you see the platform data being
> used.

Sad thing is that I don't have a board using an 8 bit width bus :(

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzZPOUACgkQD27XaX1/VRtE7wCgt412ypc5t0oY0udY/7vqSxkW
PY4An2exkMExoGPCtHuammY2tilPMKAS
=QWMm
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
