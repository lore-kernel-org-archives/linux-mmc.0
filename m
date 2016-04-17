From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Sun, 17 Apr 2016 14:49:03 +0200
Message-ID: <20160417124902.GB4954@katana>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
 <1460477978.32355.14.camel@codethink.co.uk>
 <20160415202803.GA3105@katana>
 <20160415204156.GB3105@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160415204156.GB3105@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 10:41:57PM +0200, Wolfram Sang wrote:
> > > That seems like a bug in the clock driver.  If it doesn't have
> > > independent dividers for each clock client then it shouldn't allow any
> > > client to change the frequency.
>=20
> So, we need MSTP clocks which do not use CLK_SET_RATE_PARENT on r8a7740.
> Probably the best way is to use the "renesas,r8a7740-mstp-clocks"
> compatible entry to determine the difference? Geert?

Well, I like the idea of a virtual sd clock even better. I sent a series
doing that a minute ago to the renesas-soc list.


--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXE4Y+AAoJEBQN5MwUoCm2WNcP/jcJQo23S2UFgarPvsWvVReS
NIw8dCQ+Gxcw/iR9s0te0xUvNX8bKpNtD6ng5bNH4+F8KcKzxWDDF5Wm8/KcvZ69
VJDfPs4AnFCnT8vrfz+sdJOwXn6k+NifdvVaKfQrdHyv6XuCyB4i6bJm1QkTlWvM
eWTLQN9m2eR8T0G9z6G+3rllKNUd1VTptqm55UM3ww2gDI7Egkp1kI2UDBppdApl
QrtOtg3LlQjSunJ3g4vd+RJADShLmHplkGj/5DeT3x/77TpL/MsDtn1s00sipJQi
G7zk/2etvUuiVewYeG6I37k7cAQahUErd9KzlrrZTdwM+jac7pY+sMAvo9rtjY4F
OAv7KYrDCvvnfM3kmUTV/Q6okEexKN4tkr4eGU++UK21NMYR07DxwQlzaFK6IyJ3
IWvY1ZffQ/jgG31KtHZ9DNgEpgD12xgJ3vsq7LVa9Q05VGcqezRjajahkl3PKG0s
AeSrJv0MSbhVrdEfmgwd6UGe3h/VfVJM5N36PA/WTajin1zyXz/+JCkypZjqWJZr
HIK1fwD42p1y5PNkaB8PF/485THVC6CHevle/807blvLIDegNo97tfXdUoUQSYBk
TerfkACXr9+YELOpPr20kfpHIS84R+IyQFBKESp2Ow41v/xK0O0onvS50aZHZQrI
5m1JVhA1SSkgF5x+ZiJT
=StmS
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
