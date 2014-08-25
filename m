From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 07/14] clk: sunxi: Introduce mbus compatible
Date: Mon, 25 Aug 2014 17:18:47 +0200
Message-ID: <20140825151847.GD15297@lukather>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1405588134-2396-8-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64xzwySFcnhAAmPFvUOWGechLZpoxfmb0OmEGOZbV+58Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDa9Kr4PlLWO/T7L"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37456 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754580AbaHYPUH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Aug 2014 11:20:07 -0400
Content-Disposition: inline
In-Reply-To: <CAGb2v64xzwySFcnhAAmPFvUOWGechLZpoxfmb0OmEGOZbV+58Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, Chris Ball <chris@printf.net>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


--IDa9Kr4PlLWO/T7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 10:17:37PM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> On Thu, Jul 17, 2014 at 5:08 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Even though the mbus clock is a regular module clock, given its nature,=
 it
> > needs to be enabled all the time.
> >
> > Introduce a new compatible, to differentiate it from the other module c=
locks.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
> >  drivers/clk/sunxi/clk-sunxi.c                     | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Docume=
ntation/devicetree/bindings/clock/sunxi.txt
> > index d3a5c3c6d677..112d8525b6e0 100644
> > --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> > +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> > @@ -46,6 +46,7 @@ Required properties:
> >         "allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
> >         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
> >         "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
> > +       "allwinner,sun4i-a10-mbus-clk" - for the MBUS clock on A10
>=20
> This should probably be sun5i-a13-mbus-clk?
> AFAIK the A10 doesn't have MBUS.

Ah, right, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--IDa9Kr4PlLWO/T7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+1PXAAoJEBx+YmzsjxAgJ7EQAI15/xQ2wCQScV67ZZP6W6N6
zR2+MZy941REJbPjAkPg/C4a+Fwl0se99TPO/fMsTFJ3VDqe/YQu6800qlDt5ka1
T4S/NS9JGNuJPLtZTL6durVyoTvR82HDJFN6GF8V3/9vHEzDXlzUX/TQk5PcHe64
rFza7jPpw/dfib5GeHQSa31ReLX0RSEWaGrMX+CmCM83kBbYiTUrqvyNXMOd+/xo
ClrcOXSAMRbCDOGD0Uof0J60TRxoQ9D3EOX90A/KslQWJyN8XFaqj/VeICjRJmmU
e143T2yvKzeh0NEMZxW5ZAFF5X/0ESuGh3Lgi/vew37pw2aUqS66bvvojg4beEnj
jfueCafENOykDIl7vBDsekXjKEEMvRt560rA1joFAlA+UbiysjXga5RW/nOpW+PU
q4bGot6n7qLw4YirZ2rvlBNwEorpM7gpxKylfb7n607x44F8NnlbgsPrKC2PrXEX
4iI1bSTbVJnezX1LAxaRkGz61qzOJPDsC8QxihZq8Gn4N8kGVzVK73nrHlGtCCsj
OevlttLqyHoEHefcNXYiodfQ3P7iU3FSDdJhGv2RgdQFXaJFvoaMbWqYjohEnfFU
RRUq9IsAo6tBd6nD2M429bKxTsNmjqNhF14ki0RKtuVFQgYV3TEg1X+RspIwY7HW
ykV+BOL7ByZUjWSnwMvy
=t0aE
-----END PGP SIGNATURE-----

--IDa9Kr4PlLWO/T7L--
