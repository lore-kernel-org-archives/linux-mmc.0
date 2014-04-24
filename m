From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 34/38] mmc: add support for power-on sequencing through DT
Date: Thu, 24 Apr 2014 11:05:51 +0200
Message-ID: <20140424090551.GW24905@lukather>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2XY-0003wa-3n@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w1TwAseT95X423KH"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1Wd2XY-0003wa-3n@rmk-PC.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--w1TwAseT95X423KH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Wed, Apr 23, 2014 at 08:09:04PM +0100, Russell King wrote:
> From: Olof Johansson <olof@lixom.net>
>=20
> This patch enables support for power-on sequencing of SDIO peripherals th=
rough DT.
>=20
> In general, it's quite common that wifi modules and other similar
> peripherals have several signals in addition to the SDIO interface that
> needs wiggling before the module will power on. It's common to have a
> reference clock, one or several power rails and one or several lines
> for reset/enable type functions.
>=20
> The binding as written today introduces a number of reset gpios,
> a regulator and a clock specifier. The code will handle up to 2 gpio
> reset lines, but it's trivial to increase to more than that if needed
> at some point.
>=20
> Implementation-wise, the MMC core has been changed to handle this during
> host power up, before the host interface is powered on. I have not yet
> implemented the power-down side, I wanted people to have a chance for
> reporting back w.r.t. issues (or comments on the bindings) first.
>=20
> I have not tested the regulator portion, since the system and module
> I'm working on doesn't need one (Samsung Chromebook with Marvell
> 8797-based wifi). Testing of those portions (and reporting back) would
> be appreciated.
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++
>  drivers/mmc/core/core.c                       | 42 +++++++++++++++++++++=
++++++
>  drivers/mmc/core/host.c                       | 30 ++++++++++++++++++-
>  include/linux/mmc/host.h                      |  5 ++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentatio=
n/devicetree/bindings/mmc/mmc.txt
> index 9dce540771fb..b9b534ebc0c5 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -5,6 +5,8 @@ these definitions.
>  Interpreted by the OF core:
>  - reg: Registers location and length.
>  - interrupts: Interrupts used by the MMC controller.
> +- clocks: Clocks needed for the host controller, if any.
> +- clock-names: Goes with clocks above.
> =20
>  Card detection:
>  If no property below is supplied, host native card detect is used.
> @@ -39,6 +41,15 @@ If no property below is supplied, host native card det=
ect is used.
>  - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
> =20
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)

That probably can use the reset frameworks bindings and the reset-gpio
driver Philipp Zabel has been working on.

> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card

I'm not sure this is the right path.

This looks pretty harmless for now, but I'm pretty concerned that it's
just going to be an ever-increasing list of properties to deal with
the various corner-cases everyone has, like for example how to enforce
a given frequency for that card_ext_clock, or the fact that it has
several SDIO cards connected to them, each with different
clocks/reset/regulator lines.

While all of this would easily be solved by representing all this as a
bus, like it should, with subdevices grabbing their own clocks and
having whatever property they need.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--w1TwAseT95X423KH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTWNPuAAoJEBx+YmzsjxAgrmYP/0y/KX4/3Y3p5VzzaamiErJ0
8PdBFVEoNolAl00l3AueyGiYSZrwebSWYl3H5G7GGRv5bHKl3bUQ7RWaGUHXLacX
utsEbqcl3jbnIxZfHKPtfaf5l6jKwTtjQQRa6oCXbJsuGmUzwSp7A+GEBIghM1/+
LPDSkKIg7+mQsPo7/E4wKrJsQzra549twajoe6UelBqwxu7bl/qw6ReYbiuF0zFM
dGhrvbd/kBqowmv3N2a+zwWwgsv/KEt1kdVdhoi12ZM3qP8f8Wodqub64MYUxgw5
x13WfmrbqHz6v0OQrYQKUZUQsQ/ePhCafdo1ToCN75nZ4p4O7ONFiuYRl2amzTKU
/ZoUPZhPzAX5Ce4Z31J/I2QNM5r7yhEElFUdrFvf4UAJZoHPBGolnu0nL2aL8PlL
IEweyeTwv9MDhu9HsGYR9WkZ4WeWIXNanPqJ6s5qRU8oI5gqnhFErSDqdxKk3OxV
OZj4VFKSfWyif/MMMn/SSkWZ31XVcAxxU4ZULnKX+8jpM7rJVN+7OMaJrr2Rz3/2
Dv3v8SrDLIXOvcObojH3LcnjodjdNYWJTFNee5HcuOD+LHPL+j+A/A5xm51Rb17O
QTJWOydbNqj0l8N/MZL5YXLE66DMJ4h9DA3HGLM5Sc3y7fofDs4G85gSr3Thr5LC
pkUq9JsK8JTy5MQDSgtb
=Kb1K
-----END PGP SIGNATURE-----

--w1TwAseT95X423KH--
