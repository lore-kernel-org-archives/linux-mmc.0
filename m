From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 6/6] arm64: allwinner: a64: Increase the MMC max
 frequency
Date: Wed, 11 Jan 2017 14:38:04 +0100
Message-ID: <20170111133804.m73q5u54qs3qhwe2@lukather>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <3689701f93c8426bfa476e9a5f31c3642a8a898e.1483980339.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67JoOAtHjMJboNUdCDX=+=Hf+zOWr234rT7GEiUmPb=nQ@mail.gmail.com>
 <20170110191514.kgbesffn3xqltnol@lukather>
 <CAGb2v64vU5soFybaurCKu1HE9FNo=-NGiy33ZVeoR6E7m4kk6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvv63k6iutwmeidz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v64vU5soFybaurCKu1HE9FNo=-NGiy33ZVeoR6E7m4kk6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--kvv63k6iutwmeidz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 02:44:00PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 11, 2017 at 3:15 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Hi,
> >
> > On Tue, Jan 10, 2017 at 01:01:20AM +0800, Chen-Yu Tsai wrote:
> >> On Tue, Jan 10, 2017 at 12:46 AM, Maxime Ripard
> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> > All the controllers can have a maximum frequency of 200MHz.
> >> >
> >> > Since older SoCs cannot go that high, we cannot change the default m=
aximum
> >> > frequency, but fortunately for us we have a property for that in the=
 DT.
> >> >
> >> > This also has the side effect of allowing to use the MMC HS200 mode =
for the
> >> > boards that support it (with either 1.2v or 1.8v IOs).
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> > ---
> >> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
> >> >  1 file changed, 3 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/ar=
m64/boot/dts/allwinner/sun50i-a64.dtsi
> >> > index 8e149498e096..f46ae965cf5b 100644
> >> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> > @@ -332,6 +332,7 @@
> >> >                         resets =3D <&ccu RST_BUS_MMC0>;
> >> >                         reset-names =3D "ahb";
> >> >                         interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HI=
GH>;
> >> > +                       max-frequency =3D <200000000>;
> >>
> >> You also have to set one of MMC_CAP2_HS200* in the driver,
> >> or mmc-hs200-1_8v or mmc-hs200-1_2v in the device tree to
> >> actually use HS200, right?
> >
> > Yes, but that requires a board with 1.8V IOs to work properly, which
> > not all board use, so it's probably best to enable it in the board
> > DTS.
>=20
> It's limited by the vqmmc regulator. Either way the host controller
> supports it right?

Yes, but if the card supports HS200 with 1.8V, and the controller
reports it too, the core will pick that mode and will try to switch to
it, which in turn will fail, making the card initialisation fail as
well.

We basically have two choices: either we ask all the boards that
support it to set mmc-hs200-1_8v in their DTS, or we set it in the
DTSI and we have the boards set no-1-8-v in their DTS if they do not
support those modes.

The first case is just the more convenient, because so far we've only
seen one non-upstream (yet) board that supports 1.8V IOs. All the
other do not.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--kvv63k6iutwmeidz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYdjU4AAoJEBx+YmzsjxAgrdIP/3J/ENwL7bYGh4hvZKHkxTcI
2gEEFDhgQqwqRQjrxexuTdXoWBN6FnHoHl83CX/6HVq7aVD5EXKl4V7jsK95mJJc
EnAbBRcZnvVjWA0YP+uHgO0wC21FLwTDG1JwfOKJVfBKJlELSqvu2Tn3S5ATTj59
RtuN+oC9yzc606cQcbu6Z7z8Nxwmatr84KdK7wMJfDcTaOgVsSRpEFB3ewua1uSp
+7MsLnxNOX9ZQPQ+W2hLIwMKEvbFBk8O/iDApRlY5CtmhycLifUXs0jz38nQ8DxT
nMxl91GJdevcNvHOMLzclApAg1zQ9YAu2J5HfwI6epFykSyswA8dpgAQ94K3YQAO
ChG/Lfov+xBy+NevoPBb4RpAbWTZU5x8qTwhSL0JQQp5ESoR1XWiE00QmTXjsY9k
yE/Hzk5HaUMkprdiSnv2ZIb0cGN4DWj1BMMAQPT6ydj4c7avv82d8OXAbOVrWsCI
aWN769yseDgCRBRvHSpvmtCssOa/8DUpOEnOwtDgsyjBhqJfLbdc9cY5Pnidruk3
sXj2/79JuPZWkip+IrtG/MfjW121HAUB+bZXSqG1hh20SHgtkKzOMDAJ+wdAXV5H
eAFupS5I25PRfe/ulqAItpD35xxfa0DEl10UKLJtRP6eIJ4iX5V6hpEJmQxVo2vQ
3dw72PzP2mzA1DnQaCOo
=9kty
-----END PGP SIGNATURE-----

--kvv63k6iutwmeidz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
