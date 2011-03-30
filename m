From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC 0/4] sdhci: few patches for ENE 712 support
Date: Wed, 30 Mar 2011 09:47:13 +0200
Message-ID: <20110330074713.GA2232@pengutronix.de>
References: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
 <20110319091544.GA16635@pengutronix.de>
 <20110330011629.GA15578@tux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60753 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab1C3HrT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 03:47:19 -0400
Content-Disposition: inline
In-Reply-To: <20110330011629.GA15578@tux>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Luis Rodriguez <Luis.Rodriguez@Atheros.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin Mehta <Vipin.Mehta@Atheros.com>, Naveen Singh <Naveen.Singh@Atheros.com>, "kvalo@adurom.com" <kvalo@adurom.com>, "j@w1.fi" <j@w1.fi>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Luis,

> I just tried this, it does not work, in fact my own my patches don't work=
 too,
> only the original crap does though for some odd magical reason.
>=20
> Then again, what I tried was:
>=20
> insmod ./sdhci.ko debug_quirks=3D0x8028
>=20
> Was that what you wanted me to try?

Yes. I assume this would have helped also (assuming that the original
patchset was working), but looks like more investigation is needed.

> 03:0a.1 0805: 1524:0750

Okay, so you have PCI_DEVICE_ID_ENE_CB714_SD and not
PCI_DEVICE_ID_ENE_CB714_SD_2 (just in case they need to be dealt
differently).

> > And does it make a difference if you use the SDIO-WLAN card or a standa=
rd SD
> > memory card?
>=20
> Um, I don't have physical access to the box, Naveen or Vipin would have to
> test this.

Might be worth.

Thanks,

    Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2S4AAACgkQD27XaX1/VRuvbQCfc+1lMWoAVlu5qpLiQFCaW2Zb
XQIAni/jjHdZVeTrZ4Y0nsiszXY7nVWm
=Fg1B
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
