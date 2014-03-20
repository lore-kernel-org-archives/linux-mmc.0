From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7 1/8] clk: sunxi: factors: automatic
 reparenting support
Date: Thu, 20 Mar 2014 10:47:17 +0100
Message-ID: <20140320094717.GL27873@lukather>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100215.15040.63745.stgit@pagira.o2s.ch>
 <20140218140516.GG3142@lukather>
 <20140319233945.21989.12073@quantum>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n5G3y24fV3/VEqbx"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBPUAYGMQKGQETPXKZAY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140319233945.21989.12073@quantum>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--n5G3y24fV3/VEqbx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2014 at 04:39:45PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-02-18 06:05:16)
> > On Mon, Feb 17, 2014 at 11:02:15AM +0100, David Lanzend=F6rfer wrote:
> > > From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> > >=20
> > > This commit implements .determine_rate, so that our factor clocks can=
 be
> > > reparented when needed.
> > >=20
> > > Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> >=20
> > Your signed-off-by is missing here.
> >=20
> > Once you added it, you can add my Acked-by
>=20
> Yes the patch looks good to me as well. Am I correct in thinking that it
> is independent of the MMC clock phase discussion? If it is resubmitted
> with a proper SoB then I can pick it.

Yes, it's completely independant of the MMC phase stuff.

Emilio, or David, could you resend it?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--n5G3y24fV3/VEqbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKrklAAoJEBx+YmzsjxAgy/gP/21KggiKLJZbO5WGulCJ+yRI
bQ1WFh08X8ExEko9bvU2PlA90B6XS9ed4+kAmvncIXbTxBelAE7UqyIEyCcXkfPR
pdZG0TQeZTMvNpK+Ml2G/Ulz4iw0jZ0iTj6RBajh9LjX/LPVlxYYJCfH1H0xkGPm
zXoKlRe0lFu7YFSmuy7qP4YSf6MSmO4YeRlcJOyCXX7f40w6CJsmBEfj52Wa9lAo
95fDz1ZhgbFpGHvbBF18q9J8zgZ0gpYH/D2OoSP0wgNAwxnJIz5QFyokYk94+uZh
WwwsiuIvTdcrnKEy/CQ+biPNhxhWxPVkjM0xhOeH3Dyqqz7NbSfh21RnFsx32WZZ
Z01OONj+izIhOO/sRCq/VXGNXdwQ7x+QWDmjs+u25//HnMLKU/V9kcts2+as0/H8
wNyMmHQO8CXYfl7wFD+FWJETjcXf3++Qhzyomldt0CiGqAZLMAj5RaE0LJ9Jh24r
jwXZrXPx+CszVPe2OGZFcLSWEhi48Qwo7dfakKhCYI/bdfy6BQbwW5StrDHuc+jf
RA0hhLbRX2vHXH/uRYa3BV1BHm+qoqFDObUg50vJbqblQluzfOzUAPAAcCK79thX
LnM54cmbSnVeA+ZakWMBPUM2Y9RQcds/HQ+s/sZAb0Z7Zi8jPkP7mdI3ITuypbfy
K1aMmwOJsrUemyWsSEEp
=1gCp
-----END PGP SIGNATURE-----

--n5G3y24fV3/VEqbx--
