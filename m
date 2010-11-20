From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC]  sdhci: 8 bit bus width changes
Date: Sat, 20 Nov 2010 13:35:53 +0100
Message-ID: <20101120123553.GA11936@pengutronix.de>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com> <20101119214002.GA19272@void.printf.net> <20101119215333.GB19272@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57401 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0KTMgH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Nov 2010 07:36:07 -0500
Content-Disposition: inline
In-Reply-To: <20101119215333.GB19272@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I know it's too late, but...

On Fri, Nov 19, 2010 at 09:53:33PM +0000, Chris Ball wrote:
> On Fri, Nov 19, 2010 at 09:40:02PM +0000, Chris Ball wrote:
> > I don't see why we should re-read ctrl here, since we've already written
> > it back to the device at this point, and we don't use it anywhere below
> > this line.
>=20
> Ah, I see why now; please ignore this.=20
>=20
> Here's a rebased version of the patch, with some more comments:
>=20
> From: Philip Rakity <prakity@marvell.com>
> Date: Fri, 19 Nov 2010 16:48:39 -0500
> Subject: [PATCH] mmc: sdhci: 8-bit bus width changes
>=20
> We now:
>  * check for a v3 controller before setting 8-bit bus width
>  * offer a callback for platform code to switch to 8-bit mode, which
>    allows non-v3 controllers to support it

What does the platform_-prefix of the callback indicate?

>  * introduce a quirk to specify that the board designers have indeed
>    brought out all the pins for 8-bit to the slot.

This is not a quirk, this is platform_data, no?

> We were previously relying only on whether the controller supported
> 8-bit, which doesn't tell us anything about the pin configuration in
> the board design.
>=20
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Chris Ball <cjb@laptop.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkznwKkACgkQD27XaX1/VRs3wQCgtYtv/UxPP/ebo9zf++l16N1t
uWIAoIH1HrQbhVafedotWgT2Qa1GuB4a
=ZYq6
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
