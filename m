From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 09/12] ARM: sunxi: dt: Add sample and output mmc clocks
Date: Sat, 13 Sep 2014 10:18:04 +0200
Message-ID: <20140913081804.GY31276@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DQpa7ozeLWh50je8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58893 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751721AbaIMIUG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 13 Sep 2014 04:20:06 -0400
Content-Disposition: inline
In-Reply-To: <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, Chris Ball <chris@printf.net>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--DQpa7ozeLWh50je8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2014 at 06:23:02PM +0800, Chen-Yu Tsai wrote:
> >                 mmc0: mmc@01c0f000 {
> >                         compatible =3D "allwinner,sun4i-a10-mmc";
> >                         reg =3D <0x01c0f000 0x1000>;
> > -                       clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
> > -                       clock-names =3D "ahb", "mmc";
> > +                       clocks =3D <&ahb_gates 8>,
> > +                                <&mmc0_clk>,
> > +                                <&mmc0_sample_clk>,
> > +                                <&mmc0_output_clk>;
> > +                       clock-names =3D "ahb",
> > +                                     "mmc",
> > +                                     "sample",
> > +                                     "output";
>=20
> Just a stylish nitpick. All the other resources in these files
> are listed inline if possible, not one phandle/value per line.

Look at the PIO interrupts, every USB PHY resources, etc. ;)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--DQpa7ozeLWh50je8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUE/28AAoJEBx+YmzsjxAglwgQAICpU/mjt9ErJopXUK6seJAa
sHr/xqG4xVCtSD4pVBeRSliZMb39fRnXu0BzNFtA0Otn56Z7bGYV19AwI7NTimvb
CMzamMbza+T5W8pm15Fnsgae3oBSWPbfvWDnpFdPo8SQLp0Vtgsoc1CUQ1sP4UXZ
fZ0kANukwDo+TDAstrJiNpGVvwSQ5X8dUOgj/VYo9uLmtlfuBWrQNAokkKOfq5Qv
OvBFoEkhSmXDoYCgw7QzN8m8ARIsEqX6oHzVlqfweUHv8cp8E9gWPxZ70ORchM6w
W/WwojL7IIw2VfKeraSZJ+lC5zB+LOGIlHg78EYFHAdVUAlkeM6RHHg/x8y/a5Dq
eWtnVeTftN645bYudovFRZ/pgkPDA4jew2TfzPuLXsQTyYCv23qlZFmOiiu1XGmZ
oURgVmR4G5Mb5oX9j8ypI7flnA4YKwlBykf774X7sxw2Is/4jAw5FM/5D3dFxkqU
prdx3iJNBVxWpEoa/XtfunWkIpYhyByrfr0m6MENjGnZe+MrN1nZk6Te0XVIwVY9
C6Kxc77e6X+iQP4HIpMzobksGjuQpxbJ0QdGA5sk/qEAWqs7epH3bzEWOyejpUn4
umMRd6ve9gjslMTG8Jg2w0IgpGmcACzGskQVw5/5pSlxpmrBZku2eIOBXVnbCMQp
lMrzmX1gIu6HlyLV4Bjg
=e1AX
-----END PGP SIGNATURE-----

--DQpa7ozeLWh50je8--
