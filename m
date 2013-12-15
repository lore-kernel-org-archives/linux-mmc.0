From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/5] ARM: dts: sun5i: Add new
 sun5i-a13-olinuxino-micro board
Date: Sun, 15 Dec 2013 15:04:57 +0100
Message-ID: <20131215140457.GG3651@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-4-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U5yJ31ax00IavOwq"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBG7OW2KQKGQEN6YLNCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387058295-20641-4-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--U5yJ31ax00IavOwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2013 at 10:58:13PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Commit log :)

Please detail what the board is, what features it has, etc.

Other than that, I'm mostly ok with this patch (except that you can
also probably add your copyright, but that's your call :))

Could you send it as a single patch, separate from this serie (since
it's not really related in the end).

Thanks!
Maxime

> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts | 66 +++++++++++++++++++=
++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d57c1a6..b663ed7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -255,6 +255,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D \
>  	sun4i-a10-hackberry.dtb \
>  	sun5i-a10s-olinuxino-micro.dtb \
>  	sun5i-a13-olinuxino.dtb \
> +	sun5i-a13-olinuxino-micro.dtb \
>  	sun6i-a31-colombus.dtb \
>  	sun7i-a20-cubieboard2.dtb \
>  	sun7i-a20-cubietruck.dtb \
> diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/b=
oot/dts/sun5i-a13-olinuxino-micro.dts
> new file mode 100644
> index 0000000..26df7e8
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright 2012 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun5i-a13.dtsi"
> +
> +/ {
> +	model =3D "Olimex A13-Olinuxino Micro";
> +	compatible =3D "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
> +
> +	soc@01c00000 {
> +		pinctrl@01c20800 {
> +			led_pins_olinuxinom: led_pins@0 {
> +				allwinner,pins =3D "PG9";
> +				allwinner,function =3D "gpio_out";
> +				allwinner,drive =3D <1>;
> +				allwinner,pull =3D <0>;
> +			};
> +		};
> +
> +		uart1: serial@01c28400 {
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&uart1_pins_b>;
> +			status =3D "okay";
> +		};
> +
> +		i2c0: i2c@01c2ac00 {
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&i2c0_pins_a>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1: i2c@01c2b000 {
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&i2c1_pins_a>;
> +			status =3D "okay";
> +		};
> +
> +		i2c2: i2c@01c2b400 {
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&i2c2_pins_a>;
> +			status =3D "okay";
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&led_pins_olinuxinom>;
> +
> +		power {

Could you add a label here?

Something like a13-olinuxino-micro:green:power ?

> +			gpios =3D <&pio 6 9 0>;
> +			default-state =3D "on";
> +		};
> +	};
> +};

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--U5yJ31ax00IavOwq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSrbcJAAoJEBx+YmzsjxAgCj8P/jPwluzCPU5XUTuVKMMzdZcB
e6tDSjjMb6Kvab0Imdbqvt/0zsKP5tTOoVfadUAd+MSkz7Tgb7eglon/k93woTl8
sVrWrj0WHu71JZ72SOpME4YS9Pt26uZ65sBmuZ+HMU6AA4l+b+ILUYBxPpemCOe6
LNURNCYpfo4118tPydf11TW5auvOmjHgZM+dzT8v0YWKQWawKmFPYvv9dDln16Gt
3b6xFPGdI6Q7i76zFmaixShd7hUVzBU9J1CluPjaLzUiq4xggojfYp46rXcnf2l7
9wW9It7S1wmyemrUWncNvfy58HZDnPdsnmqkVUAh1UnPhpstkVtC7EYko3CkzDdv
AsESd6SZHLv0FrCAOQxgVWbrj0PAyNQ1Pe9EP20wlfDp1FrY8+0rlzRbg4ZikJ1k
51RcRHdZuPey4287Pm5+pboMfN0gRQAXM+ZimcXTk1wpKqGAUCKqZTEig98yjkcN
t+9ilYTOQ5cHEEPbiCP1T1W4n1cl1WFq7yugfEm+68kC7bhnXnq1oEqHkODU+iq4
+u6FRs4fNQ1v++iaif9p2v70uLWGKmSgTBxMEIjqjeS8grsXH1NzjehvR5qmXIBu
eTeLEsNtUndwBhEzGGUMMmSgUzn//pB3YRzWilA/awcSmmPiPhhztMrH4AEqBfqu
tzr4wMOGbMUaE31A4hB0
=eyhR
-----END PGP SIGNATURE-----

--U5yJ31ax00IavOwq--
