From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 8/13] arm64: allwinner: a64: Add MMC nodes
Date: Wed, 25 Jan 2017 10:17:36 +0100
Message-ID: <20170125091736.drdon6yjyjwngtja@lukather>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <ac77b9e25e7633886822cd1f1ebafd5985751ae4.1484585798.git-series.maxime.ripard@free-electrons.com>
 <20170116191641.GA11718@Red>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="euudstos324xtp52"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51202 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdAYJSI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 04:18:08 -0500
Content-Disposition: inline
In-Reply-To: <20170116191641.GA11718@Red>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org


--euudstos324xtp52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Corentin,

On Mon, Jan 16, 2017 at 08:16:41PM +0100, Corentin Labbe wrote:
> On Mon, Jan 16, 2017 at 05:56:58PM +0100, Maxime Ripard wrote:
> > From: Andre Przywara <andre.przywara@arm.com>
> >=20
> > The A64 has 3 MMC controllers, one of them being especially targeted to
> > eMMC. Among other things, it has a data strobe signal and a 8 bits data
> > width.
> >=20
> > The two other are more usual controllers that will have a 4 bits width =
at
> > most and no data strobe signal, which limits it to more usual SD or MMC
> > peripherals.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +++++++++++++++++++=
+-
> >  1 file changed, 39 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64=
/boot/dts/allwinner/sun50i-a64.dtsi
> > index 99b6bb1e141c..143e9706438f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -299,6 +299,45 @@
> >  			#size-cells =3D <0>;
> >  		};
> > =20
> > +		mmc0: mmc@1c0f000 {
> > +			compatible =3D "allwinner,sun50i-a64-mmc";
> > +			reg =3D <0x01c0f000 0x1000>;
> > +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> > +			clock-names =3D "ahb", "mmc";
> > +			resets =3D <&ccu RST_BUS_MMC0>;
> > +			reset-names =3D "ahb";
> > +			interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mmc1: mmc@1c10000 {
> > +			compatible =3D "allwinner,sun50i-a64-mmc";
> > +			reg =3D <0x01c10000 0x1000>;
> > +			clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> > +			clock-names =3D "ahb", "mmc";
> > +			resets =3D <&ccu RST_BUS_MMC1>;
> > +			reset-names =3D "ahb";
> > +			interrupts =3D <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mmc2: mmc@1c11000 {
> > +			compatible =3D "allwinner,sun50i-a64-emmc";
> > +			reg =3D <0x01c11000 0x1000>;
> > +			clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> > +			clock-names =3D "ahb", "mmc";
> > +			resets =3D <&ccu RST_BUS_MMC2>;
> > +			reset-names =3D "ahb";
> > +			interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> >  		gic: interrupt-controller@1c81000 {
> >  			compatible =3D "arm,gic-400";
> >  			reg =3D <0x01c81000 0x1000>,
>=20
> Hello
>=20
> It seems that mmc node is after i2c@1c2b400 so not in address order.

You're right, I'll fix this in the v3.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--euudstos324xtp52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiG0wAAoJEBx+YmzsjxAgomoP/Aq4mD36QumkjSD3y/XxWqvc
WppvdXfSd79XZ+mTR5M/pXmnDjXQcI8x3aksjslOBHD/A9heQi/pJ47aqgK9j3w9
Qs9o9WBybgsLNEkmlQblGjPdpBa8rB2SnZq4ADR3U0jC9xDe8dnOtu2o+dJo7eRH
QhqNZKOhIxKV5m5LaigED8XZGlyWcNhzmeawG2eJeX4XWA4AzIa1KNMcVy0EJ3V5
Q1XIzxYTRGBHMnZT4KEpzNyJ+ZsTZ9qomYKfLEVNLbXXifr4OTLNX/AACJ2FGyCI
a+wpxdP4r0kIT+uYYWl4d8UOIykaZNCNJPhtbJbHYxT7ly5FIVUZZ76HDC8K56MA
JHtuwUDX2QeM95kD9J+iEZNGSC5WrR8zP3tFxabEudpPxQY4FPBUp4jnVzMrIpAS
L7DG4Hw/G5J11YvfSzHgGBY1x82ws+zNF55wufK8pfdCauZLTYF8qOiQTDdNui5t
LtMwveIYbs8QoCG2zQNx7xPaFPclV6YwqkjqUAZF6iLbmEev2eZWeDm8TXexkQOy
wCZX9atY0uX7nhLB/EH1L7Oq2X3gwOO6WzY8cbdCHtR2VwtCjwKX2nIBmatAKYuG
9kyHqIgSd7aIbRr1TZq958GLBrx7rgiO/UIEQawP7OHD2tfC/VLkn7UF+HvQ6aAy
QFkaOv1/6hcFAi/6hXBK
=5Zn5
-----END PGP SIGNATURE-----

--euudstos324xtp52--
