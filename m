From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 3/3] mmc: fix a warning when compile the
 sdhci d.d.
Date: Mon, 27 Sep 2010 16:17:25 +0200
Message-ID: <20100927141725.GJ2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-3-git-send-email-peppe.cavallaro@st.com>
 <20100927105413.GE2664@pengutronix.de>
 <4CA094CB.1060209@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57270 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932938Ab0I0OR0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 10:17:26 -0400
Content-Disposition: inline
In-Reply-To: <4CA094CB.1060209@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > should detect that BUG never returns). The include-removal could be in a
> > seperate patch, not sure if it is worth, though.
>=20
> It can include in a separate patch.
> It makes sense if apply the previous patch to split the header file
> because we remove duplicated include files.

I understand, but I am still sceptical. If the source file itself uses
something from the h-file, it should include it IMHO. Don't know if it
is common sense this way.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygp3UACgkQD27XaX1/VRt1LQCePuh7c6njusvzbjT47mvWDcL7
l1YAnAoD168K6j/D+NjpLmcbxjWjA+NP
=pdN9
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
