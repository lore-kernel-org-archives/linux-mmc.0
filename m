From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: can we remove the quirk  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
Date: Tue, 9 Nov 2010 13:27:29 +0100
Message-ID: <20101109122729.GG3223@pengutronix.de>
References: <4D68A6A7-2D95-463F-875B-DB52ECCC53F1@marvell.com>
 <65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
 <20101109115517.GD3223@pengutronix.de>
 <23C594B6-1B72-4DE0-8BE7-04E1FD36B58E@marvell.com>
 <20101109120835.0fea3feb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58928 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab0KIM1e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 07:27:34 -0500
Content-Disposition: inline
In-Reply-To: <20101109120835.0fea3feb@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@gmail.com>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 09, 2010 at 12:08:35PM +0000, Alan Cox wrote:
> I think I agree with Wolfram. Perhaps a much better model would be
>=20
> "Anyone who adds a quirk will have to figure out how to remove one"
>=20
> Several are trivial to remove and generalise into a couple of function
> overrides.

My favourite would be one concentrated action to remove a couple of
those quirks while adding well defined hooks to reduce the need of new
ones. I have a few ideas and am currently trying a few options to get it
funded :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzZPjEACgkQD27XaX1/VRukDQCfTBkxDK6DlWsH+V+SqAndlmVc
gygAn2tDQEMEmLmNhBIsmlcW2I7f86SN
=cM7d
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
