From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC 0/4] sdhci: few patches for ENE 712 support
Date: Sat, 19 Mar 2011 10:15:44 +0100
Message-ID: <20110319091544.GA16635@pengutronix.de>
References: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51065 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab1CSJPt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Mar 2011 05:15:49 -0400
Content-Disposition: inline
In-Reply-To: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, vmehta@atheros.com, naveen.singh@atheros.com, kvalo@adurom.com, j@w1.fi


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I prefer code upstream though so here is my split and cleanup
> of these patches. I've tested it with my ENE card. Since I am
> new to SDHCI I would prefer someone with more experience review
> these chagnes and the respective commit log messages. I've
> tried to make sense of them as best as I can. Unfortunately
> I was not given any explanation to these changes except the
> patch I got so I tried to make the best of it.

You did make the best out of it; still, you probably won't be surprised to =
hear
that all the patches are, well, not acceptable ;) I agree with Chris about =
1/4,
I think 2-4 are for a broken card detection and there is already a quirk for
that. So you could also try dropping 2-4 and use

	sdhci.debug_quirks =3D 0x8028

That should enable the standard quirks for this card and BROKEN_CARD. Can y=
ou
alsso please post the PCI-ID of this card? And does it make a difference if=
 you
use the SDIO-WLAN card or a standard SD memory card?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2EdEAACgkQD27XaX1/VRtHfACbBYbyJo3hH4A7IJptE5WI0Aoe
jbIAnRw0Zx5yA1SJWQLpw4WgM4fYcpsw
=Ilvb
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
